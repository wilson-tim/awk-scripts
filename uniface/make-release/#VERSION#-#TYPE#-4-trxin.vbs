Dim Wsh, Fso, Ret

Set Wsh = CreateObject("WScript.Shell")
Set Fso = CreateObject("Scripting.FileSystemObject")

'-- TRX in user data --

Ret = Wsh.Run ("c:\progra~1\compuware\UNIFAC~1\bin\idf.exe /asn=.\assign#VERSION#\swift#VERSION#.asn /rma /cpy trx:#VERSION#-*-out.trx def: #VERSION#.MAP" , 1, true )
fso.CopyFile "c:\temp\swift_#TYPE#_putmess.log","#VERSION#-4-trxin1.txt"

'-- TRX in new messages and labels --

Ret = Wsh.Run ("c:\progra~1\compuware\UNIFAC~1\bin\idf.exe /asn=.\assign#VERSION#\swift#VERSION#.asn /rma /cpy trx:.\imp_exp\system_trxs\usourceupdate.trx def:" , 1, true )
fso.CopyFile "c:\temp\swift_#TYPE#_putmess.log","#VERSION#-4-trxin2.txt"

msgbox("Build #VERSION# Re-Import User Data - Finished")



