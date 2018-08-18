where ruby /q
if not %errorlevel%==0 (choco install ruby --x86 -y)
exit
