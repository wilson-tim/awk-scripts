	dbaccess  universe << EOF 2>&1
unload to "/tmp/foo" delimiter "."
select tabname, colname from systables, syscolumns
where systables.tabid = syscolumns.tabid
and tabname = "$1"
EOF
cat /tmp/foo | sed -e s/\.$//g > /tmp/$1.txt
rcp -r /tmp/$1.txt $FGLSERVER:c:/$1.txt
chmod 777 /tmp/foo /tmp/$1.txt
