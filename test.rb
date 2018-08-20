mto='C:/restored'
#if Dir.exist?mto then Dir.rmdir(mto) end
if Dir.exist?mto then `rmdir #{mto.gsub('/','\\')} /s /q` end
Dir.mkdir(mto)
mfrom='C:/Atari Jaguar/GoodJag (2.01)'
mcsv=Dir['C:/t/Atari*'][0]
$LOAD_PATH.push(Dir.pwd)
require 'myrun.rb'
puts "call %USERPROFILE%\\Miniconda3\\Scripts\\activate.bat %USERPROFILE%\\Miniconda3 && call conda activate dev && python md5restorezPyEmbeddable.py --myfrom \"#{mfrom.gsub('/','\\')}\" --myto \"#{mto.gsub('/','\\')}\" --mycsv \"#{mcsv.gsub('/','\\')}\" --myarch no"
myrun("call %USERPROFILE%\\Miniconda3\\Scripts\\activate.bat %USERPROFILE%\\Miniconda3 && call conda activate dev && python md5restorezPyEmbeddable.py --myfrom \"#{mfrom.gsub('/','\\')}\" --myto \"#{mto.gsub('/','\\')}\" --mycsv \"#{mcsv.gsub('/','\\')}\" --myarch no")
