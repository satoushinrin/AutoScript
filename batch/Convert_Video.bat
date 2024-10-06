@echo off
setlocal

:: Set ffmpeg path
set "ffmpeg_path=C:\Tools\bin\ffmpeg.exe"

:: Check if ffmpeg exists
if not exist "%ffmpeg_path%" (
    echo ffmpeg not found! Please check the path.
    pause
    exit /b
)

:: Check if no file was selected
if "%~1"=="" (
    echo Please select at least one video file for conversion.
    pause
    exit /b
)

:: Select output format
set /p format="Enter the desired output format (e.g., mp4, mkv, avi): "

:: Validate input
if "%format%"=="" (
    echo Invalid format! Please enter a valid video format.
    pause
    exit /b
)

:: Check the number of files passed
set "file_count=0"
for %%f in (%*) do (
    set /a file_count+=1
)

:: Create Converted folder
if %file_count% gtr 1 (
    mkdir "%~dp1Converted"
)

:: Convert
for %%f in (%*) do (
    set "file=%%f"
    set "extension=%%~xf"
    
    :: AVI codec
    if /i "%format%"=="avi" (
        if %file_count% gtr 1 (
            "%ffmpeg_path%" -i %%f -c:v mpeg4 -q:v 3 -c:a libmp3lame -q:a 3 "%~dp1Converted\%%~nf.%format%"
        ) else (
            "%ffmpeg_path%" -i %%f -c:v mpeg4 -q:v 3 -c:a libmp3lame -q:a 3 "%%~nf.%format%"
        )
    ) else if /i "%format%"=="m2v" (
        if %file_count% gtr 1 (
            "%ffmpeg_path%" -i %%f -q:v 3 -c:v mpeg2video -an -s 720x480 -r 29.97 -maxrate 9.8M -bufsize 1835k "%~dp1Converted\%%~nf.%format%"
        ) else (
            "%ffmpeg_path%" -i %%f -q:v 3 -c:v mpeg2video -an -s 720x480 -r 29.97 -maxrate 9.8M -bufsize 1835k "%%~nf.%format%"
        )
    ) else (
        if %file_count% gtr 1 (
            "%ffmpeg_path%" -i %%f -c copy "%~dp1Converted\%%~nf.%format%"
        ) else (
            "%ffmpeg_path%" -i %%f -c copy "%%~nf.%format%"
        )
    )
)

::Debug
if %ERRORLEVEL%==0 (
    echo Audio converted successfully to .%format%!
) else (
    echo Audio conversion failed!
)
exit /b
