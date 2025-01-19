REM Use like:
REM
REM make-websiteFiles.bat <release-folder> <version>
REM
REM e.g.
REM
REM make-release.bat "C:\Swift_LG\Installation_Sets\v9113\Release" 9113
REM
REM 09/06/2010  TW  New DOS batch file


md %1\%2-website-files


REM MSS

rd /s /q %1\%2

md %1\%2

md %1\%2\mss-update-only

xcopy %1\mss-update-only\*.* %1\%2\mss-update-only /s

"C:\Program Files\7-Zip\7z.exe" a -sfx7z.sfx %1\%2_mss.exe %1\%2

copy /y %1\%2_mss.exe %1\%2-website-files


REM ORA

rd /s /q %1\%2

md %1\%2

md %1\%2\ora-update-only

xcopy %1\ora-update-only\*.* %1\%2\ora-update-only /s

"C:\Program Files\7-Zip\7z.exe" a -sfx7z.sfx %1\%2_ora.exe %1\%2

copy /y %1\%2_ora.exe %1\%2-website-files


REM tidy up

"C:\Program Files\7-Zip\7z.exe" a %1\%2-website-files\%2-website-files.7z %1\%2-website-files

rd /s /q %1\%2

del %1\%2_mss.exe

del %1\%2_ora.exe

echo
echo "DONE."