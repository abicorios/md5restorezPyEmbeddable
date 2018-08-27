mto='C:/restored'
#if Dir.exist?mto then Dir.rmdir(mto) end
if Dir.exist?mto then `rmdir #{mto.gsub('/','\\')} /s /q` end
Dir.mkdir(mto)
mfrom='C:/Atari Jaguar/GoodJag (2.01)'
mcsv=Dir['C:/t/Atari*'][0]
$LOAD_PATH.push(Dir.pwd)
require 'myrun.rb'
myrun("call md5restorezPyEmbeddable.exe --myfrom \"#{mfrom.gsub('/','\\')}\" --myto \"#{mto.gsub('/','\\')}\" --mycsv \"#{mcsv.gsub('/','\\')}\" --myarch no")
