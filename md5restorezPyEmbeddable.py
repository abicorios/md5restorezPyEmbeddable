import argparse
import sys
parser = argparse.ArgumentParser(description="My parser")
parser.add_argument('--myto',type=str)
parser.add_argument('--myfrom',type=str)
parser.add_argument('--mycsv',type=str)
parser.add_argument('--myarch',type=str)
parser.add_argument('--myexe',type=str)
def main():
    args=parser.parse_args()
    import os
    import pandas as pd
    from shutil import copyfile, move, rmtree
    import hashlib
    import subprocess, shlex
    import re
    import sys
    def myrmtree(imypath):
        for r, d, f in os.walk(imypath):
            for i in f:
                os.chmod(r+'\\'+i, 0o777)
        rmtree(imypath)
    def myosremove(imypath):
        os.chmod(imypath, 0o777)
        os.remove(imypath)
    def wrap(mystr):
        return re.sub(r'([^\\]|^)\\\?\\([^\\])',r'\1\\\\?\\\2',mystr)
    def wraper(ar):
        return list(map(wrap,ar))
    def U(s):
        return r'\\?\{}'.format(s[0].upper()+s[1:])
    def fend(s):
        if s[-1]=='\\':
            return s[:-1]
        else:
            return s
    def norm(s):
        return fend(U(s))
    
    def md5(myfile):
        hash_md5 = hashlib.md5()
        with open(myfile, "rb") as f:
            for chunk in iter(lambda: f.read(4096), b""):
                hash_md5.update(chunk)
        return hash_md5.hexdigest().upper()
    def drop(x,sep):
        return sep.join(x.split(sep)[:-1])
    def isempty(folder):
        if len(os.listdir(folder))>0: return False
        else: return True
    def p(a):
        print(a)
        sys.stdout.flush()
        #print(a.replace(myfrom,'').replace(myto,'').replace(exe,'').replace(mybuffer,''))
        f.write(str(a)+'\n')
    def nfolders(somepath):
        n=0
        for i in os.listdir(somepath):
            if os.path.isdir(i):
                n+=1
        return n
    
    def narchives(somepath):
        n=0
        for i in os.listdir(somepath):
            if mytype(somepath)=='archive':
                n+=1
        return n
    def mytype(ipath):
        if os.path.isfile(ipath):
            if re.search(r'\.(7z|zip|rar)$',ipath):
                return 'archive'
            else:
                return 'file'
        if os.path.isdir(ipath):
            return 'dir'
    def inbuffer(ipath,ibuffer):
        if ibuffer in ipath:
            return True
        else:
            return False
    def myrestore(ipath,ito,ibuffer):
        for i in os.listdir(ipath):
            thisthing=r'{}\{}'.format(ipath,i)
            if mytype(thisthing)=='file':
                m=md5(thisthing)
                if m in list(t['md5']):
                    for j in t[t['md5']==m].index:
                        if not os.path.isdir(r'{}\{}'.format(ito,drop(j,'\\'))):
                            os.makedirs(r'{}\{}'.format(ito,drop(j,'\\')))
                        p(copyfile(thisthing,r'{}\{}'.format(ito,j)))
                        t.loc[j,'processed']=1
                if m not in list(t['md5']):
                    okpath=r'{}\{}'.format(notpath,i)
                    if '.' in okpath.split('\\')[-1]:
                        okpat=drop(okpath,'.')
                        h=okpath.split('.')[-1]
                    else:
                        okpat=okpath
                        h=''
                    if os.path.isfile(okpath):
                        i0=0
                        if h != '':
                            while os.path.isfile('{}{}.{}'.format(okpat,i0,h)):
                                i0+=1
                            p(copyfile(thisthing,'{}{}.{}'.format(okpat,i0,h)))
                        else:
                            while os.path.isfile('{}{}'.format(okpat,i0)):
                                i0+=1
                            p(copyfile(thisthing,'{}{}'.format(okpat,i0)))
                    else:
                        p(copyfile(thisthing,okpath))
                if inbuffer(ipath,ibuffer):
                    myosremove(thisthing)
            if mytype(thisthing)=='archive':
                    mycmd='"{}\\7za" x "{}" -o"{}" -aou'.format(exe,thisthing,ibuffer)
                    p(mycmd)
                    subprocess.call(wraper(shlex.split(mycmd)))
                    if inbuffer(ipath,ibuffer):
                        os.remove(thisthing)
                    myrestore(ibuffer,ito,ibuffer)
            if mytype(thisthing)=='dir':
                if isempty(thisthing):
                    if inbuffer(ipath,ibuffer):
                        os.rmdir(thisthing)
                else:
                    myrestore(thisthing,ito,ibuffer)
    mybuffer=r'\\?\C:\Windows\Temp\md5utils'
    if os.path.isdir(mybuffer): myrmtree(mybuffer)
    #p7zx86=r'C:\Program Files (x86)\7-Zip'
    #p7zx64=r'C:\Program Files\7-Zip'
    #while (not os.path.isdir(p7zx86)) and (not os.path.isdir(p7zx64)):
    #    if inp=='q':
    #        exit()
    #if os.path.isdir(p7zx64):
    #exe=p7zx64
    exe=args.myexe
    #elif os.path.isdir(p7zx86):
    #    exe=p7zx86
    #else:
    #    exit()
    myto=args.myto
    myto=norm(myto)
    if not os.path.isdir(myto): os.mkdir(myto)
    mybase=args.mycsv
    mybase=U(mybase)
    myfrom=args.myfrom
    myfrom=norm(myfrom)
    f = open(r'{}\mylog.txt'.format(myto), 'a')
    archive=args.myarch
    if not os.path.isdir(mybuffer):os.mkdir(mybuffer)
    topath='{}\\{}'.format(myto,drop(mybase.split('\\')[-1],'.'))
    notpath='{}\\Not Included'.format(myto)
    if not os.path.isdir(topath): os.mkdir(topath)
    if not os.path.isdir(notpath): os.mkdir(notpath)
    t=pd.read_csv(mybase)
    t=t.set_index('md5')
    t['doubles']=t.index.value_counts()
    t['pathname']=t['path']+'\\'+t['name']
    t=t.reset_index().set_index('pathname')
    t['processed']=0
    myrestore(myfrom,topath,mybuffer)
    if archive=='yes':
        for i in set(t[t['processed']==1]['path']):
            thisthing=r'{}\{}'.format(topath,i)
            mycmd='"{}\\7za" a "{}.7z" "{}\\*" -mx9 -ms -sdel -mmt'.format(exe,thisthing,thisthing)
            p(mycmd)
            subprocess.call(wraper(shlex.split(mycmd)))
            os.rmdir(thisthing)
    os.chdir(myto)
    myrmtree(mybuffer)
    t=t[['path','name','md5','doubles','processed']]
    t[t['doubles']>1].sort_values('md5').to_csv('doubles.csv',index=False)
    t[t['processed']==0].to_csv('notfound.csv',index=False)
    f.close()
if __name__ == "__main__":
    sys.exit(main())
