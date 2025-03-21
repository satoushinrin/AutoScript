@echo off
setlocal enabledelayedexpansion

set "ffmpeg_path=C:\Tools\bin\ffmpeg.exe"
set "ffprobe_path=C:\Tools\bin\ffprobe.exe"

:: Check if ffmpeg exists
if not exist "%ffmpeg_path%" (
    echo ffmpeg not found! Please check the path.
    pause
    exit /b
)

:: Check if ffprobe exists
if not exist "%ffprobe_path%" (
    echo ffprobe not found! Please check the path.
    pause
    exit /b
)

:: Check if no file was selected
if "%~1"=="" (
    echo Please select an image file to resize.
    pause
    exit /b
)

:: Ask for custom width and height
set /p new_width="Enter the new width: "
set /p new_height="Enter the new height: "

:: Executed
for %%a in (%*) do (
    set "file=%%~a"
    set "filename=%%~na"
    set "dir=%%~dpa"
    
    :: Rename output
    set "rename=%%~na [!new_width!x!new_height!]"
    set "rename=!rename: =-!"
    
    %ffmpeg_path% -i "%%~a" -vf "scale=!new_width!:!new_height!" -q:v 1 "!dir!!rename!.jpg"
)
exit /b
