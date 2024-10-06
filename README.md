# AutoScript
To add a context menu when right-clicking a file, go to C:\Tools and run Add.reg. 
If you no longer need this menu, you can remove it by running Remove.reg in the same folder.

To delete the batch files in the SendTo folder, follow these steps:
- Press Windows + R, then type 'shell:sendto' and press Enter.
- Delete any files you no longer use in this folder

Tool features:
1. Checksum

\- Check the integrity of files downloaded from the internet. Compare the results with information provided by the uploader.

\- Supported hash codes:

\+ CRC32

\+ MD5

\+ SHA1

\+ ED2K
 

2. Convert video - Convert videos to any format (e.g., mp4, mkv, avi)

\- If you only want to change the file extension, it will keep the codec and not re-encode. This will not affect the video quality.

\- However, some extensions may not support the codec of your video, so encoding may be unavoidable in those cases. (Audio is not affected)
 
 
3. Convert audio - Convert audios to any format (e.g., mp3, wav, flac, ogg, ac3)

\- Changing the audio file extension often requires changing the codec, which can directly affect sound quality. 

\- In most cases, it's impossible to avoid re-encoding the audio during this process.


4. Convert image - Convert images to any format (e.g., jpg, png, bmp)

\- Changing the image file extension often requires converting the image format, which can directly affect image quality.

\- In most cases, it's impossible to avoid altering the image quality during this process.

5. Compress video - Input the number of <?> MB you want it to compress

\- The codec will remain the same, but the bitrate will decrease significantly, which will directly affect the video.

6. Extract Media - Extract image and audio from video

\- The codec and bitrate will remain the same.

7. Resize Image to 480x680
8. Resize Image to 960x540

\- Just like the name

Advanced features (Not available in lite version)

9. Create ED2L Link
10. Update Anime in the Database (Edit your Username and API_Key)
11. Create Keyframes


Script by Shinrin, thank to:
+ https://github.com/FFmpeg/FFmpeg
+ https://github.com/rhash/RHash

