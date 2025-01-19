create table "nhs_sup" (
	configuration (
		estimated count is 15000,
		description 'NHS Supplies Transactions'),
	"transaction_no"	numeric	(8)	not null primary key
		configuration (
		display (9)),
	"batch_id"	huge date
		configuration (
		display (11)),
	"docket_no"	char	(6),
	"stock_no"	char	(10),
	"stock_description"	char	(40),
	"date_issued"	huge date
		configuration (
		display (11)),
	"quantity_issued"	numeric	(5)
		configuration (
		display (6)),
	"cost"	amount	(9)
		configuration (
		display (11,2)),
	"transferred"	char	(1));
commit work;
create btree index "nhs_sup_index002" on "nhs_sup" (
	"batch_id",
	"docket_no",
	"stock_no");
commit work;
create unique btree index "nhs_sup_index001" on "nhs_sup" (
	"transaction_no");
commit work;
create unique hash index "nhs_sup_index" on "nhs_sup" ("transaction_no")
	configuration (
		hash type is 3,
		overflow is 16,
		split at 1);
commit work;
