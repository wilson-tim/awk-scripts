Dim Wsh, Fso, Ret

Set Wsh = CreateObject("WScript.Shell")
Set Fso = CreateObject("Scripting.FileSystemObject")
 
'-- Compile all messages --

Ret = Wsh.Run ("c:\progra~1\compuware\UNIFAC~1\bin\idf.exe /asn=.\assign#VERSION#\swift#VERSION#.asn /rma /mes" , 1, true )
fso.CopyFile "c:\temp\swift_#TYPE#_putmess.log",".\#VERSION#-5-mes.txt"

msgbox("Build #VERSION# Compile Messages - Finished")


