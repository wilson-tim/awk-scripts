Dim Wsh, Fso, Ret

Set Wsh = CreateObject("WScript.Shell")
Set Fso = CreateObject("Scripting.FileSystemObject")
 
'-- TRX in new system data --

Ret = Wsh.Run ("c:\progra~1\compuware\UNIFAC~1\bin\idf.exe /asn=.\assign#VERSION#\swift#VERSION#.asn /rma /cpy trx:.\imp_exp\system_trxs\#VERSION#*.trx def:" , 1, true )
fso.CopyFile "c:\temp\swift_#TYPE#_putmess.log","#VERSION#-3-system.txt"

msgbox("Build #VERSION# Import Model Details - Finished")
