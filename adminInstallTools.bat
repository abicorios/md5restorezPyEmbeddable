set f=0
where choco /q
if not %errorlevel%==0 (@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
set f=1)
where scoop
if not %errorlevel%==0 (@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser; iex (new-object net.webclient).downloadstring('https://get.scoop.sh')"
set f=1)
if %f% equ 1 call C:\ProgramData\chocolatey\bin\refreshenv
set f=0
where 7z /q
if not %errorlevel%==0 (choco install 7zip --x86 -y
set f=1)
where git /q
if not %errorlevel%==0 (choco install git --x86 -y
set f=1)
where go /q
if not %errorlevel%==0 (choco install golang --x86 -y
set f=1)
where ruby /q
if not %errorlevel%==0 (choco install ruby --x86 -y
set f=1)
rem if not %errorlevel%==0 (start https://ftp.nluug.nl/pub/vim/pc/gvim81.exe)
if not exist %USERPROFILE%\scoop\apps\miniconda3 (call scoop bucket add extras
call scoop install miniconda3 -a 32bit
set f=1)
if %f% equ 1 call refreshenv
set f=
rem call %USERPROFILE%\Miniconda3\Scripts\activate.bat %USERPROFILE%\Miniconda3
call %USERPROFILE%\scoop\apps\miniconda3\current\Scripts\activate.bat %USERPROFILE%\scoop\apps\miniconda3\current
call conda update --all -y
if not exist %CONDA_PREFIX%\envs\dev call conda create -n dev python=2 pandas -y
if not exist %CONDA_PREFIX%\envs\exe (call conda create -n exe python=2 -y
call activate exe
call pip install pandas pyinstaller==3.3.1
rem echo hiddenimports = ['pandas._libs.tslibs.timedeltas'] > %CONDA_PREFIX%\Lib\site-packages\PyInstaller\hooks\hook-pandas.py
rem echo hiddenimports = ['pandas._libs.tslibs.timedeltas'] > %USERPROFILE%\scoop\apps\miniconda3\current\envs\exe\Lib\site-packages\PyInstaller\hooks\hook-pandas.py
call deactivate)
call deactivate
if not exist %USERPROFILE%\scoop\apps\miniconda3\current\envs\exe\Lib\site-packages\PyInstaller\hooks\hook-pandas.py echo hiddenimports = ['pandas._libs.tslibs.timedeltas','pandas._libs.tslibs.np_datetime','pandas._libs.tslibs.nattype','pandas._libs.skiplist'] > %USERPROFILE%\scoop\apps\miniconda3\current\envs\exe\Lib\site-packages\PyInstaller\hooks\hook-pandas.py
if not exist compileIfChanged git clone https://github.com/abicorios/compileIfChanged
start /wait cmd /c "cd compileIfChanged && git pull"
if not exist compileIfChanged.exe go build compileIfChanged\compileIfChanged.go
compileIfChanged.exe compileIfChanged\compileIfChanged.go compileIfChanged.exe go build compileIfChanged\compileIfChanged.go
if not exist 7zGitMirror git clone https://github.com/abicorios/7zGitMirror
if not exist 7z1805-extra move 7zGitMirror\7z1805-extra
