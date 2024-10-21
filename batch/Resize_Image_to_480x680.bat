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
    echo Please select an image file to merge.
    pause
    exit /b
)

:: Set watermark path
set "watermark=C:\Tools\preset\image\v_watermark.png"

:: Executed
for %%a in (%*) do (
    set "file=%%~a"
    set "filename=%%~na"
    set "dir=%%~dpa"
    
    :: Check output directory exists
    if not exist "!dir!Converted" (
        mkdir "!dir!Converted"
    )
    
    :: Get the width/height of the input image
    for /f "tokens=1,2 delims=," %%b in ('%ffprobe_path% -v error -select_streams v:0 -count_packets -show_entries stream^=width^,height -of csv^=p^=0 "%%~a"') do (
        set "width=%%b"
        set "height=%%c"
    )
    
    :: Rename output
    set "rename=%%~na"
    set "rename=!rename: =-!"
    
    %ffmpeg_path% -i "%%~a" -i "%watermark%" -filter_complex "[1:v]scale=!width!:!height![wm];[0:v][wm]overlay=0:0,scale=-1:680" -q:v 1 "!dir!Converted\!rename!.jpg"
)
exit /b
