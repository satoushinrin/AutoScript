

Set WshShell = CreateObject("WScript.Shell")
strFilePath = WScript.Arguments(0)
WshShell.Run "C:\Tools\batch\Remove_Metadata.bat """ & strFilePath & """", 0, True
