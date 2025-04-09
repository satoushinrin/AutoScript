@echo off
setlocal enabledelayedexpansion

set "ffmpeg_path=C:\Tools\bin\ffmpeg.exe"

:: Check if ffmpeg exists
if not exist "%ffmpeg_path%" (
    echo ffmpeg not found! Please check the path.
    pause
    exit /b
)

:: Check if no file was selected
if "%~1"=="" (
    echo Please select image file to convert.
    pause
    exit /b
)

:: Ask for output format
set "output_ext=n"
set /p "output_ext=Do you want to convert to .JPG? (y/n): "

:: Process each selected file
for %%a in (%*) do (
    set "input_dir=%%~dpa"
    set "rename=%%~na"
    set "rename=!rename: =-!"

    if /i "!output_ext!"=="y" (
        "%ffmpeg_path%" -i "%%~a" -vf "scale=960:-1" -q:v 1 "!input_dir![X]!rename!.jpg"
    ) else (
        "%ffmpeg_path%" -i "%%~a" -vf "scale=960:-1" "!input_dir![X]!rename!.png"
    )
)

exit /b
