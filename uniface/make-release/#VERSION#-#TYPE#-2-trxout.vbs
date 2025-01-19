Dim Wsh, Fso, Ret

Set Wsh = CreateObject("WScript.Shell")
Set Fso = CreateObject("Scripting.FileSystemObject")

'-- TRX out user data --

Ret = Wsh.Run ("c:\progra~1\compuware\UNIFAC~1\bin\idf.exe /asn=.\assign#VERSION#\swift#VERSION#.asn /rma /cpy def:usource.dict trx:#VERSION#-usource-out.trx" , 1, true)
fso.CopyFile "c:\temp\swift_#TYPE#_putmess.log","#VERSION#-2-usource-out.txt"

msgbox("Build #VERSION# Export Existing Data - Finished")
