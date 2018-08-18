where ruby /q
if not %errorlevel%==0 (choco install ruby --x86 -y)
where conda /q
if not %errorlevel%==0 (start https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86.exe)
exit
