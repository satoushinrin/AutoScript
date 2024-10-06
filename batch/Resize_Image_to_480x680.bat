@echo off
set "ffmpeg_path=C:\Tools\bin\ffmpeg.exe"

:: Check ffmpeg exists
if not exist %ffmpeg_path% (
    echo There is no ffmpeg, please install or update it!
    pause
    exit /b
)

:: Send files to cmd
for %%a in (%*) do (
    echo Processing: %%~nxa
    
    :: Check output directory exists
    set "input_file=%%~a"
    set "input_dir=%%~dpa"
    
    :: Create the output directory input file's directory
    if not exist "%input_dir%Converted" (
        mkdir "%input_dir%Converted"
    )
    
    :: Use ffmpeg to resize the image
    "%ffmpeg_path%" -i "%%~a" -vf "scale=-1:680" -q:v 1 "%input_dir%Converted\%%~na.jpg"
    
    echo Done: %%~nxa
)
exit /b