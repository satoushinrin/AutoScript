@echo off
setlocal enabledelayedexpansion

set "ffmpeg_path=C:\Tools\bin\ffmpeg.exe"

:: Check ffmpeg exists
if not exist %ffmpeg_path% (
    echo There is no ffmpeg, please install or update it!
    pause
    exit /b
)

:: Check if no file was selected
if "%~1"=="" (
    echo Please select at least one video file for conversion.
    pause
    exit /b
)

:: Send files to cmd
for %%a in (%*) do (
    :: Check output directory exists
    set "input_file=%%~a"
    set "input_dir=%%~dpa"
    
    :: Create the output directory input file's directory
    if not exist "%input_dir%Converted" (
        mkdir "%input_dir%Converted"
    )
    
    set "rename=%%~na"
    set "rename=!rename: =-!"
    
    :: Use ffmpeg to resize the image
    "%ffmpeg_path%" -i "%%~a" -vf "scale=-1:680" -q:v 1 "%input_dir%Converted\!rename!.jpg"

)
exit /b
