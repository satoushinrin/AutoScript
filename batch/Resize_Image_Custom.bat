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

echo.
echo +=================================================================+
echo ^|                         Resolution Chart                        ^|
echo +=================================================================+
echo ^| Raw Resolution       -  960 x 540                               ^|
echo ^| SD Resolution        -  720 x 480                               ^|
echo ^| HD Resolution        -  1280 x 720                              ^|
echo ^| Full HD Resolution   -  1920 x 1080                             ^|
echo ^| 2K Resolution        -  2048 x 1080                             ^|
echo ^| 4K Resolution        -  3840 x 2160 (UHD) or 4096 x 2160 (DCI)  ^|
echo ^| 8K Resolution        -  7680 x 4320                             ^|
echo ^| 16K Resolution       -  15360 x 8640                            ^|
echo +=================================================================+
echo.

:: Ask for custom width and height
set /p new_width="Enter the new width: "
set /p new_height="Enter the new height: "

:: Ask for output format
set "output_ext=n"
set /p "output_ext=Do you want to convert to .JPG? (y/n): "

:: Executed
for %%a in (%*) do (
    set "file=%%~a"
    set "filename=%%~na"
    set "dir=%%~dpa"
    
    :: Rename output
    set "rename=[!new_width!x!new_height!] %%~na"
    set "rename=!rename: = !"
    
    if /i "!output_ext!"=="y" (
        %ffmpeg_path% -i "%%~a" -vf "scale=!new_width!:!new_height!" -q:v 1 "!dir!!rename!.jpg"
    ) else (
        %ffmpeg_path% -i "%%~a" -vf "scale=!new_width!:!new_height!" "!dir!!rename!.png"
    )
)
exit /b
