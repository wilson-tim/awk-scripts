REM Use like:
REM
REM make-release.bat <target-folder> <version>
REM
REM e.g.
REM
REM make-release.bat "C:\Swift_LG\Installation_Sets\v9113\Release" 9113
REM
REM 09/06/2010  TW  New DOS batch file

if exist %1\mss-update-only\%2-test-1-dir.vbs rd /s /q %1

if not exist %1\mss-update-only\%2-test-1-dir.vbs md %1

REM MSS

md %1\mss-update-only

gawk -f changeFiles.awk version="%2" type=""     #VERSION#-messages_only.vbs   > %1\mss-update-only\%2-messages_only.vbs

gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-1-dir.vbs    > %1\mss-update-only\%2-test-1-dir.vbs
gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-2-trxout.vbs > %1\mss-update-only\%2-test-2-trxout.vbs
gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-3-system.vbs > %1\mss-update-only\%2-test-3-system.vbs
gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-4-trxin.vbs  > %1\mss-update-only\%2-test-4-trxin.vbs
gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-5-mes.vbs    > %1\mss-update-only\%2-test-5-mes.vbs
gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-6-dir2.vbs   > %1\mss-update-only\%2-test-6-dir2.vbs

gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-1-dir.vbs    > %1\mss-update-only\%2-live-1-dir.vbs
gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-2-trxout.vbs > %1\mss-update-only\%2-live-2-trxout.vbs
gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-3-system.vbs > %1\mss-update-only\%2-live-3-system.vbs
gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-4-trxin.vbs  > %1\mss-update-only\%2-live-4-trxin.vbs
gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-5-mes.vbs    > %1\mss-update-only\%2-live-5-mes.vbs
gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-6-dir2.vbs   > %1\mss-update-only\%2-live-6-dir2.vbs

md %1\mss-update-only\%2-components

gawk -f changeFiles.awk version="%2" type=""     #VERSION#.map                 > %1\mss-update-only\%2-components\%2.map

REM ORA

md %1\ora-update-only

gawk -f changeFiles.awk version="%2" type=""     messages_only.vbs             > %1\ora-update-only\messages_only.vbs

gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-1-dir.vbs    > %1\ora-update-only\%2-test-1-dir.vbs
gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-2-trxout.vbs > %1\ora-update-only\%2-test-2-trxout.vbs
gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-3-system.vbs > %1\ora-update-only\%2-test-3-system.vbs
gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-4-trxin.vbs  > %1\ora-update-only\%2-test-4-trxin.vbs
gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-5-mes.vbs    > %1\ora-update-only\%2-test-5-mes.vbs
gawk -f changeFiles.awk version="%2" type="test" #VERSION#-#TYPE#-6-dir2.vbs   > %1\ora-update-only\%2-test-6-dir2.vbs

gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-1-dir.vbs    > %1\ora-update-only\%2-live-1-dir.vbs
gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-2-trxout.vbs > %1\ora-update-only\%2-live-2-trxout.vbs
gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-3-system.vbs > %1\ora-update-only\%2-live-3-system.vbs
gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-4-trxin.vbs  > %1\ora-update-only\%2-live-4-trxin.vbs
gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-5-mes.vbs    > %1\ora-update-only\%2-live-5-mes.vbs
gawk -f changeFiles.awk version="%2" type="live" #VERSION#-#TYPE#-6-dir2.vbs   > %1\ora-update-only\%2-live-6-dir2.vbs

md %1\ora-update-only\%2-components

gawk -f changeFiles.awk version="%2" type=""     #VERSION#.map                 > %1\ora-update-only\%2-components\%2.map

REM New installation

md %1\new-install
md %1\new-install\sql
md %1\new-install\sql\mss
md %1\new-install\sql\ora

echo
echo "DONE."