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
set /p format="Enter the desired output format (e.g., mp3, wav, flac, ogg, ac3): "

:: Validate input
if "%format%"=="" (
    echo Invalid format! Please enter a valid audio format.
    pause
    exit /b
)

:: Check the number of files passed
set "file_count=0"
for %%f in (%*) do (
    set /a file_count+=1
)

:: Create Converted folder if more than one file is passed
if %file_count% gtr 1 (
    mkdir "%~dp1Converted"
)

:: Convert
for %%f in (%*) do (
    set "file=%%f"
    set "extension=%%~xf"

    :: WAV codec (always convert to PCM for WAV)
    if /i "%format%"=="wav" (
        if %file_count% gtr 1 (
            "%ffmpeg_path%" -i %%f -c:a pcm_s16le "%~dp1Converted\%%~nf.%format%"
        ) else (
            "%ffmpeg_path%" -i %%f -c:a pcm_s16le "%%~nf.%format%"
        )
    
    ) else if /i "%format%"=="ac3" (
        if %file_count% gtr 1 (
            "%ffmpeg_path%" -i %%f -c:a ac3 -b:a 192k "%~dp1Converted\%%~nf.%format%"
        ) else (
            "%ffmpeg_path%" -i %%f -c:a ac3 -b:a 192k "%%~nf.%format%"
        )

    ) else if /i "%format%"=="mp3" (
        if %file_count% gtr 1 (
            "%ffmpeg_path%" -i %%f -c:a libmp3lame -q:a 0 "%~dp1Converted\%%~nf.%format%"
        ) else (
            "%ffmpeg_path%" -i %%f -c:a libmp3lame -q:a 0 "%%~nf.%format%"
        )

    ) else if /i "%format%"=="flac" (
        if %file_count% gtr 1 (
            "%ffmpeg_path%" -i %%f -c:a flac "%~dp1Converted\%%~nf.%format%"
        ) else (
            "%ffmpeg_path%" -i %%f -c:a flac "%%~nf.%format%"
        )

    ) else if /i "%format%"=="ogg" (
        if %file_count% gtr 1 (
            "%ffmpeg_path%" -i %%f -c:a libvorbis -q:a 5 "%~dp1Converted\%%~nf.%format%"
        ) else (
            "%ffmpeg_path%" -i %%f -c:a libvorbis -q:a 5 "%%~nf.%format%"
        )

    ) else (
        :: Default to AAC codec if unsupported format
        if %file_count% gtr 1 (
            "%ffmpeg_path%" -i %%f -c:a aac -b:a 192k "%~dp1Converted\%%~nf.aac"
        ) else (
            "%ffmpeg_path%" -i %%f -c:a aac -b:a 192k "%%~nf.aac"
        )
    )
)

:: Debug
if %ERRORLEVEL%==0 (
    echo Audio converted successfully to .%format%!
) else (
    echo Audio conversion failed!
)
exit /b
