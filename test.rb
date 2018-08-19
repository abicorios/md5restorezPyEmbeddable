mto='C:/restored'
if Dir.exist?mto then Dir.rmdir(mto) end
Dir.mkdir(mto)
mfrom='C:/Atari Jaguar/GoodJag (2.01)'
mcsv=Dir['C:/t/Atari*'][0]
$LOAD_PATH.push(Dir.pwd)
require 'myrun.rb'
myrun("call %USERPROFILE%\Miniconda3\Scripts\activate.bat %USERPROFILE%\Miniconda3 && cell conda activate dev && python md5restorezPyEmbeddable.py --myfrom #{mfrom} --myto #{mto} --mycsv #{mcsv}")
