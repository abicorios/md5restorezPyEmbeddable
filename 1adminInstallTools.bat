where ruby /q
if not %errorlevel%==0 (choco install ruby --x86 -y)
where conda /q
if not %errorlevel%==0 (choco install miniconda3 --x86 -y)
exit
