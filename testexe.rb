mto='C:/restored'
#if Dir.exist?mto then Dir.rmdir(mto) end
if Dir.exist?mto then `rmdir #{mto.gsub('/','\\')} /s /q` end
Dir.mkdir(mto)
mfrom='C:/Atari Jaguar/GoodJag (2.01)'
mcsv=Dir['C:/t/Atari*'][0]
mexe=`echo %cd%/7z1805-extra`.chomp.gsub('\\','/')
$LOAD_PATH.push(Dir.pwd)
require 'myrun.rb'
def myFixPath(apath)
	return apath.gsub('/','\\')
end
mfrom=myFixPath(mfrom)
mto=myFixPath(mto)
mcsv=myFixPath(mcsv)
mexe=myFixPath(mexe)
start=Time.now
myrun("md5restorezPyEmbeddable.exe --myfrom \"#{mfrom}\" --myto \"#{mto}\" --mycsv \"#{mcsv}\" --myarch no --myexe \"#{mexe}\"")
finish=Time.now
puts finish-start
