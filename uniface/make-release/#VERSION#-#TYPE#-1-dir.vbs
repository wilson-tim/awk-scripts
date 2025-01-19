'-- Function to recursively change attributes
function changeAttribs ( filnam )
  For Each f In fso.GetFolder(filnam).Files
    if f.attributes and 1 then f.attributes = f.attributes - 1
  Next
  For Each f In fso.GetFolder(filnam).subFolders
    if f.attributes and 1 then f.attributes = f.attributes - 1
    res = changeAttribs ( filnam & "\" & f.name )
  Next
  changeAttribs = 1
end function

dim fso

'-- Create a COM object for the filesystem
set fso = CreateObject("Scripting.FileSystemObject")

call changeAttribs (".")

'-- Rename 'assign' folder to 'assign#VERSION#'
fso.MoveFolder "assign", "assign#VERSION#"

'-- Rename swift.asn to swift#VERSION#.asn
fso.MoveFile "assign#VERSION#\swift.asn","assign#VERSION#\swift#VERSION#.asn"

'-- Create the folder on the remote share
fso.CreateFolder "Pre-Build#VERSION#"

'-- Copy a directory
fso.CopyFolder "aps", "Pre-Build#VERSION#\"
fso.CopyFolder "dol", "Pre-Build#VERSION#\"
fso.CopyFolder "forms", "Pre-Build#VERSION#\"
fso.CopyFolder "reports", "Pre-Build#VERSION#\"
fso.CopyFolder "services", "Pre-Build#VERSION#\"
fso.CopyFolder "urr", "Pre-Build#VERSION#\"

'-- Delete the local copy
fso.DeleteFolder "aps"
fso.DeleteFolder "dol"
fso.DeleteFolder "forms"
fso.DeleteFolder "reports"
fso.DeleteFolder "services"
fso.DeleteFolder "urr"

'-- Recreate empty directories
fso.CreateFolder "aps"
fso.CreateFolder "dol"
fso.CreateFolder "forms"
fso.CreateFolder "reports"
fso.CreateFolder "services"
fso.CreateFolder "urr"

msgbox("Build #VERSION# Backup Folder Structure - Finished")

