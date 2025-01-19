dim fso

'-- Create a COM object for the filesystem
set fso = CreateObject("Scripting.FileSystemObject")

'-- Rename 'assign#VERSION#' folder back to 'assign'
fso.MoveFolder "assign#VERSION#", "assign"

'-- Rename swift#VERSION#.asn back to swift.asn
fso.MoveFile "assign\swift#VERSION#.asn","assign\swift.asn"

msgbox("Build #VERSION# Restore Folder Structure - Finished")

