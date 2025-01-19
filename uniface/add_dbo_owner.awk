##############################################################
#
# 05/08/2010  TW  Add the dbo owner to Uniface generated
#                 MS SQL scripts
#
# Usage:
#
# gawk -f add_dbo_owner [ms_sql_script_filename].sql
# gawk -f add_dbo_owner *.sql
#
# Returns:
#
# Amended copy of [ms_sql_script_filename].sql as
# [ms_sql_script_filename].sql.dbo
#
#############################################################


{gsub(/create table /, "create table [dbo].", $0)}

{gsub(/create procedure /, "create procedure [dbo].", $0)}

{print $0 > FILENAME".dbo"}