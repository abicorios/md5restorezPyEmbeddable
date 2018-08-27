call %USERPROFILE%\scoop\apps\miniconda3\current\Scripts\activate.bat %USERPROFILE%\scoop\apps\miniconda3\current
call activate exe
if exist mybuild rmdir mybuild /s /q
mkdir mybuild
cd mybuild
copy ..\md5restorezPyEmbeddable.py /y
pyinstaller -F md5restorezPyEmbeddable.py
cd ..
copy mybuild\dist\md5restorezPyEmbeddable.exe /y
call deactivate
call deactivate
