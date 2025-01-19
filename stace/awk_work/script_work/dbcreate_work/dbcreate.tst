# The database we are creating
DBPATH=$2; export DBPATH
echo $DBPATH

# The schema to create the database with.
SCHEMA=$1

cd $PHABASE
su dbadmin -c "mkdir $DBPATH"
cd $DBPATH

creatdb -dpharaoh -vvol0 -Ovollen=8388608 -Ofiletype=regular -Opreallocate -Odesc='Pharaoh Database'

# Shut the database as it was opened when it was created.
shutdb

# Rememebr to chnage the SHMKEY value to a unique number, as in db_copy
cp $PHABASE/lib/file.cf $DBPATH/file.cf

# Create some new directories.
su dbadmin -c "mkdir raw_data account_data archives_dir data_errors cris_data text_files walker_data"

# Start the datbase ready to run the schema.
pharaoh startdb

# create the database structure by running the schema.
SQL $1 > $PHABASE/tmp/schema_log 2>&1
disc -Oinitialize
disc $PHABASE/lib/source.dis



