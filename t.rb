$LOAD_PATH.push(Dir.pwd)
require 'myrun.rb'
myrun("call %USERPROFILE%\\Miniconda3\\Scripts\\activate.bat %USERPROFILE%\\Miniconda3 && python -V")
