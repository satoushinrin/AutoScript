


Set WshShell = CreateObject("WScript.Shell")
strFilePath = WScript.Arguments(0)
WshShell.Run "C:\Tools\batch\Resize_Image_to_960x540.bat """ & strFilePath & """", 0, True