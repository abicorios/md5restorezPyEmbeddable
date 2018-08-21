where choco /q
if not %errorlevel%==0 (start /wait cmd /c @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin")
call C:\ProgramData\chocolatey\bin\refreshenv
where 7z /q
if not %errorlevel%==0 (choco install 7zip --x86 -y)
where git /q
if not %errorlevel%==0 (choco install git --x86 -y)
where go /q
if not %errorlevel%==0 (choco install golang --x86 -y)
where ruby /q
if not %errorlevel%==0 (choco install ruby --x86 -y)
where vim /q
if not %errorlevel%==0 (start https://ftp.nluug.nl/pub/vim/pc/gvim81.exe)
@set /p a=It is a pause, press Enter after an installation of vim
@set a=
where conda /q
if not %errorlevel%==0 (start https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86.exe)
@set /p a=It is a pause, press Enter after an installation of miniconda3
@set a=
call refreshenv
call %USERPROFILE%\Miniconda3\Scripts\activate.bat %USERPROFILE%\Miniconda3
if not exist %CONDA_PREFIX%\envs\dev call conda create -n dev python=3 pandas -y
if not exist %CONDA_PREFIX%\envs\exe call conda create -n exe python=3 -y
call activate exe
pip install pandas pyinstaller
echo hiddenimports = ['pandas._libs.tslibs.timedeltas'] > %CONDA_PREFIX%\Lib\site-packages\PyInstaller\hooks\hook-pandas.py
call deactivate
call deactivate
