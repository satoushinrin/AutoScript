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
    echo Please select a video file for extraction.
    pause
    exit /b
)

:: Get the input file and its directory and name
set "file=%~1"
set "filename=%~dpn1"

:: Get video codec
for /f "delims=," %%A in ('%ffprobe_path% -v error -select_streams v:0 -show_entries stream^=codec_name -of csv^=p^=0 "%file%"') do set "vcodec=%%A"

:: Get audio codec
for /f "delims=," %%A in ('%ffprobe_path% -v error -select_streams a:0 -show_entries stream^=codec_name -of csv^=p^=0 "%file%"') do set "acodec=%%A"

echo Codec information:
echo Your Video codec is %vcodec%
echo Your Audio codec is %acodec%
echo Do you want to extract them??
pause

:: Determine correct video extension
if /i "%vcodec%"=="h264" (set "video_ext=mp4") ^
else if /i "%vcodec%"=="hevc" (set "video_ext=mp4") ^
else if /i "%vcodec%"=="mpeg2video" (set "video_ext=m2v") ^
else if /i "%vcodec%"=="vp9" (set "video_ext=webm") ^
else if /i "%vcodec%"=="vp8" (set "video_ext=webm") ^
else if /i "%vcodec%"=="av1" (set "video_ext=mp4") ^
else "%video_ext%"=="" (set "video_ext=%~x1") :: Use original extension if unknown

:: Determine correct audio extension
if /i "%acodec%"=="aac" (set "audio_ext=aac") ^
else if /i "%acodec%"=="ac3" (set "audio_ext=ac3") ^
else if /i "%acodec%"=="mp3" (set "audio_ext=mp3") ^
else if /i "%acodec%"=="opus" (set "audio_ext=opus") ^
else if /i "%acodec%"=="vorbis" (set "audio_ext=ogg") ^
else "%audio_ext%"=="" (set "audio_ext=%~x1") :: Use original extension if unknown

:: Define output files
set "video_file=%filename%_video.%video_ext%"
set "audio_file=%filename%_audio.%audio_ext%"

:: Extract the video and audio without re-encoding
"%ffmpeg_path%" -i "%file%" -map 0:v -c copy "%video_file%" -map 0:a -c copy "%audio_file%"

if %ERRORLEVEL%==0 (
    echo Video and audio extracted successfully without re-encoding!
) else (
    echo Extraction failed!
)
exit /b
