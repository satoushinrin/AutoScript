@echo off
set "ffmpeg_path=C:\Tools\bin\ffmpeg.exe"
set "ffprobe_path=C:\Tools\bin\ffprobe.exe"

:: Check if ffmpeg and ffprobe exist
if not exist "%ffmpeg_path%" (
    echo ffmpeg not found! Please check the path.
    pause
    exit /b
)

if not exist "%ffprobe_path%" (
    echo ffprobe not found! Please check the path.
    pause
    exit /b
)

:: Check if no file was selected
if "%~1"=="" (
    echo Please select a video file for conversion.
    pause
    exit /b
)

:: Get the input file and its extension
set "file=%~1"
set "extension=%~x1"

:: Ask user for output size
set /p size="Input your MB: "

:: Cacl Bitrate
for /f "delims=" %%a in ('%ffprobe_path% -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%file%"') do set duration=%%a
set /a bitrate=(%size%*8192)/%duration%

:: Keep format
for %%x in ("%file%") do set format=%%~xx

:: Convert the video without re-encoding
"%ffmpeg_path%" -i "%file%" -b:v %bitrate%k -c:a copy "%~dpn1_compressed.%format%"

if %ERRORLEVEL%==0 (
    echo Video converted successfully to .%format% without re-encoding!
) else (
    echo Video conversion failed!
)
exit /b
