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
    echo Please select media file to remove metadata.
    pause
    exit /b
)

:: Process each selected file
for %%a in (%*) do (
    set "input_dir=%%~dpa"
    set "rename=%%~na"
    set "ext=%%~xa"

    "%ffmpeg_path%" -i "%%~a" -map_metadata -1 -c copy "!input_dir![Nometa]!rename!!ext!"
)

exit /b