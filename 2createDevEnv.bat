call %USERPROFILE%\Miniconda3\Scripts\activate.bat %USERPROFILE%\Miniconda3
call conda create -n dev python=3 pandas -y
deactivate
