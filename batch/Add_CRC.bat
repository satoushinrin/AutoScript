@echo off
setlocal enabledelayedexpansion
set "rhash_path=C:\Tools\bin\rhash.exe"

if not exist "%rhash_path%" (
    echo rhash not found! Please check the path.
    pause
    exit /b
)

:: Check if no file was selected
if "%~1"=="" (
    echo Please select at least one video file for conversion.
    pause
    exit /b
)

:: Checksum and rename
for %%f in (%*) do (
    set "file=%%~f"

    :: Get file name and extension
    set "filename=%%~nf"
    set "extension=%%~xf"

    :: Get checksums (in uppercase)
    for /f "tokens=1" %%A in ('%rhash_path% --crc32 --simple --uppercase %%f') do (
        set "crc32=%%A"
    )

    :: Rename the file with original name + [crc32] + extension
    set "newname=!filename! [!crc32!]!extension!"
    rename %%f "!newname!"
)
exit /b