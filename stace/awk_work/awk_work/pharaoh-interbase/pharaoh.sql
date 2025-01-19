create table "ac_dets" (
	"account_code"	char	(15)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "ac_dets_index" on "ac_dets" ("account_code")
commit work;
create table "ac_type" (
	"access_code"	char	(1)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "ac_type_index" on "ac_type" ("access_code")
commit work;
create table "add_inf" (
	"asset_id"	char	(6)	not null primary key,
	"descript_1"	char	(50),
	"descript_2"	char	(50),
	"descript_3"	char	(50),
	"descript_4"	char	(50),
	"descript_5"	char	(50),
	"descript_6"	char	(50),
	"descript_7"	char	(50));
commit work;
create unique btree index "add_inf_index078" on "add_inf" (
"asset_id")
commit work;
create unique hash index "add_inf_index" on "add_inf" ("asset_id")
commit work;
create table "aliases" (
	primary key ("alias_code","system_type"),
	"alias_code"	char	(30)	not null,
	"system_type"	char	(3)	not null,
	"trim_descript"	char	(50));
commit work;
create unique hash index "aliases_index" on "aliases" ("alias_code","system_type")
commit work;
create table "hrs_wrkd" (
	"uniquifier"	numeric	(6)	not null primary key
	"clock_card_no"	char	(6),
	"date_recorded"	huge date
	"activity_code"	char	(4),
	"entered_date"	huge date
	"entered_time"	time
	"docket_number"	char	(6),
	"hours"	amount	(5)
	"time_factor"	amount	(4)
	"entered_by"	char	(8),
	"team_id"	char	(6),
	"rep_category"	numeric	(2)
commit work;
create btree index "hrs_wrkd_index162" on "hrs_wrkd" (
	"date_recorded",
"docket_number")
commit work;
create btree index "hrs_wrkd_index161" on "hrs_wrkd" (
	"date_recorded",
	"clock_card_no",
"docket_number")
commit work;
create btree index "hrs_wrkd_index160" on "hrs_wrkd" (
	"team_id",
"docket_number")
commit work;
create btree index "hrs_wrkd_index159" on "hrs_wrkd" (
	"clock_card_no",
"docket_number")
commit work;
create btree index "hrs_wrkd_index1" on "hrs_wrkd" (
	"clock_card_no",
	"date_recorded",
	"activity_code",
	"entered_date",
"entered_time")
commit work;
create btree index "hrs_wrkd_index134" on "hrs_wrkd" (
	"docket_number",
"date_recorded")
commit work;
create btree index "hrs_wrkd_index133" on "hrs_wrkd" (
"date_recorded")
commit work;
create btree index "hrs_wrkd_index150" on "hrs_wrkd" (
"activity_code")
commit work;
create btree index "hrs_wrkd_index152" on "hrs_wrkd" (
	"team_id",
"date_recorded")
commit work;
create btree index "hrs_wrkd_index019" on "hrs_wrkd" (
	"clock_card_no",
	"date_recorded",
"docket_number")
commit work;
create btree index "hrs_wrkd_index158" on "hrs_wrkd" (
	"date_recorded",
	"team_id",
"docket_number")
commit work;
create unique hash index "hrs_wrkd_index" on "hrs_wrkd" ("uniquifier")
commit work;
create table "cost_hist" (
	primary key ("uniquifier","docket_number"),
	"uniquifier"	numeric	(6)	not null
	"docket_number"	char	(6)	not null,
	"cost_type"	char	(1),
	"cost_ref"	char	(30),
	"cost"	amount	(8)
commit work;
create btree index "cost_hist_index001" on "cost_hist" (
"docket_number")
commit work;
create unique hash index "docket_number" on "cost_hist" ("uniquifier","docket_number")
commit work;
create table "as_costs" (
	primary key ("asset_id","year"),
	"asset_id"	char	(6)	not null,
	"year"	char	(4)	not null,
	"site"	char	(3),
	"building_code"	char	(3),
	"locat_code"	char	(6),
	"management_unit"	char	(4),
	"asset_number"	char	(6),
	"sub_asset_number"	char	(3),
	"hours_ytd"	amount	(7)
	"labour_costs_ytd"	amount	(9)
	"mat_costs_ytd"	amount	(9)
	"purch_costs_ytd"	amount	(9)
	"contr_costs_ytd"	amount	(9)
commit work;
create unique btree index "as_costs_index008" on "as_costs" (
	"year",
"asset_id")
commit work;
create btree index "as_costs_index119" on "as_costs" (
"asset_id")
commit work;
create unique hash index "as_costs_index" on "as_costs" ("asset_id","year")
commit work;
create table "control" (
	"current_pm_year"	char	(4)	not null primary key,
	"last_docket_no"	char	(6),
	"curr_fin_year"	char	(4),
	"curr_fin_period"	numeric	(2)
	"dte_last_per_end"	huge date
	"tol_pos_var_perc"	amount	(5)
	"tol_neg_var_perc"	amount	(5)
	"default_inv_addr"	char	(8),
	"control_acc_code"	char	(15),
	"write_off_acc"	char	(15),
	"stores_issue_acc"	char	(15),
	"invy_stock_type"	char	(1),
	"last_asset_id"	char	(6),
	"last_pm_job_id"	char	(6),
	"last_phist_id"	char	(6),
	"docket_type"	char	(1),
	"l_use_login"	char	(1),
	"n_use_login"	char	(1),
	"s_use_login"	char	(1),
	"p_use_login"	char	(1),
	"stock_asset_id"	char	(6),
	"jobbing_limit"	amount	(9)
	"default_spooler"	char	(20),
	"def_trade"	char	(1),
	"def_job_type"	char	(2),
	"def_cost_centre"	char	(4),
	"def_account_code"	char	(15),
	"allowed_backdate"	numeric	(3)
	"mod_date_time"	char	(1),
	"modify_priority"	char	(1),
	"last_week_trans"	numeric	(2)
	"last_cw_job_id"	char	(6),
	"system_type"	char	(3),
	"mand_projects"	char	(1),
	"last_proj_code"	char	(6),
	"company_name"	char	(35),
	"adjust_budgets"	char	(1),
	"accruals_yn"	char	(1),
	"link_lnp_sites"	char	(1),
	"ac_transfer_flag"	char	(1),
	"gen_asset_ids"	char	(1),
	"stand_work_hrs"	amount	(4)
	"hoc_percentage"	amount	(5)
	"hol_percentage"	amount	(5)
	"perform_man"	char	(1),
	"validate_cc_ac"	char	(1),
	"last_capital_asset_tx_no"	numeric	(6)
	"days_lag"	numeric	(2)
	"county"	char	(30),
	"stat_bar_mode"	char	(1),
	"department"	char	(4),
	"division"	char	(4),
	"business_unit"	char	(4),
	"link_ao_to_ca"	char	(1));
commit work;
create unique hash index "control_index" on "control" ("current_pm_year")
commit work;
create table "as_spare" (
	primary key ("asset_id","stock_code"),
	"asset_id"	char	(6)	not null,
	"stock_code"	char	(10)	not null,
	"descript_1"	char	(40),
	"descript_2"	char	(40));
commit work;
create unique btree index "as_spare_index011" on "as_spare" (
	"asset_id",
"stock_code")
commit work;
create btree index "as_spare_index106" on "as_spare" (
"asset_id")
commit work;
create btree index "as_spare_index107" on "as_spare" (
"stock_code")
commit work;
create unique hash index "as_spare_index" on "as_spare" ("asset_id","stock_code")
commit work;
create table "oh_dets" (
	"purchase_req_no"	numeric	(8)	not null primary key
	"order_number"	numeric	(8)
	"order_date"	huge date
	"order_desc"	char	(40),
	"special_instrs"	char	(40),
	"validated_ref"	char	(8),
	"validated_date"	huge date
	"authorised_ref"	char	(8),
	"date_authorised"	huge date
	"purch_req_date"	huge date
	"supplier_code"	char	(8),
	"delivery_address"	char	(8),
	"invoice_address"	char	(8),
	"print_yn_flag"	char	(1),
	"financial_year"	char	(4),
	"order_status"	char	(1),
	"stock_locat"	numeric	(2)
	"order_type"	char	(1),
	"order_or_credit"	char	(1),
	"cost_centre"	char	(4),
	"management_unit"	char	(4),
	"financial_period"	numeric	(2)
	"orig_order_no"	char	(8));
commit work;
create unique btree index "oh_dets_index115" on "oh_dets" (
	"purchase_req_no",
	"stock_locat",
	"supplier_code",
	"order_desc",
"order_type")
commit work;
create btree index "oh_dets_index110" on "oh_dets" (
	"order_number",
"order_status")
commit work;
create unique btree index "oh_dets_index052" on "oh_dets" (
	"order_or_credit",
	"order_status",
	"supplier_code",
	"order_date",
	"purchase_req_no",
"order_type")
commit work;
create btree index "oh_dets_index051" on "oh_dets" (
	"order_or_credit",
	"order_status",
	"supplier_code",
	"order_number",
	"order_date",
"order_type")
commit work;
create btree index "oh_dets_index050" on "oh_dets" (
	"order_status",
	"print_yn_flag",
	"order_or_credit",
	"purch_req_date",
"purchase_req_no")
commit work;
create btree index "oh_dets_index049" on "oh_dets" (
	"order_number",
	"order_date",
	"order_type",
	"supplier_code",
"financial_year")
commit work;
create btree index "oh_dets_index034" on "oh_dets" (
	"supplier_code",
"order_number")
commit work;
create btree index "oh_dets_index033" on "oh_dets" (
	"order_status",
	"print_yn_flag",
	"order_date",
"order_number")
commit work;
create unique btree index "oh_dets_index032" on "oh_dets" (
"purchase_req_no")
commit work;
create unique btree index "oh_dets_index116" on "oh_dets" (
	"supplier_code",
"purchase_req_no")
commit work;
create unique hash index "oh_dets_index" on "oh_dets" ("purchase_req_no")
commit work;
create table "au_limit" (
	primary key ("contract_type","grade"),
	"contract_type"	char	(3)	not null,
	"grade"	char	(3)	not null,
	"maximum_val_fld"	amount	(9)
	"minimum_val_fld"	amount	(9)
commit work;
create unique hash index "au_limit_index" on "au_limit" ("contract_type","grade")
commit work;
create table "auth_grd" (
	"auth_grade"	char	(3)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "auth_grd_index" on "auth_grd" ("auth_grade")
commit work;
create table "std_jobs" (
	"standard_job_id"	char	(12)	not null primary key,
	"grade_1"	char	(3),
	"quantity_1"	numeric	(1)
	"grade_2"	char	(3),
	"quantity_2"	numeric	(1)
	"grade_3"	char	(3),
	"quantity_3"	numeric	(1)
	"grade_4"	char	(3),
	"quantity_4"	numeric	(1)
	"trade_code"	char	(1),
	"safety_permit"	char	(1),
	"standard_hours"	amount	(5)
	"descript_1"	char	(50),
	"descript_2"	char	(50),
	"descript_3"	char	(50),
	"descript_4"	char	(50),
	"descript_5"	char	(50),
	"descript_6"	char	(50),
	"descript_7"	char	(50),
	"external_descript"	char	(11));
commit work;
create unique hash index "std_jobs_index" on "std_jobs" ("standard_job_id")
commit work;
create table "bld_appt" (
	primary key ("site_code","building_code","occupy_dept"),
	"site_code"	char	(3)	not null,
	"building_code"	char	(3)	not null,
	"occupy_dept"	char	(3)	not null,
	"percentage"	amount	(5)
commit work;
create unique hash index "bld_appt_index" on "bld_appt" ("site_code","building_code","occupy_dept")
commit work;
create table "occ_dept" (
	"occ_department"	char	(3)	not null primary key,
	"occ_descript"	char	(24));
commit work;
create unique hash index "occ_dept_index" on "occ_dept" ("occ_department")
commit work;
create table "fin_pers" (
	"period"	char	(6)	not null primary key,
	"start_date"	huge date
	"end_date"	huge date
	"minimus"	huge amount
	"charges_run_date"	huge date
	"index_y_or_n"	char	(1),
	"no_of_periods"	numeric	(2)	not null
commit work;
create btree index "fin_pers_index161" on "fin_pers" (
	"charges_run_date",
"start_date")
commit work;
create btree index "fin_pers_index162" on "fin_pers" (
	"charges_run_date",
	"period",
"start_date")
commit work;
create unique hash index "fin_pers_index" on "fin_pers" ("period")
commit work;
create table "doc_type" (
	"document_type"	char	(2)	not null primary key,
	"descript"	char	(24),
	"minimum_val_fld"	numeric	(6)
	"maximum_val_fld"	numeric	(6)
	"last_used_number"	numeric	(6)
	"warning_level"	numeric	(3)
	"external_code"	char	(8));
commit work;
create unique hash index "doc_type_index" on "doc_type" ("document_type")
commit work;
create table "as_locs" (
	primary key ("identifier","asset_id"),
	"identifier"	char	(10)	not null,
	"asset_id"	char	(6)	not null);
commit work;
create btree index "as_loc_index001" on "as_locs" (
	"identifier",
"asset_id")
commit work;
create unique hash index "as_loc_index" on "as_locs" ("identifier","asset_id")
commit work;
create table "calendar" (
	"calendar_date"	huge date	not null primary key
	"calendar_day"	char	(3),
	"start_time"	time
	"hours_worked"	amount	(4)
commit work;
create unique hash index "calendar_index" on "calendar" ("calendar_date")
commit work;
create table "cc_dets" (
	"clock_card_no"	char	(6)	not null primary key,
	"grade"	char	(3),
	"cost_centre"	char	(4),
	"workshop"	char	(3),
	"trade"	char	(1),
	"basic_hours"	amount	(5)
	"name"	char	(24),
	"team_id"	char	(6),
	"date_joined"	huge date
	"date_left"	huge date
commit work;
create btree index "cc_dets_index157" on "cc_dets" (
	"clock_card_no",
	"date_left",
"date_joined")
commit work;
create btree index "cc_dets_index156" on "cc_dets" (
	"team_id",
	"date_left",
"date_joined")
commit work;
create unique btree index "cc_dets_index016" on "cc_dets" (
	"clock_card_no",
	"grade",
"cost_centre")
commit work;
create btree index "cc_dets_index155" on "cc_dets" (
"team_id")
commit work;
create unique hash index "cc_dets_index" on "cc_dets" ("clock_card_no")
commit work;
create table "perm_plan" (
	primary key ("property_id","plan_ref_code"),
	"property_id"	numeric	(9)	not null
	"plan_ref_code"	char	(20)	not null,
	"descript"	text
	"granted_date"	huge date
	"rescind_date"	huge date
	"perm_stat"	char	(1),
	"submit_date"	huge date
commit work;
create btree index "perm_plan_index002" on "perm_plan" (
	"plan_ref_code",
"property_id")
commit work;
create btree index "perm_plan_index001" on "perm_plan" (
"plan_ref_code")
commit work;
create unique hash index "perm_plan_index" on "perm_plan" ("property_id","plan_ref_code")
commit work;
create table "blck_appt" (
	primary key ("property_id","block_ref","department","division","business_unit"),
	"property_id"	numeric	(9)	not null
	"block_ref"	char	(2)	not null,
	"department"	char	(4)	not null,
	"division"	char	(4)	not null,
	"business_unit"	char	(4)	not null,
	"apport_percent"	amount	(6)
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
commit work;
create btree index "blck_appt_index003" on "blck_appt" (
	"property_id",
	"block_ref",
	"department",
	"division",
"business_unit")
commit work;
create btree index "blck_appt_index002" on "blck_appt" (
	"block_ref",
"property_id")
commit work;
create btree index "blck_appt_index001" on "blck_appt" (
	"block_ref",
	"business_unit",
	"department",
	"division",
"property_id")
commit work;
create unique hash index "blck_appt_index" on "blck_appt" ("property_id","block_ref","department","division","business_unit")
commit work;
create table "lse_o_acq" (
	primary key ("property_id","seq_no","deed_packet_ref","record_type","type_flag","acq_app_sale_date"),
	"property_id"	numeric	(9)	not null
	"seq_no"	numeric	(3)	not null
	"deed_packet_ref"	char	(12)	not null,
	"record_type"	char	(4)	not null,
	"type_flag"	char	(1)	not null,
	"acq_app_sale_date"	huge date	not null
	"acreage"	float	(64)
	"area_other"	float	(64)
	"expiry_date"	huge date
	"initial_capital"	numeric	(8)
	"secondary_terr_ref"	char	(7),
	"val_in"	numeric	(9)
	"yearly_rate"	numeric	(8)
commit work;
create btree index "lse_o_acq_index001" on "lse_o_acq" (
	"property_id",
	"deed_packet_ref",
	"record_type",
"type_flag")
commit work;
create btree index "lse_o_acq_index002" on "lse_o_acq" (
	"property_id",
	"deed_packet_ref",
	"record_type",
	"type_flag",
"acq_app_sale_date")
commit work;
create unique hash index "lse_o_acq_index" on "lse_o_acq" ("property_id","seq_no","deed_packet_ref","record_type","type_flag","acq_app_sale_date")
commit work;
create table "int_rate" (
	primary key ("int_type","fin_year"),
	"int_type"	char	(2)	not null,
	"fin_year"	char	(4)	not null,
	"descript"	char	(24),
	"interest"	amount	(6)
commit work;
create unique hash index "int_rate_index" on "int_rate" ("int_type","fin_year")
commit work;
create table "ca_dets" (
	primary key ("capital_asset_code","capital_sub_asset_no"),
	"capital_asset_code"	char	(21)	not null,
	"capital_sub_asset_no"	numeric	(4)	not null
	"notes"	char	(50),
	"charge_type"	char	(6),
	"pr_index_type"	char	(3),
	"purchase_type"	char	(1),
	"acceptance_date"	huge date
	"replacement_date"	huge date
	"remaining_life"	numeric	(4)
	"last_charged"	char	(6),
	"purchase_price"	huge amount
	"indexed_replacement_cost"	huge amount
	"depreciation_to_date"	huge amount
	"net_book_val_fld"	huge amount
	"interest"	huge amount
	"division"	char	(4),
	"management_unit"	char	(4),
	"cost_centre"	char	(4),
	"account_code"	char	(15),
	"asset_id"	char	(6),
	"property_id"	numeric	(9)
	"prev_capital_asset_code"	char	(21),
	"int_type"	char	(2),
	"prev_capital_sub_asset_no"	numeric	(4)
	"asset_status"	char	(2),
	"residual_val_fld"	huge amount
	"apportionment_count"	numeric	(4)
commit work;
create btree index "ca_dets_index001" on "ca_dets" (
"property_id")
commit work;
create btree index "ca_dets_index167" on "ca_dets" (
	"asset_status",
"pr_index_type")
commit work;
create btree index "ca_dets_index164" on "ca_dets" (
	"cost_centre",
	"management_unit",
	"division",
"acceptance_date")
commit work;
create btree index "ca_dets_index163" on "ca_dets" (
	"division",
	"management_unit",
	"cost_centre",
"asset_status")
commit work;
create btree index "ca_dets_index160" on "ca_dets" (
	"asset_status",
"acceptance_date")
commit work;
create btree index "ca_dets_index_01" on "ca_dets" (
"asset_id")
commit work;
create btree index "ca_dets_index_02" on "ca_dets" (
"property_id")
commit work;
create unique hash index "ca_dets_index" on "ca_dets" ("capital_asset_code","capital_sub_asset_no")
commit work;
create table "ch_type" (
	"charge_code"	char	(6)	not null primary key,
	"descript"	char	(24),
	"classification"	char	(1),
	"life"	numeric	(3)
	"depreciation_type"	char	(1),
	"asset_group"	char	(3),
	"basis_of_valuation"	char	(24));
commit work;
create unique hash index "ch_type_index" on "ch_type" ("charge_code")
commit work;
create table "con_det" (
	"contract_code"	char	(6)	not null primary key,
	"descript_1"	char	(50),
	"descript_2"	char	(50),
	"descript_3"	char	(50),
	"descript_4"	char	(50),
	"descript_5"	char	(50),
	"descript_6"	char	(50),
	"descript_7"	char	(50));
commit work;
create unique hash index "con_det_index" on "con_det" ("contract_code")
commit work;
create table "pw_dets" (
	"usr_code"	char	(20)	not null primary key,
	"descript"	binary);
commit work;
create unique hash index "pw_dets_index" on "pw_dets" ("usr_code")
commit work;
create table "as_group" (
	"group_code"	char	(3)	not null primary key,
	"descript"	char	(24),
	"cost_centre"	char	(4),
	"account_code"	char	(15));
commit work;
create unique hash index "as_group_index" on "as_group" ("group_code")
commit work;
create table "ct_type" (
	"contract_type"	char	(3)	not null primary key,
	"descript"	char	(24),
	"auth_required"	char	(1));
commit work;
create unique hash index "ct_type_index" on "ct_type" ("contract_type")
commit work;
create table "cw_dets" (
	"cw_dets_job_id"	char	(6)	not null primary key,
	"detail_1"	char	(50),
	"detail_2"	char	(50),
	"detail_3"	char	(50),
	"detail_4"	char	(50),
	"detail_5"	char	(50),
	"detail_6"	char	(50),
	"detail_7"	char	(50));
commit work;
create unique btree index "cw_dets_index127" on "cw_dets" (
"cw_dets_job_id")
commit work;
create unique hash index "cw_dets_index" on "cw_dets" ("cw_dets_job_id")
commit work;
create table "ch_hist" (
	primary key ("cap_ass_code","cap_ass_sub","charge_period"),
	"cap_ass_code"	char	(21)	not null,
	"cap_ass_sub"	numeric	(4)	not null
	"charge_period"	char	(6)	not null,
	"ind_rep_cost"	huge amount
	"residual_val_fld"	huge amount
	"dep_this_per"	huge amount
	"int_this_per"	huge amount
	"dep_to_date"	huge amount
	"asset_group"	char	(3));
commit work;
create unique hash index "ch_hist_index" on "ch_hist" ("cap_ass_code","cap_ass_sub","charge_period")
commit work;
create table "wk_teams" (
	"team_id"	char	(6)	not null primary key,
	"descript"	char	(24),
	"finalised_week"	char	(7),
	"overtime_target"	amount	(5)
	"leave_target"	amount	(5)
	"sick_target"	amount	(5)
	"absence_target"	amount	(5)
	"divert_target"	amount	(5)
	"wait_target"	amount	(5)
	"travel_target"	amount	(5)
	"available_target"	amount	(5)
	"missing_target"	amount	(5)
	"unassigned_target"	amount	(5)
	"spent_target"	amount	(5)
	"standard_target"	amount	(5)
	"actual_target"	amount	(5)
	"cost_target"	amount	(5)
	"productivity_target"	amount	(5)
	"measured_target"	amount	(5)
commit work;
create unique btree index "wk_teams_index154" on "wk_teams" (
"team_id")
commit work;
create unique hash index "wk_teams_index" on "wk_teams" ("team_id")
commit work;
create table "ass_con" (
	primary key ("asset_id","contract_code"),
	"asset_id"	char	(6)	not null,
	"contract_code"	char	(6)	not null);
commit work;
create unique hash index "ass_con_index" on "ass_con" ("asset_id","contract_code")
commit work;
create table "activity" (
	"activity_code"	char	(4)	not null primary key,
	"descript"	char	(24),
	"reporting_category"	numeric	(2)
	"payment_factor"	amount	(5)
	"attached_to_job"	char	(1),
	"paid_time"	char	(1),
	"attendance_activity"	char	(1),
	"cost_centre"	char	(4),
	"account_code"	char	(15));
commit work;
create unique hash index "activity_index" on "activity" ("activity_code")
commit work;
create table "ap_hist" (
	primary key ("capital_asset_code","capital_sub_asset_code","effective_date"),
	"capital_asset_code"	char	(21)	not null,
	"capital_sub_asset_code"	numeric	(4)	not null
	"effective_date"	huge date	not null
	"division"	char	(4),
	"management_unit"	char	(4),
	"cost_centre"	char	(4),
	"account_code"	char	(15),
	"percentage"	amount	(3)
	"donated"	char	(1));
commit work;
create unique hash index "ap_hist_index" on "ap_hist" ("capital_asset_code","capital_sub_asset_code","effective_date")
commit work;
create table "cx_dets" (
	"sequence_number"	numeric	(6)	not null primary key
	"capital_asset_code"	char	(21),
	"capital_sub_asset_code"	numeric	(4)
	"transaction_date"	huge date
	"transaction_time"	time
	"originator"	char	(15),
	"transaction_type"	char	(3),
	"old_val_fld"	char	(25),
	"new_val_fld"	char	(25),
	"reason"	char	(24),
	"division"	char	(6),
	"management_unit"	char	(4),
	"cost_centre"	char	(4),
	"account_code"	char	(15),
	"effective_date"	huge date
	"effective_period"	char	(6));
commit work;
create btree index "cx_dets_index01" on "cx_dets" (
	"capital_asset_code",
	"capital_sub_asset_code",
	"effective_period",
	"transaction_type",
"effective_date")
commit work;
create btree index "cx_dets_index165" on "cx_dets" (
	"transaction_type",
	"effective_date",
	"cost_centre",
	"management_unit",
"division")
commit work;
create btree index "cx_dets_index166" on "cx_dets" (
	"effective_date",
	"capital_asset_code",
	"capital_sub_asset_code",
"transaction_type")
commit work;
create unique hash index "cx_dets_index" on "cx_dets" ("sequence_number")
commit work;
create table "b_drc_dets" (
	"property_id"	numeric	(9)	not null primary key
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"asset_category"	char	(2),
	"grs_int_flr_area"	numeric	(7)
	"asset_value"	numeric	(9)
	"age_of_block"	numeric	(4)
	"life_of_block"	numeric	(2)
	"condition_of_block"	char	(4),
	"eco_obs_factor"	numeric	(3)
	"func_obs_factor"	numeric	(3)
	"environment_factor"	numeric	(3)
	"drc_for_block"	numeric	(9)
	"eff_val_date"	huge date
	"date_val_carr_out"	huge date
	"valuer_code"	char	(4));
commit work;
create btree index "b_drc_dets_index001" on "b_drc_dets" (
"property_id")
commit work;
create unique hash index "b_drc_dets_index" on "b_drc_dets" ("property_id")
commit work;
create table "hlp_info" (
	primary key ("hlp_level","frm_name","fld_name","instance"),
	"hlp_level"	char	(1)	not null,
	"frm_name"	char	(44)	not null,
	"fld_name"	char	(44)	not null,
	"instance"	numeric	(4)	not null
	"hlp_line"	char	(40));
commit work;
create unique btree index "hlp_info_index001" on "hlp_info" (
	"hlp_level",
	"frm_name",
	"fld_name",
"instance")
commit work;
create btree index "hlp_info_index002" on "hlp_info" (
"instance")
commit work;
create unique hash index "hlp_info_index" on "hlp_info" ("hlp_level","frm_name","fld_name","instance")
commit work;
create table "cd_dets" (
	"contract_code"	char	(6)	not null primary key,
	"budget"	numeric	(8)
	"purchase_ordno"	char	(8),
	"descript"	char	(24),
	"start_date"	huge date
	"period_months"	numeric	(2)
	"termin_period"	numeric	(4)
	"supplier_code"	char	(8),
	"renewal_date"	huge date
	"payment_method"	char	(2),
	"sup_contract_ref"	char	(8),
	"contract_type"	char	(3),
	"live_flag"	char	(1),
	"date_completed"	huge date
commit work;
create unique btree index "cd_dets_index009" on "cd_dets" (
"contract_code")
commit work;
create unique hash index "cd_dets_index" on "cd_dets" ("contract_code")
commit work;
create table "as_invy" (
	primary key ("asset_id","inv_code"),
	"asset_id"	char	(6)	not null,
	"inv_code"	char	(8)	not null,
	"descript"	char	(24),
	"serial_no"	char	(20),
	"quantity"	numeric	(3)
	"price"	amount	(9)
commit work;
create unique hash index "as_invy_index" on "as_invy" ("asset_id","inv_code")
commit work;
create table "department" (
	"dept_code"	char	(5)	not null primary key,
	"dept_descript"	char	(40));
commit work;
create btree index "department_index001" on "department" (
"dept_code")
commit work;
create unique hash index "department_index" on "department" ("dept_code")
commit work;
create table "deployment" (
	"depl_code"	char	(1)	not null primary key,
	"depl_descript"	char	(40));
commit work;
create btree index "deployment_index001" on "deployment" (
"depl_code")
commit work;
create unique hash index "deployment_index" on "deployment" ("depl_code")
commit work;
create table "pu_type" (
	"purchase_type"	char	(1)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "pu_type_index" on "pu_type" ("purchase_type")
commit work;
create table "formdef" (
	primary key ("menu_name","form_nam"),
	"menu_name"	char	(10)	not null,
	"form_nam"	char	(10)	not null,
	"position"	numeric	(2)
	"available"	char	(1),
	"menu_text"	char	(35));
commit work;
create btree index "formdef_index002" on "formdef" (
	"position",
"menu_text")
commit work;
create btree index "formdef_index001" on "formdef" (
"menu_name")
commit work;
create unique btree index "formdef_index018" on "formdef" (
	"menu_name",
"form_nam")
commit work;
create unique hash index "formdef_index" on "formdef" ("menu_name","form_nam")
commit work;
create table "blck_dets" (
	primary key ("property_id","block_ref"),
	"property_id"	numeric	(9)	not null
	"block_ref"	char	(2)	not null,
	"approx_flag"	char	(1),
	"area_x_cost"	numeric	(9)
	"bcis_index"	char	(5),
	"block_usage1"	char	(5),
	"block_usage2"	char	(5),
	"block_usage3"	char	(5),
	"block_usage4"	char	(5),
	"block_usage5"	char	(5),
	"block_usage6"	char	(5),
	"block_usage_all"	char	(42),
	"construct_year"	char	(4),
	"demolition_cost"	numeric	(9)
	"ext_works_ind"	amount	(7)
	"fees_index"	amount	(7)
	"fire_rein_val"	numeric	(9)
	"g_ext_b_area_m"	numeric	(5)
	"g_int_flr_sq_m"	huge amount
	"handover_date"	huge date
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"listed_build"	char	(1),
	"listed_grade"	char	(5),
	"listing_desc"	text
	"l_survey_date"	huge date
	"nxt_survey_date"	huge date
	"max_flrs_no"	numeric	(2)
	"net_flr_meas"	char	(1),
	"net_flr_sq_m1"	numeric	(4)
	"net_flr_sq_m2"	numeric	(4)
	"net_flr_sq_m3"	numeric	(4)
	"net_flr_sq_m4"	numeric	(4)
	"net_flr_sq_m5"	numeric	(4)
	"net_flr_sq_m6"	numeric	(4)
	"net_flr_sq_m7"	numeric	(4)
	"net_flr_sq_m8"	numeric	(4)
	"net_int_area"	huge amount
	"net_let_area"	huge amount
	"no_of_rooms"	numeric	(9)
	"number_of_floors"	numeric	(3)
	"overall_blck_cond"	char	(4),
	"room_count_src"	char	(1),
	"survey_source"	char	(1),
	"temp_construct"	char	(1),
	"usable_rms_no_1"	numeric	(3)
	"usable_rms_no_2"	numeric	(3)
	"usable_rms_no_3"	numeric	(3)
	"usable_rms_no_4"	numeric	(3)
	"usable_rms_no_5"	numeric	(3)
	"usable_rms_no_6"	numeric	(3)
	"usable_rms_no_7"	numeric	(3)
	"usable_rms_no_8"	numeric	(3)
	"total_usable_rms"	numeric	(5)
	"total_area_rms"	numeric	(5)
	"gross_int_sq_m1"	numeric	(4)
	"gross_int_sq_m2"	numeric	(4)
	"gross_int_sq_m3"	numeric	(4)
	"gross_int_sq_m4"	numeric	(4)
	"gross_int_sq_m5"	numeric	(4)
	"gross_int_sq_m6"	numeric	(4)
	"gross_int_sq_m7"	numeric	(4)
	"gross_int_sq_m8"	numeric	(4)
	"remaining_life"	numeric	(9)
	"const_type"	char	(4),
	"l_upgrade_date"	huge date
	"upgrade_text"	text
	"blck_text"	text
	"disabled_access"	text
	"net_space_sqm"	huge amount
	"net_int_sqm"	huge amount
	"bal_area_sqm"	huge amount
	"other_area"	huge amount
	"heated_vol_cum"	huge amount
	"l_mkt_valuation"	huge amount
	"present_date"	huge date
	"p_mrkt_value"	huge amount
	"potential_date"	huge date
	"fire_date"	huge date
	"l_ins_renw_date"	huge date
	"demolition_date"	huge date
	"other_val"	huge amount
	"g_ext_flr_sq_m"	huge amount
	"room_area_sqm"	huge amount
	"gross_vol_cu_m"	huge amount
	"other_date"	huge date
commit work;
create btree index "blck_dets_index001" on "blck_dets" (
"block_ref")
commit work;
create btree index "blck_dets_index002" on "blck_dets" (
	"overall_blck_cond",
"block_ref")
commit work;
create btree index "blck_dets_index003" on "blck_dets" (
"property_id")
commit work;
create btree index "blck_dets_index004" on "blck_dets" (
	"property_id",
"block_ref")
commit work;
create unique hash index "blck_dets_index" on "blck_dets" ("property_id","block_ref")
commit work;
create table "setup" (
	"dummy"	char	(1)	not null primary key,
	"usr"	char	(1),
	"initialise"	text
	"err_message"	text
commit work;
create unique hash index "setup_index" on "setup" ("dummy")
commit work;
create table "plan_appl" (
	primary key ("property_id","sequence_no"),
	"property_id"	numeric	(9)	not null
	"sequence_no"	numeric	(9)	not null
	"decision_date"	huge date
	"descript"	text
	"granted_flag"	char	(1),
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"planning_applic"	char	(20),
	"plan_stat"	char	(1),
	"submit_date"	huge date
	"temp_or_perm"	char	(1));
commit work;
create btree index "plan_appl_index002" on "plan_appl" (
	"property_id",
"planning_applic")
commit work;
create btree index "plan_appl_index001" on "plan_appl" (
"property_id")
commit work;
create unique hash index "plan_appl_index" on "plan_appl" ("property_id","sequence_no")
commit work;
create table "rep_cat" (
	"reporting_cat_id"	numeric	(2)	not null primary key
	"descript"	char	(24));
commit work;
create unique hash index "rep_cat_index" on "rep_cat" ("reporting_cat_id")
commit work;
create table "ft_type" (
	"fault_code"	char	(3)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "ft_type_index" on "ft_type" ("fault_code")
commit work;
create table "ph_j_det" (
	"job_dets_id"	char	(6)	not null primary key,
	"detail_1"	char	(50),
	"detail_2"	char	(50),
	"detail_3"	char	(50),
	"detail_4"	char	(50),
	"detail_5"	char	(50),
	"detail_6"	char	(50),
	"detail_7"	char	(50));
commit work;
create unique btree index "ph_j_det_index138" on "ph_j_det" (
"job_dets_id")
commit work;
create unique hash index "ph_j_det_index" on "ph_j_det" ("job_dets_id")
commit work;
create table "fye_dets" (
	"financial_year"	char	(4)	not null primary key,
	"descript"	char	(24),
	"no_periods_in_yr"	numeric	(2)
commit work;
create unique btree index "fye_dets_index111" on "fye_dets" (
"financial_year")
commit work;
create unique btree index "fye_dets_index112" on "fye_dets" (
	"financial_year" DESC);
commit work;
create unique hash index "fye_dets_index" on "fye_dets" ("financial_year")
commit work;
create table "gd_type" (
	"grade_code"	char	(3)	not null primary key,
	"descript"	char	(24),
	"hourly_rate"	amount	(4)
commit work;
create unique hash index "gd_type_index" on "gd_type" ("grade_code")
commit work;
create table "rgn_dets" (
	"return_number"	numeric	(6)	not null primary key
	"return_date"	huge date
	"financial_period"	numeric	(2)
	"financial_year"	char	(4),
	"returned_from"	char	(8),
	"returned_to"	char	(8),
	"order_number"	numeric	(8)
	"order_line_no"	numeric	(3)
	"credit_note_no"	char	(12),
	"grn_number"	char	(10),
	"return_quantity"	numeric	(5)
	"return_val_fld"	amount	(9)
	"credit_qty"	numeric	(5)
	"credit_val_fld"	amount	(9)
	"locat"	numeric	(2)
	"credit_date"	huge date
	"document_type"	char	(2),
	"document_number"	numeric	(6)
	"credit_period"	numeric	(2)
	"credit_year"	char	(4),
	"vat_val_fld"	amount	(9)
	"entered_by"	char	(8),
	"entered_on"	huge date
	"include_in_batch"	char	(1),
	"batch_number"	numeric	(6)
	"account_code"	char	(15),
	"cost_centre"	char	(4));
commit work;
create btree index "rgn_dets_index001" on "rgn_dets" (
	"batch_number",
"document_type")
commit work;
create unique hash index "rgn_dets_index" on "rgn_dets" ("return_number")
commit work;
create table "pi_index" (
	primary key ("index_code","history_number"),
	"index_code"	char	(3)	not null,
	"history_number"	numeric	(3)	not null
	"descript"	char	(24),
	"last_updated"	huge date
	"old_val_fld"	amount	(6)
	"new_val_fld"	amount	(6)
	"effective_date"	huge date
commit work;
create btree index "pi_index_index168" on "pi_index" (
"last_updated")
commit work;
create btree index "pi_index_index169" on "pi_index" (
"history_number")
commit work;
create btree index "pi_index_index170" on "pi_index" (
	"index_code",
"history_number")
commit work;
create unique hash index "pi_index_index" on "pi_index" ("index_code","history_number")
commit work;
create table "jb_type" (
	"job_type_code"	char	(2)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "jb_type_index" on "jb_type" ("job_type_code")
commit work;
create table "jc_type" (
	"job_category"	char	(2)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "jc_type_index" on "jc_type" ("job_category")
commit work;
create table "scan_dckt" (
	"docket_no"	char	(6)	not null primary key,
	"trade"	char	(1),
	"delay_date_comp"	huge date
	"detail_1"	char	(50),
	"detail_2"	char	(50),
	"detail_3"	char	(50),
	"detail_4"	char	(50),
	"detail_5"	char	(50),
	"detail_6"	char	(50),
	"detail_7"	char	(50),
	"batch_number"	numeric	(6)
commit work;
create unique hash index "scan_dckt_index" on "scan_dckt" ("docket_no")
commit work;
create table "ex_type" (
	"exception_status"	char	(2)	not null primary key,
	"descript"	char	(24));
commit work;
create unique btree index "ex_type_index002" on "ex_type" (
"exception_status")
commit work;
create unique hash index "ex_type_index" on "ex_type" ("exception_status")
commit work;
create table "ln_type" (
	"order_line_stat"	char	(1)	not null primary key,
	"descript"	char	(24));
commit work;
create unique btree index "ln_type_index062" on "ln_type" (
"order_line_stat")
commit work;
create unique hash index "ln_type_index" on "ln_type" ("order_line_stat")
commit work;
create table "lo_dets" (
	"stock_loc_code"	numeric	(2)	not null primary key
	"cost_centre"	char	(4),
	"b_fwd_grn_val_fld"	amount	(9)
	"b_fwd_grn_qty"	numeric	(7)
	"descript"	char	(24),
	"address_code"	char	(8));
commit work;
create unique btree index "lo_dets_index064" on "lo_dets" (
"stock_loc_code")
commit work;
create btree index "lo_dets_index001" on "lo_dets" (
"stock_loc_code")
commit work;
create unique hash index "lo_dets_index" on "lo_dets" ("stock_loc_code")
commit work;
create table "loc_dets" (
	primary key ("locat_code","site_code","building_code"),
	"locat_code"	char	(6)	not null,
	"site_code"	char	(3)	not null,
	"building_code"	char	(3)	not null,
	"descript"	char	(24));
commit work;
create unique btree index "loc_dets_index015" on "loc_dets" (
	"site_code",
	"building_code",
"locat_code")
commit work;
create unique btree index "loc_dets_index135" on "loc_dets" (
	"locat_code",
	"building_code",
"site_code")
commit work;
create unique hash index "loc_dets_index" on "loc_dets" ("locat_code","site_code","building_code")
commit work;
create table "ls_dets" (
	primary key ("stock_code","stock_loc_code"),
	"stock_code"	char	(10)	not null,
	"stock_loc_code"	numeric	(2)	not null
	"b_fwd_arch_val"	amount	(8)
	"grn_counter"	numeric	(2)
	"b_fwd_wip_qty"	numeric	(5)
	"b_fwd_wip_val"	amount	(8)
	"stock_balance"	numeric	(5)
	"min_stock_level"	numeric	(5)
	"max_stock_level"	numeric	(5)
	"re_order_level"	numeric	(5)
	"on_order_balance"	numeric	(5)
	"on_order_ord_no"	numeric	(8)
	"date_last_issued"	huge date
	"usage_this_year"	numeric	(5)
	"his_annual_usage"	numeric	(5)
	"bin_ref_fld"	char	(10),
	"brought_fwd_qty"	numeric	(5)
	"brought_fwd_val"	amount	(8)
	"stock_val_fld"	amount	(9)
	"b_fwd_arch_qty"	numeric	(5)
	"quotation_requested"	char	(1));
commit work;
create unique btree index "ls_dets_index114" on "ls_dets" (
	"stock_code",
	"stock_loc_code",
"stock_balance")
commit work;
create unique btree index "ls_dets_index056" on "ls_dets" (
	"stock_code",
"stock_loc_code")
commit work;
create unique hash index "ls_dets_index" on "ls_dets" ("stock_code","stock_loc_code")
commit work;
create table "main_pln" (
	"main_plan_code"	char	(2)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "main_pln_index" on "main_pln" ("main_plan_code")
commit work;
create table "ag_type" (
	"agree_type"	char	(1)	not null primary key,
	"descript"	char	(30));
commit work;
create btree index "ag_type_index001" on "ag_type" (
"agree_type")
commit work;
create unique hash index "ag_type_index" on "ag_type" ("agree_type")
commit work;
create table "nam_adds" (
	"name_and_address"	char	(8)	not null primary key,
	"discount"	char	(1),
	"name"	char	(30),
	"address_line_1"	char	(30),
	"address_line_2"	char	(30),
	"address_line_3"	char	(30),
	"address_line_4"	char	(30),
	"telephone_no"	char	(15),
	"telex_no"	char	(15),
	"fax_number"	char	(15),
	"contact_name"	char	(24),
	"supplier_type"	char	(2),
	"delivery_charge"	char	(1),
	"lead_time"	numeric	(3)
	"buyer_text_1"	char	(40),
	"buyer_text_2"	char	(40),
	"extension"	char	(6),
	"buyer_text_3"	char	(40),
	"buyer_text_4"	char	(40),
	"buyer_text_5"	char	(40),
	"buyer_text_6"	char	(40),
	"buyer_text_7"	char	(40),
	"buyer_text_8"	char	(40),
	"payment_indic"	char	(2),
	"apprv_contractor"	char	(1),
	"on_cg_apprv_list"	char	(1),
	"date_approved"	huge date
	"min_order_val_fld"	numeric	(9)
	"max_order_val_fld"	numeric	(9)
	"post_code"	char	(15),
	"supplier_type2"	char	(2),
	"supplier_type3"	char	(2),
	"supplier_type4"	char	(2),
	"supplier_type5"	char	(2),
	"supplier_type6"	char	(2));
commit work;
create unique btree index "nam_adds_index010" on "nam_adds" (
"name_and_address")
commit work;
create btree index "nam_adds_index001" on "nam_adds" (
"name_and_address")
commit work;
create unique hash index "nam_adds_index" on "nam_adds" ("name_and_address")
commit work;
create table "mu_dets" (
	"management_unit"	char	(4)	not null primary key,
	"descript"	char	(24),
	"address_line_1"	char	(25),
	"address_line_2"	char	(25),
	"address_line_3"	char	(25),
	"address_line_4"	char	(15),
	"telephone_no"	char	(15),
	"telephone_ext"	char	(8),
	"manager_name"	char	(24),
	"locat"	char	(16),
	"committee_or_division"	char	(4));
commit work;
create unique btree index "mu_dets_index149" on "mu_dets" (
"management_unit")
commit work;
create btree index "mu_dets_index002" on "mu_dets" (
	"management_unit",
"committee_or_division")
commit work;
create unique hash index "mu_dets_index" on "mu_dets" ("management_unit")
commit work;
create table "pj_sched" (
	primary key ("project_code","line_number"),
	"project_code"	char	(6)	not null,
	"line_number"	numeric	(2)	not null
	"target_date"	huge date
	"forecast_date"	huge date
	"actual_date"	huge date
	"percent_complete"	char	(3));
commit work;
create unique btree index "pj_sched_index011" on "pj_sched" (
	"project_code",
"line_number")
commit work;
create unique hash index "pj_sched_index" on "pj_sched" ("project_code","line_number")
commit work;
create table "ph_w_don" (
	"work_done_id"	char	(6)	not null primary key,
	"detail_1"	char	(50),
	"detail_2"	char	(50),
	"detail_3"	char	(50),
	"detail_4"	char	(50),
	"detail_5"	char	(50),
	"detail_6"	char	(50),
	"detail_7"	char	(50));
commit work;
create unique btree index "ph_w_don_index140" on "ph_w_don" (
"work_done_id")
commit work;
create unique hash index "ph_w_don_index" on "ph_w_don" ("work_done_id")
commit work;
create table "os_type" (
	"order_stat_code"	char	(1)	not null primary key,
	"descript"	char	(24));
commit work;
create unique btree index "os_type_index061" on "os_type" (
"order_stat_code")
commit work;
create unique hash index "os_type_index" on "os_type" ("order_stat_code")
commit work;
create table "ot_type" (
	"order_type_code"	char	(1)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "ot_type_index" on "ot_type" ("order_type_code")
commit work;
create table "usrdef" (
	"usr_code"	char	(10)	not null primary key,
	"locat_code"	numeric	(2)
	"create_n_orders"	char	(1),
	"create_p_orders"	char	(1),
	"usr_name"	char	(24),
	"profile_code"	char	(2),
	"default_printer"	char	(10),
	"usr_title"	char	(24),
	"cw_del_allowed"	char	(1),
	"pm_del_allowed"	char	(1),
	"create_l_orders"	char	(1),
	"create_s_orders"	char	(1),
	"ord_auth_limit"	amount	(9)
	"usr_auth_grade"	char	(3),
	"hlp_level"	char	(1));
commit work;
create btree index "usrdef_index001" on "usrdef" (
"usr_code")
commit work;
create unique hash index "usrdef_index" on "usrdef" ("usr_code")
commit work;
create table "ph_hist" (
	"perm_history_id"	char	(6)	not null primary key,
	"workshop"	char	(3),
	"account_code"	char	(15),
	"asset_id"	char	(6),
	"site_code"	char	(3),
	"building_code"	char	(3),
	"curr_job_file_id"	char	(6),
	"project_code"	char	(6),
	"contract_code"	char	(6),
	"estimated_cost"	amount	(8)
	"frequency"	numeric	(3)
	"management_unit"	char	(4),
	"contract_type"	char	(3),
	"trade"	char	(1),
	"pm_job_no_req_no"	char	(6),
	"priority_code"	char	(2),
	"work_type"	char	(1),
	"docket_no"	char	(6),
	"ref_fld"	char	(12),
	"locat_code"	char	(6),
	"asset_no"	char	(6),
	"sub_asset_no"	char	(3),
	"asset_name"	char	(24),
	"asset_cost_cent"	char	(4),
	"labour_cost"	amount	(9)
	"materials_cost"	amount	(9)
	"asset_type"	char	(6),
	"category"	char	(2),
	"job_type_code"	char	(2),
	"wrk_done_summary"	char	(24),
	"week_planned"	char	(7),
	"date_reported"	huge date
	"date_to_comp_ex"	huge date
	"date_act_comp"	huge date
	"total_actual_hrs"	amount	(5)
	"purchase_cost"	amount	(9)
	"contract_cost"	amount	(9)
	"fault_code"	char	(3),
	"series"	numeric	(1)
	"charg_cost_cent"	char	(4),
	"financial_year"	char	(4),
	"period"	numeric	(2)
	"dorc_flag"	char	(1),
	"out_of_seq_flag"	char	(1),
	"status_flag"	char	(1),
	"wk_cont_time_hrs"	amount	(5)
	"site_code_bt"	numeric	(6)
	"building_code_bt"	numeric	(6)
	"locat_bt1"	numeric	(6)
	"locat_bt2"	numeric	(6)
	"asset_no_bt1"	numeric	(6)
	"asset_no_bt2"	numeric	(6)
	"sub_asset_no_bt"	numeric	(6)
	"allowce_time_hrs"	amount	(5)
	"rev_allow_time"	amount	(5)
	"rev_wk_cont_time"	amount	(5)
	"maintenance_plan"	char	(2),
	"resp_serv_level"	char	(2),
	"down_serv_level"	char	(2),
	"resp_date_plan"	huge date
	"resp_time_plan"	time
	"comp_date_plan"	huge date
	"comp_time_plan"	time
	"date_act_resp"	huge date
	"time_resp"	time
	"time_resp_a"	amount	(4)
	"tot_hours_resp"	amount	(6)
	"time_comp"	time
	"time_comp_a"	amount	(4)
	"tot_hours_comp"	amount	(6)
	"logged_by"	char	(10),
	"log_date"	huge date
	"log_time"	time
	"phoenix_code"	char	(6),
	"reported_by"	char	(24));
commit work;
create btree index "bt256" on "ph_hist" (
"wrk_done_summary")
commit work;
create btree index "ph_hist_index177" on "ph_hist" (
	"date_act_comp",
	"wk_cont_time_hrs",
"docket_no")
commit work;
create btree index "ph_hist_index174" on "ph_hist" (
	"date_act_comp",
	"wk_cont_time_hrs",
	"rev_wk_cont_time",
"docket_no")
commit work;
create btree index "ph_hist_index173" on "ph_hist" (
	"docket_no",
	"wk_cont_time_hrs",
"date_act_comp")
commit work;
create btree index "ph_hist_index172" on "ph_hist" (
	"docket_no",
	"wk_cont_time_hrs",
	"rev_wk_cont_time",
"date_act_comp")
commit work;
create btree index "ph_hist_index166" on "ph_hist" (
	"docket_no",
	"date_act_comp",
	"rev_wk_cont_time",
"wk_cont_time_hrs")
commit work;
create btree index "ph_hist_index137" on "ph_hist" (
"work_type")
commit work;
create btree index "ph_hist_index136" on "ph_hist" (
	"site_code_bt",
	"building_code_bt",
	"locat_bt1",
	"locat_bt2",
	"asset_no_bt1",
	"asset_no_bt2",
"sub_asset_no_bt")
commit work;
create btree index "ph_hist_index068" on "ph_hist" (
	"financial_year",
"period")
commit work;
create unique btree index "ph_hist_index020" on "ph_hist" (
	"asset_id",
	"period",
"perm_history_id")
commit work;
create btree index "ph_hist_index156" on "ph_hist" (
	"docket_no",
"wk_cont_time_hrs")
commit work;
create btree index "ph_hist_index171" on "ph_hist" (
	"financial_year",
"asset_id")
commit work;
create unique hash index "ph_hist_index" on "ph_hist" ("perm_history_id")
commit work;
create table "ph_spare" (
	primary key ("locat_code","docket_no","stock_no"),
	"locat_code"	numeric	(2)	not null
	"docket_no"	char	(6)	not null,
	"stock_no"	char	(10)	not null,
	"quantity_used"	numeric	(5)
	"cost"	amount	(9)
	"stock_desc_1"	char	(40),
	"stock_desc_2"	char	(40));
commit work;
create btree index "ph_spare_index139" on "ph_spare" (
	"docket_no",
"stock_no")
commit work;
create unique hash index "ph_spare_index" on "ph_spare" ("locat_code","docket_no","stock_no")
commit work;
create table "cc_phist" (
	"uniquifier"	numeric	(6)	not null primary key
	"clock_card_no"	char	(6),
	"date_recorded"	huge date
	"activity_code"	char	(4),
	"entered_date"	huge date
	"entered_time"	time
	"hours"	amount	(5)
	"docket_number"	char	(6),
	"time_factor"	amount	(4)
	"name"	char	(24),
	"hourly_rate"	amount	(4)
	"entered_by"	char	(8),
	"team_id"	char	(6),
	"rep_category"	numeric	(2)
commit work;
create btree index "cc_phist_index158" on "cc_phist" (
	"date_recorded",
	"clock_card_no",
"docket_number")
commit work;
create btree index "cc_phist_index157" on "cc_phist" (
	"team_id",
	"date_recorded",
"docket_number")
commit work;
create btree index "cc_phist_index156" on "cc_phist" (
	"date_recorded",
	"docket_number",
"clock_card_no")
commit work;
create btree index "cc_phist_index155" on "cc_phist" (
	"clock_card_no",
	"date_recorded",
"docket_number")
commit work;
create btree index "cc_phist_index154" on "cc_phist" (
	"team_id",
"docket_number")
commit work;
create btree index "cc_phist_index151" on "cc_phist" (
"activity_code")
commit work;
create btree index "cc_phist_index1" on "cc_phist" (
	"clock_card_no",
	"date_recorded",
	"activity_code",
	"entered_date",
"entered_time")
commit work;
create btree index "cc_phist_index057" on "cc_phist" (
	"docket_number",
"date_recorded")
commit work;
create btree index "cc_phist_index017" on "cc_phist" (
	"clock_card_no",
"date_recorded")
commit work;
create btree index "cc_phist_index153" on "cc_phist" (
	"team_id",
"date_recorded")
commit work;
create btree index "cc_phist_index126" on "cc_phist" (
"date_recorded")
commit work;
create btree index "cc_phist_index068" on "cc_phist" (
	"docket_number",
	"team_id",
"date_recorded")
commit work;
create btree index "cc_phist_index069" on "cc_phist" (
	"docket_number",
	"clock_card_no",
"date_recorded")
commit work;
create unique hash index "cc_phist_index" on "cc_phist" ("uniquifier")
commit work;
create table "pi_dets" (
	"payment_indic"	char	(2)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "pi_dets_index" on "pi_dets" ("payment_indic")
commit work;
create table "scan_hrs" (
	"uniquifier"	numeric	(6)	not null primary key
	"clock_card_no"	char	(6),
	"date_recorded"	huge date
	"docket_number"	char	(6),
	"hours"	amount	(5)
	"time_factor"	amount	(4)
	"batch_number"	numeric	(6)
commit work;
create table "pj_stage" (
	"line_number"	numeric	(2)	not null primary key
	"descript"	char	(24),
	"fill_percentage"	char	(1));
commit work;
create unique hash index "pj_stage_index" on "pj_stage" ("line_number")
commit work;
create table "pl_dets" (
	"pl_name"	char	(10)	not null primary key,
	"pl_locn"	char	(30),
	"pl_plen"	numeric	(3)
commit work;
create btree index "pl_dets_index001" on "pl_dets" (
"pl_name")
commit work;
create unique hash index "pl_dets_index" on "pl_dets" ("pl_name")
commit work;
create table "pm_dets" (
	"pm_dets_job_id"	char	(6)	not null primary key,
	"detail_1"	char	(50),
	"detail_2"	char	(50),
	"detail_3"	char	(50),
	"detail_4"	char	(50),
	"detail_5"	char	(50),
	"detail_6"	char	(50),
	"detail_7"	char	(50));
commit work;
create unique btree index "pm_dets_index141" on "pm_dets" (
"pm_dets_job_id")
commit work;
create unique hash index "pm_dets_index" on "pm_dets" ("pm_dets_job_id")
commit work;
create table "sk_items" (
	"stock_code"	char	(10)	not null primary key,
	"stock_class"	char	(2),
	"abc_class"	char	(1),
	"descript_1"	char	(40),
	"descript_2"	char	(40),
	"stock_type"	char	(1),
	"ratio_code"	char	(3),
	"supplier_code_1"	char	(8),
	"supplier_ref_1"	char	(15),
	"supplier_code_2"	char	(8),
	"supplier_ref_2"	char	(15),
	"supplier_code_3"	char	(8),
	"supplier_ref_3"	char	(15),
	"consumable_flag"	char	(1),
	"altern_stk_code"	char	(10),
	"date_loaded"	huge date
	"end_date"	huge date
	"supp_1_preferred"	char	(1),
	"supp_2_preferred"	char	(1),
	"supp_3_preferred"	char	(1),
	"live_flag"	char	(1));
commit work;
create btree index "sk_items_index114" on "sk_items" (
	"stock_type",
	"stock_class",
"live_flag")
commit work;
create unique btree index "sk_items_index065" on "sk_items" (
"stock_code")
commit work;
create btree index "sk_items_index072" on "sk_items" (
"descript_1")
commit work;
create btree index "sk_items_index076" on "sk_items" (
"supplier_code_1")
commit work;
create btree index "sk_items_index113" on "sk_items" (
	"stock_type",
	"live_flag",
"supplier_code_1")
commit work;
create unique hash index "sk_items_index" on "sk_items" ("stock_code")
commit work;
create table "pm_spare" (
	primary key ("pm_job_id","stock_number"),
	"pm_job_id"	char	(6)	not null,
	"stock_number"	char	(10)	not null,
	"quantity"	numeric	(5)
	"cost"	amount	(9)
commit work;
create unique btree index "pm_spare_index147" on "pm_spare" (
	"pm_job_id",
"stock_number")
commit work;
create unique hash index "pm_spare_index" on "pm_spare" ("pm_job_id","stock_number")
commit work;
create table "pr_index" (
	"price_index_type"	char	(3)	not null primary key,
	"original_val_fld"	numeric	(3)
	"amended_val_fld"	numeric	(3)
	"date_last_update"	huge date
	"descript"	char	(24));
commit work;
create unique btree index "pr_index_index028" on "pr_index" (
"price_index_type")
commit work;
create unique hash index "pr_index_index" on "pr_index" ("price_index_type")
commit work;
create table "pr_type" (
	"priority_code"	char	(2)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "pr_type_index" on "pr_type" ("priority_code")
commit work;
create table "prj_det" (
	"project_code"	char	(6)	not null primary key,
	"descript_1"	char	(50),
	"descript_2"	char	(50),
	"descript_3"	char	(50),
	"descript_4"	char	(50),
	"descript_5"	char	(50),
	"descript_6"	char	(50),
	"descript_7"	char	(50));
commit work;
create unique btree index "prj_det_index011" on "prj_det" (
"project_code")
commit work;
create unique hash index "prj_det_index" on "prj_det" ("project_code")
commit work;
create table "re_type" (
	"reason_for_delay"	char	(1)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "re_type_index" on "re_type" ("reason_for_delay")
commit work;
create table "si_dets" (
	"site_code"	char	(3)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "si_dets_index" on "si_dets" ("site_code")
commit work;
create table "sic_dets" (
	"ratio_code"	char	(3)	not null primary key,
	"supply_uom"	char	(6),
	"issue_uom"	char	(6),
	"ratio_val_fld"	amount	(9)
commit work;
create unique hash index "sic_dets_index" on "sic_dets" ("ratio_code")
commit work;
create table "helpdesk" (
	"cw_job_id"	char	(6)	not null primary key,
	"work_done"	char	(40),
	"time_completed"	time
	"date_completed"	huge date
commit work;
create unique hash index "helpdesk_index" on "helpdesk" ("cw_job_id")
commit work;
create table "as_dets" (
	"asset_id"	char	(6)	not null primary key,
	"down_time"	amount	(8)
	"no_failures"	numeric	(5)
	"hours_run_per_wk"	numeric	(3)
	"repair_time"	amount	(8)
	"start_date"	huge date
	"bms_ref_fld"	char	(8),
	"rely_stats_req"	char	(1),
	"site_code"	char	(3),
	"building_code"	char	(3),
	"locat_code"	char	(6),
	"management_unit"	char	(4),
	"asset_no"	char	(6),
	"sub_asset_no"	char	(3),
	"asset_name"	char	(24),
	"asset_type"	char	(6),
	"statutory_item"	char	(1),
	"manufacturer"	char	(8),
	"supplier_code"	char	(8),
	"order_no"	numeric	(8)
	"acceptance_date"	huge date
	"warranty_expiry"	char	(7),
	"price"	numeric	(7)
	"serial_no"	char	(12),
	"model_no"	char	(20),
	"est_replace_year"	char	(4),
	"indexed_rep_cost"	numeric	(7)
	"locat_ref"	char	(13),
	"contract_pm_job"	char	(1),
	"price_index_type"	char	(3),
	"cost_centre"	char	(4),
	"workshop"	char	(3),
	"del_pm_job_flag"	char	(1),
	"charg_cost_cent"	char	(4),
	"account_code"	char	(15),
	"date_last_comp"	huge date
	"date_next_due"	huge date
	"labour_cost_pr"	amount	(9)
	"material_cost_pr"	amount	(9)
	"purchase_cost_pr"	amount	(9)
	"contract_cost_pr"	amount	(9)
	"site_code_bt"	numeric	(6)
	"labour_cost_yt"	amount	(9)
	"building_code_bt"	numeric	(6)
	"locat_bt1"	numeric	(6)
	"locat_bt2"	numeric	(6)
	"asset_no_bt1"	numeric	(6)
	"asset_no_bt2"	numeric	(6)
	"sub_asset_no_bt"	numeric	(6)
	"utilisation_cat"	char	(3),
	"material_cost_yt"	amount	(9)
	"purchase_cost_yt"	amount	(9)
	"contract_cost_yt"	amount	(9)
	"priority_code"	char	(2),
	"maintenance_plan"	char	(2),
	"resp_serv_level"	char	(2),
	"phoenix_code"	char	(6),
	"down_serv_level"	char	(2));
commit work;
create unique btree index "as_dets_index004" on "as_dets" (
	"site_code",
	"building_code",
	"locat_code",
	"asset_no",
	"sub_asset_no",
"del_pm_job_flag")
commit work;
create unique btree index "as_dets_index005" on "as_dets" (
	"site_code_bt",
	"building_code_bt",
	"locat_bt1",
	"locat_bt2",
	"asset_no_bt1",
	"asset_no_bt2",
"sub_asset_no_bt")
commit work;
create btree index "as_dets_index007" on "as_dets" (
"asset_type")
commit work;
create btree index "as_dets_index027" on "as_dets" (
"asset_name")
commit work;
create btree index "as_dets_index030" on "as_dets" (
"manufacturer")
commit work;
create unique btree index "as_dets_index105" on "as_dets" (
"asset_id")
commit work;
create unique btree index "as_dets_index120" on "as_dets" (
	"asset_id",
	"workshop",
	"site_code",
	"building_code",
	"locat_code",
	"asset_no",
	"sub_asset_no",
"management_unit")
commit work;
create btree index "as_dets_index121" on "as_dets" (
	"asset_no",
	"locat_code",
	"building_code",
"site_code")
commit work;
create btree index "as_dets_index122" on "as_dets" (
	"sub_asset_no",
	"asset_no",
	"locat_code",
	"building_code",
"site_code")
commit work;
create btree index "as_dets_index001" on "as_dets" (
"asset_id")
commit work;
create unique hash index "as_dets_index" on "as_dets" ("asset_id")
commit work;
create table "skc_dets" (
	"class_code"	char	(2)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "skc_dets_index" on "skc_dets" ("class_code")
commit work;
create table "sla_dets" (
	primary key ("resp_or_down","serv_lev_code"),
	"resp_or_down"	char	(1)	not null,
	"serv_lev_code"	char	(2)	not null,
	"descript"	char	(24),
	"time_in_hours"	amount	(5)
	"elapse_or_work"	char	(1),
	"hours_or_days"	char	(1));
commit work;
create unique hash index "sla_dets_index" on "sla_dets" ("resp_or_down","serv_lev_code")
commit work;
create table "sp_type" (
	"supplier_type"	char	(2)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "sp_type_index" on "sp_type" ("supplier_type")
commit work;
create table "spares" (
	primary key ("docket_number","stock_number","locat_code"),
	"docket_number"	char	(6)	not null,
	"stock_number"	char	(10)	not null,
	"locat_code"	numeric	(2)	not null
	"cost"	amount	(8)
	"quantity_used"	numeric	(5)
	"date_issued"	huge date
	"ident_yn"	char	(1));
commit work;
create btree index "spares_index026" on "spares" (
"docket_number")
commit work;
create unique btree index "spares_index117" on "spares" (
	"docket_number",
	"stock_number",
"locat_code")
commit work;
create unique hash index "spares_index" on "spares" ("docket_number","stock_number","locat_code")
commit work;
create table "ss_type" (
	"status_code"	char	(1)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "ss_type_index" on "ss_type" ("status_code")
commit work;
create table "ssu_dets" (
	primary key ("stock_code","supplier_code"),
	"stock_code"	char	(10)	not null,
	"supplier_code"	char	(8)	not null,
	"unit_of_supply"	char	(6),
	"last_inv_date"	huge date
	"u_price_last_inv"	amount	(9)
	"min_order_qty"	numeric	(5)
	"lead_time"	numeric	(3)
	"carr_del_charges"	char	(1),
	"text_line_1"	char	(40),
	"text_line_2"	char	(40),
	"text_line_3"	char	(40),
	"text_line_4"	char	(40),
	"text_line_5"	char	(40),
	"text_line_6"	char	(40),
	"text_line_7"	char	(40),
	"text_line_8"	char	(40),
	"text_line_9"	char	(40),
	"text_line_10"	char	(40),
	"payment_indic"	char	(2));
commit work;
create unique btree index "ssu_dets_index025" on "ssu_dets" (
	"stock_code",
"supplier_code")
commit work;
create unique hash index "ssu_dets_index" on "ssu_dets" ("stock_code","supplier_code")
commit work;
create table "stk_type" (
	"stock_type_code"	char	(1)	not null primary key,
	"pur_account_code"	char	(15),
	"descript"	char	(24));
commit work;
create unique hash index "stk_type_index" on "stk_type" ("stock_type_code")
commit work;
create table "sx_dets" (
	"transaction_no"	numeric	(8)	not null primary key
	"transaction_type"	char	(1),
	"trans_no_ref"	numeric	(8)
	"docket_number"	numeric	(6)
	"requisition_no"	char	(6),
	"job_number"	char	(6),
	"account_code"	char	(15),
	"cost_centre"	char	(4),
	"sx_date"	huge date
	"sx_time"	time
	"usr"	char	(8),
	"quantity"	numeric	(5)
	"ref_fld"	char	(12),
	"order_number"	numeric	(8)
	"order_line_no"	numeric	(3)
	"stock_code"	char	(10),
	"movement_date"	huge date
	"stock_loc_code"	numeric	(2)
	"financial_year"	char	(4),
	"trn_val_fld"	amount	(8)
	"financial_period"	numeric	(2)
commit work;
create unique btree index "sx_dets_index118" on "sx_dets" (
"transaction_no")
commit work;
create btree index "sx_dets_index069" on "sx_dets" (
	"stock_code",
"stock_loc_code")
commit work;
create btree index "sx_dets_index067" on "sx_dets" (
	"trans_no_ref",
"transaction_type")
commit work;
create btree index "sx_dets_index059" on "sx_dets" (
	"order_number",
"order_line_no")
commit work;
create btree index "sx_dets_index058" on "sx_dets" (
	"stock_code",
	"sx_date",
"docket_number")
commit work;
create unique hash index "sx_dets_index" on "sx_dets" ("transaction_no")
commit work;
create table "tec_det" (
	"asset_id"	char	(6)	not null primary key,
	"descript_1"	char	(50),
	"descript_2"	char	(50),
	"descript_3"	char	(50),
	"descript_4"	char	(50),
	"descript_5"	char	(50),
	"descript_6"	char	(50),
	"descript_7"	char	(50));
commit work;
create unique btree index "tec_det_index079" on "tec_det" (
"asset_id")
commit work;
create unique hash index "tec_det_index" on "tec_det" ("asset_id")
commit work;
create table "tn_dets" (
	"transaction_type"	char	(2)	not null primary key,
	"transaction_no"	numeric	(8)
commit work;
create unique hash index "tn_dets_index" on "tn_dets" ("transaction_type")
commit work;
create table "tr_type" (
	"trade_code"	char	(1)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "tr_type_index" on "tr_type" ("trade_code")
commit work;
create table "usr_acc" (
	primary key ("menu_name","form_nam","profile_code"),
	"menu_name"	char	(10)	not null,
	"form_nam"	char	(10)	not null,
	"profile_code"	char	(2)	not null,
	"allow_add"	char	(1),
	"allow_update"	char	(1),
	"allow_find"	char	(1),
	"allow_delete"	char	(1));
commit work;
create unique btree index "usr_acc_index029" on "usr_acc" (
	"profile_code",
	"menu_name",
"form_nam")
commit work;
create btree index "usr_acc_index001" on "usr_acc" (
	"menu_name",
	"profile_code",
"form_nam")
commit work;
create unique hash index "usr_acc_index" on "usr_acc" ("menu_name","form_nam","profile_code")
commit work;
create table "usr_pro" (
	"profile_code"	char	(2)	not null primary key,
	"descript"	char	(24));
commit work;
create btree index "usr_pro_index001" on "usr_pro" (
"profile_code")
commit work;
create unique hash index "usr_pro_index" on "usr_pro" ("profile_code")
commit work;
create table "wk_done" (
	"work_done_job_id"	char	(6)	not null primary key,
	"detail_1"	char	(50),
	"detail_2"	char	(50),
	"detail_3"	char	(50),
	"detail_4"	char	(50),
	"detail_5"	char	(50),
	"detail_6"	char	(50),
	"detail_7"	char	(50));
commit work;
create unique btree index "wk_done_index148" on "wk_done" (
"work_done_job_id")
commit work;
create unique hash index "wk_done_index" on "wk_done" ("work_done_job_id")
commit work;
create table "wk_nums" (
	primary key ("year","week_number"),
	"year"	char	(4)	not null,
	"week_number"	numeric	(2)	not null
	"week_start"	huge date
	"week_end"	huge date
commit work;
create unique btree index "wk_nums_index031" on "wk_nums" (
	"year",
"week_number")
commit work;
create unique btree index "wk_nums_index157" on "wk_nums" (
	"week_end",
"week_start")
commit work;
create unique hash index "wk_nums_index" on "wk_nums" ("year","week_number")
commit work;
create table "ws_type" (
	"workshop_code"	char	(3)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "ws_type_index" on "ws_type" ("workshop_code")
commit work;
create table "yr_nums" (
	"year"	char	(4)	not null primary key,
	"number_of_weeks"	numeric	(2)
commit work;
create unique hash index "yr_nums_index" on "yr_nums" ("year")
commit work;
create table "prin_func" (
	"principal_funct"	char	(5)	not null primary key,
	"descript"	char	(24));
commit work;
create btree index "prin_func_index001" on "prin_func" (
"principal_funct")
commit work;
create unique hash index "prin_func_index" on "prin_func" ("principal_funct")
commit work;
create table "alt_val" (
	"property_id"	numeric	(9)	not null primary key
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"asset_category"	char	(2),
	"basis_of_val"	char	(5),
	"method_of_val"	char	(3),
	"area_of_land"	float	(64)
	"total_value"	numeric	(9)
	"comments"	text
	"eff_val_date"	huge date
	"date_val_carr_out"	huge date
	"valuer_code"	char	(4));
commit work;
create btree index "alt_val_index001" on "alt_val" (
"property_id")
commit work;
create unique hash index "alt_val_index" on "alt_val" ("property_id")
commit work;
create table "districts" (
	"dist_code"	char	(8)	not null primary key,
	"dist_descript"	char	(40));
commit work;
create btree index "districts_index001" on "districts" (
"dist_code")
commit work;
create unique hash index "districts_index" on "districts" ("dist_code")
commit work;
create table "premises" (
	"loc_fin_sys_code"	char	(7)	not null primary key,
	"address_no"	char	(4),
	"alloc_bus_unit"	char	(4),
	"alloc_pur_concat"	char	(35),
	"alloc_depart"	char	(4),
	"alloc_div"	char	(4),
	"alloc_hold_com"	char	(4),
	"alloc_pur_code1"	char	(5),
	"alloc_pur_code2"	char	(5),
	"alloc_pur_code3"	char	(5),
	"alloc_pur_code4"	char	(5),
	"alloc_pur_code5"	char	(5),
	"alloc_serv_dept"	char	(5),
	"alt_premis_desc"	char	(40),
	"alt_premis_name"	char	(40),
	"alt_tel_no"	char	(20),
	"area"	float	(64)
	"cons_area"	char	(1),
	"county"	char	(20),
	"county_usr"	char	(8),
	"deployment_use"	char	(1),
	"dist_council_code"	char	(8),
	"elect_div"	char	(3),
	"gross_int_floor"	numeric	(6)
	"link_let_id"	char	(12),
	"link_let_interest"	char	(1),
	"link_let_seq_no"	numeric	(9)
	"listed_building"	char	(5),
	"live_flag"	char	(1),
	"live_flag_date"	huge date
	"locality"	char	(30),
	"log_acknowl_date"	huge date
	"log_issued_date"	huge date
	"max_hrs_use_pw"	amount	(6)
	"nat_grid_ref"	char	(12),
	"oth_agree_cap_cl"	huge amount
	"oth_agree_cap_stf"	huge amount
	"oth_cur_ft_equiv"	huge amount
	"oth_cur_ft_staff"	huge amount
	"oth_cur_ft_clien"	huge amount
	"oth_cur_pt_clien"	huge amount
	"oth_cur_pt_staff"	huge amount
	"oth_des_cap_cl"	huge amount
	"oth_des_cap_stf"	huge amount
	"other_cap"	huge amount
	"post_code"	char	(8),
	"premises_notes"	text
	"premis_name"	char	(40),
	"road"	char	(30),
	"s_serv_team_bound1"	char	(1),
	"s_serv_team_bound2"	char	(2),
	"s_serv_team_bound3"	char	(1),
	"occ_start_date"	huge date
	"tel_no"	char	(20),
	"third_pty_occup"	char	(8),
	"town"	char	(25),
	"usage_depart"	char	(4),
	"usage_bus_unit"	char	(4),
	"usage_code1"	char	(5),
	"usage_code2"	char	(5),
	"usage_code3"	char	(5),
	"usage_code4"	char	(5),
	"usage_code5"	char	(5),
	"usage_concat"	char	(35),
	"usage_division"	char	(4),
	"usage_manag_com"	char	(4),
	"usage_serv_dept"	char	(5),
	"ward"	char	(4));
commit work;
create btree index "premises_index001" on "premises" (
	"live_flag",
"live_flag_date")
commit work;
create btree index "premises_index002" on "premises" (
"loc_fin_sys_code")
commit work;
create unique hash index "premises_index" on "premises" ("loc_fin_sys_code")
commit work;
create table "bc_dets" (
	"cost_centre_code"	char	(4)	not null primary key,
	"descript"	char	(24),
	"management_unit"	char	(4),
	"committee_or_division"	char	(4));
commit work;
create unique btree index "bc_dets_index013" on "bc_dets" (
	"committee_or_division",
	"cost_centre_code",
"management_unit")
commit work;
create btree index "bc_dets_index001" on "bc_dets" (
"cost_centre_code")
commit work;
create btree index "bc_dets_index002" on "bc_dets" (
	"cost_centre_code",
	"management_unit",
"committee_or_division")
commit work;
create unique hash index "bc_dets_index" on "bc_dets" ("cost_centre_code")
commit work;
create table "div_dets" (
	"committee_or_division"	char	(4)	not null primary key,
	"descript"	char	(24));
commit work;
create unique btree index "div_dets_index013" on "div_dets" (
"committee_or_division")
commit work;
create btree index "div_dets_index001" on "div_dets" (
"committee_or_division")
commit work;
create unique hash index "div_dets_index" on "div_dets" ("committee_or_division")
commit work;
create table "sord_dets" (
	"standard_code"	char	(12)	not null primary key,
	"descript_1"	char	(40),
	"descript_2"	char	(40),
	"descript_3"	char	(40),
	"descript_4"	char	(40),
	"descript_5"	char	(40),
	"descript_6"	char	(40),
	"descript_7"	char	(40),
	"descript_8"	char	(40),
	"descript_9"	char	(40),
	"descript_10"	char	(40));
commit work;
create unique hash index "sord_dets_index" on "sord_dets" ("standard_code")
commit work;
create table "dec_l_let" (
	primary key ("property_id","deed_packet_ref","seq_no_let","seq_no_this","lfs_code"),
	"property_id"	numeric	(9)	not null
	"deed_packet_ref"	char	(12)	not null,
	"seq_no_let"	numeric	(2)	not null
	"seq_no_this"	numeric	(2)	not null
	"lfs_code"	char	(7)	not null,
	"interest"	char	(1),
	"live_flag"	char	(1),
	"live_flag_date"	huge date
	"l_lord_ext_yr"	char	(4),
	"l_lord_int_yr"	char	(4),
	"tenant_ext_yr"	char	(4),
	"tenant_int_yr"	char	(4));
commit work;
create btree index "dec_l_let_index003" on "dec_l_let" (
	"seq_no_let",
"seq_no_this")
commit work;
create btree index "dec_l_let_index002" on "dec_l_let" (
	"property_id",
	"lfs_code",
"deed_packet_ref")
commit work;
create btree index "dec_l_let_index001" on "dec_l_let" (
	"property_id",
	"deed_packet_ref",
"seq_no_let")
commit work;
create unique hash index "dec_l_let_index" on "dec_l_let" ("property_id","deed_packet_ref","seq_no_let","seq_no_this","lfs_code")
commit work;
create table "dec_l_own" (
	primary key ("property_id","deed_packet_ref","sequence_no"),
	"property_id"	numeric	(9)	not null
	"deed_packet_ref"	char	(12)	not null,
	"sequence_no"	numeric	(2)	not null
	"interest"	char	(1),
	"live_flag"	char	(1),
	"live_flag_date"	huge date
	"l_lord_ext_yr"	char	(4),
	"l_lord_int_yr"	char	(4),
	"tenant_ext_yr"	char	(4),
	"tenant_int_yr"	char	(4));
commit work;
create btree index "dec_l_own_index003" on "dec_l_own" (
"sequence_no")
commit work;
create btree index "dec_l_own_index002" on "dec_l_own" (
	"property_id",
	"deed_packet_ref",
"sequence_no")
commit work;
create btree index "dec_l_own_index001" on "dec_l_own" (
	"live_flag",
"live_flag_date")
commit work;
create unique hash index "dec_l_own_index" on "dec_l_own" ("property_id","deed_packet_ref","sequence_no")
commit work;
create table "art_works" (
	primary key ("property_id","l_f_s_code","sequence_no"),
	"property_id"	numeric	(9)	not null
	"l_f_s_code"	char	(7)	not null,
	"sequence_no"	numeric	(4)	not null
	"art_category"	char	(1),
	"artist_name"	char	(30),
	"condition_code"	char	(4),
	"condition_desc"	text
	"date_created"	huge date
	"date_visited"	huge date
	"descript"	text
	"dimensions"	char	(30),
	"grid_ref"	char	(12),
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"live_flag"	char	(1),
	"live_flag_date"	huge date
	"locat_block"	char	(1),
	"locat_desc"	text
	"obvious_damage"	text
	"provenance"	text
	"visitor"	char	(20),
	"work_name"	text
commit work;
create btree index "art_works_index001" on "art_works" (
	"live_flag",
"live_flag_date")
commit work;
create btree index "art_works_index002" on "art_works" (
	"property_id",
	"l_f_s_code",
"sequence_no")
commit work;
create btree index "art_works_index003" on "art_works" (
	"property_id",
	"sequence_no",
"l_f_s_code")
commit work;
create unique hash index "art_works_index" on "art_works" ("property_id","l_f_s_code","sequence_no")
commit work;
create table "valuers" (
	"valuer_code"	char	(4)	not null primary key,
	"valuer_desc"	char	(50));
commit work;
create btree index "valuers_index001" on "valuers" (
"valuer_code")
commit work;
create unique hash index "valuers_index" on "valuers" ("valuer_code")
commit work;
create table "asset_pro" (
	"property_id"	numeric	(9)	not null primary key
	"adverse_use_det"	text
	"adverse_use_oth"	char	(1),
	"boundary_issue"	char	(1),
	"conclusion"	char	(1),
	"date_commenced"	huge date
	"date_inspected"	huge date
	"date_resolved"	huge date
	"encroachment"	char	(1),
	"hcc_land_misuse"	char	(1),
	"hcc_plan_misuse"	char	(1),
	"how_resolved"	text
	"illegal_dumping"	text
	"inspected_by"	char	(30),
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"overhead_cables"	char	(1),
	"right_of_way"	char	(1),
	"rights_of_light"	char	(1),
	"r_of_way_obstr"	char	(1));
commit work;
create btree index "asset_pro_index001" on "asset_pro" (
"property_id")
commit work;
create unique hash index "asset_pro_index" on "asset_pro" ("property_id")
commit work;
create table "bcis_dets" (
	"bcis_code"	char	(5)	not null primary key,
	"bcis_descript"	char	(40),
	"cap_acctg_cost"	amount	(9)
	"demolition_perc"	amount	(7)
	"ext_works_perc"	amount	(7)
	"fees_perc"	amount	(7)
	"insurance_cost"	amount	(9)
commit work;
create btree index "bcis_dets_index001" on "bcis_dets" (
"bcis_code")
commit work;
create unique hash index "bcis_dets_index" on "bcis_dets" ("bcis_code")
commit work;
create table "bcis_dets2" (
	"sub_value"	numeric	(9)	not null primary key
	"rebuild_period"	numeric	(2)
	"inflation"	amount	(5)
commit work;
create btree index "bcis_dets2_index001" on "bcis_dets2" (
"inflation")
commit work;
create btree index "bcis_dets2_index002" on "bcis_dets2" (
"sub_value")
commit work;
create unique hash index "bcis_dets2_index" on "bcis_dets2" ("sub_value")
commit work;
create table "b_val_dets" (
	"property_id"	numeric	(9)	not null primary key
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"asset_category"	char	(2),
	"basis_of_val"	char	(5),
	"method_of_val"	char	(3),
	"comments"	text
	"block_value"	numeric	(9)
	"eff_val_date"	huge date
	"date_val_carr_out"	huge date
	"valuer_code"	char	(4));
commit work;
create btree index "b_val_dets_index001" on "b_val_dets" (
"property_id")
commit work;
create unique hash index "b_val_dets_index" on "b_val_dets" ("property_id")
commit work;
create table "ccouncils" (
	"ccoun_code"	char	(8)	not null primary key,
	"ccoun_descript"	char	(40));
commit work;
create btree index "ccouncils_index001" on "ccouncils" (
"ccoun_code")
commit work;
create unique hash index "ccouncils_index" on "ccouncils" ("ccoun_code")
commit work;
create table "condition" (
	"condition"	char	(4)	not null primary key,
	"descript"	char	(24));
commit work;
create btree index "condition_index001" on "condition" (
"condition")
commit work;
create unique hash index "condition_index" on "condition" ("condition")
commit work;
create table "constit" (
	"constit_code"	char	(6)	not null primary key,
	"constit_descript"	char	(40));
commit work;
create btree index "constit_index001" on "constit" (
"constit_code")
commit work;
create unique hash index "constit_index" on "constit" ("constit_code")
commit work;
create table "construct" (
	"construct"	char	(4)	not null primary key,
	"descript"	char	(24));
commit work;
create btree index "construct_index001" on "construct" (
"construct")
commit work;
create unique hash index "construct_index" on "construct" ("construct")
commit work;
create table "disabl" (
	"property_id"	numeric	(9)	not null primary key
	"alarms_flashing"	char	(1),
	"danger_signed"	char	(1),
	"disabled_entry"	char	(1),
	"disabled_hlp"	char	(1),
	"disabled_toilet"	char	(1),
	"doors_open_i_o"	char	(1),
	"doors_obstructed"	char	(1),
	"door_width"	numeric	(8)
	"entry_distance"	numeric	(9)
	"frame_openable"	char	(1),
	"ind_meet_rooms"	char	(1),
	"int_chg_floors"	char	(1),
	"int_floor_ramps"	char	(1),
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"lift_1_5_area"	char	(1),
	"lift_present"	char	(1),
	"light_n_handles"	char	(1),
	"l_ctrls_braille"	char	(1),
	"l_ctrls_w_chair"	char	(1),
	"l_tap_cloak_rms"	char	(1),
	"l_tap_dble_rms"	char	(1),
	"map_braille"	char	(1),
	"no_car_spaces"	numeric	(4)
	"no_dble_entrys"	numeric	(3)
	"no_disabled_wc"	numeric	(3)
	"ramps_h_rail"	char	(1),
	"routes_coloured"	char	(1),
	"stair_h_rail"	char	(1),
	"steps_h_rail"	char	(1),
	"signs_braille"	char	(1),
	"signs_visible"	char	(1),
	"solid_bay_entry"	char	(1),
	"survey_date"	huge date
	"voice_message"	char	(1),
	"wc_alarm"	char	(1),
	"w_chair_basin"	char	(1),
	"w_chair_drier"	char	(1),
	"w_chair_entry"	char	(1),
	"w_chair_flush"	char	(1),
	"w_chair_openable"	char	(1),
	"w_chair_wc"	char	(1));
commit work;
create btree index "disabl_index001" on "disabl" (
"property_id")
commit work;
create unique hash index "disabl_index" on "disabl" ("property_id")
commit work;
create table "deeds" (
	primary key ("property_id","deed_packet_ref","interest"),
	"property_id"	numeric	(9)	not null
	"deed_packet_ref"	char	(12)	not null,
	"interest"	char	(1)	not null,
	"comments"	text
	"enc_ben"	char	(1),
	"hold_committee1"	char	(4),
	"hold_committee2"	char	(4),
	"hold_committee3"	char	(4),
	"hold_committee4"	char	(4),
	"hold_committee5"	char	(4),
	"interest_p_a"	char	(1),
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"lfs_code"	char	(7),
	"no_deeds_in_pack"	numeric	(5)
	"owner_quality"	char	(10));
commit work;
create btree index "deeds_index001" on "deeds" (
	"property_id",
"deed_packet_ref")
commit work;
create unique hash index "deeds_index" on "deeds" ("property_id","deed_packet_ref","interest")
commit work;
create table "schl_dets" (
	"lfs_code"	char	(7)	not null primary key,
	"alt_tel_no"	char	(20),
	"cur_ft_pupils"	numeric	(4)
	"cur_pt_pupils"	numeric	(3)
	"current_ft_staff"	numeric	(6)
	"current_pt_staff"	amount	(5)
	"des_ref_no"	char	(5),
	"hard_play_area"	float	(64)
	"h_teacher_name"	char	(25),
	"hvy_prac_spce_sqm"	numeric	(5)
	"lgt_prac_spce_sqm"	numeric	(5)
	"live_flag"	char	(1),
	"live_flag_date"	huge date
	"gen_tch_spce_sqm"	numeric	(6)
	"perm_acc_act_cap"	amount	(7)
	"perm_acc_class_no"	numeric	(3)
	"perm_acc_tch_area"	numeric	(5)
	"perm_acc_tot_area"	amount	(6)
	"play_field_hect"	float	(64)
	"rec_area_hect"	float	(64)
	"schl_actual_cap"	amount	(4)
	"schl_potent_cap"	amount	(4)
	"schl_std_add_lim"	numeric	(3)
	"school_category"	char	(1),
	"school_phone_no"	char	(20),
	"school_ref_no"	char	(4),
	"school_type"	char	(3),
	"sprt_pe_spce_sqm"	numeric	(5)
	"temp_acc_no_rooms"	numeric	(2)
	"temp_acc_tot_area"	amount	(6)
	"temp_act_tch_area"	amount	(6)
	"tot_eq_ft_pupils"	amount	(7)
	"tot_ft_eq_staff"	amount	(6)
commit work;
create btree index "schl_dets_index001" on "schl_dets" (
"lfs_code")
commit work;
create btree index "schl_dets_index002" on "schl_dets" (
"school_ref_no")
commit work;
create unique hash index "schl_dets_index" on "schl_dets" ("lfs_code")
commit work;
create table "elect_divs" (
	"elect_code"	char	(3)	not null primary key,
	"elect_descript"	char	(40));
commit work;
create btree index "elect_divs_index001" on "elect_divs" (
"elect_code")
commit work;
create unique hash index "elect_divs_index" on "elect_divs" ("elect_code")
commit work;
create table "enc_ben" (
	primary key ("enc_or_ben","enc_ben_code"),
	"enc_or_ben"	char	(1)	not null,
	"enc_ben_code"	char	(2)	not null,
	"enc_ben_descript"	char	(30));
commit work;
create btree index "enc_ben_index001" on "enc_ben" (
	"enc_or_ben",
"enc_ben_code")
commit work;
create unique hash index "enc_ben_index" on "enc_ben" ("enc_or_ben","enc_ben_code")
commit work;
create table "fyi_lines" (
	primary key ("frm_name","fyi_identifier"),
	"frm_name"	char	(10)	not null,
	"fyi_identifier"	char	(28)	not null,
	"fyi_line"	char	(77));
commit work;
create btree index "fyi_lines_index001" on "fyi_lines" (
	"frm_name",
"fyi_identifier")
commit work;
create unique hash index "fyi_lines_index" on "fyi_lines" ("frm_name","fyi_identifier")
commit work;
create table "rev_lsoth" (
	primary key ("property_id","deed_packet_ref","seq_no_this"),
	"property_id"	numeric	(9)	not null
	"deed_packet_ref"	char	(12)	not null,
	"seq_no_this"	numeric	(2)	not null
	"agreed_rental"	numeric	(8)
	"live_flag"	char	(1),
	"live_flag_date"	huge date
	"notice_due_date"	huge date
	"notice_quit_date"	huge date
	"rev_term_date"	huge date
	"review_date"	huge date
	"review_terminate"	char	(1),
	"record_type"	char	(1));
commit work;
create btree index "rev_lsoth_index003" on "rev_lsoth" (
"seq_no_this")
commit work;
create btree index "rev_lsoth_index001" on "rev_lsoth" (
	"live_flag",
"live_flag_date")
commit work;
create unique hash index "rev_lsoth_index" on "rev_lsoth" ("property_id","deed_packet_ref","seq_no_this")
commit work;
create table "ol_dets" (
	primary key ("purchase_req_no","order_line_no"),
	"purchase_req_no"	numeric	(8)	not null
	"order_line_no"	numeric	(3)	not null
	"unit_of_supply"	char	(6),
	"job_id"	char	(6),
	"job_type"	char	(1),
	"order_number"	numeric	(8)
	"originator_ref"	char	(8),
	"total_est_cost"	amount	(8)
	"rem_commitment"	amount	(8)
	"expenditure"	amount	(8)
	"contrt_quote_ref"	char	(6),
	"date_originated"	huge date
	"validated_ref"	char	(8),
	"date_validated"	huge date
	"financial_year"	char	(4),
	"account_code"	char	(15),
	"cost_centre"	char	(4),
	"requisition_no"	char	(6),
	"exp_delivery"	huge date
	"line_status"	char	(1),
	"exception_status"	char	(2),
	"part_number"	char	(10),
	"part_price"	amount	(8)
	"qty_ordered"	numeric	(5)
	"qty_rec_to_date"	numeric	(5)
	"qty_invoiced"	numeric	(5)
	"percent_complete"	numeric	(3)
	"percent_invoiced"	numeric	(3)
	"desc_line_1"	char	(40),
	"desc_line_2"	char	(40),
	"desc_line_3"	char	(40),
	"desc_line_4"	char	(40),
	"desc_line_5"	char	(40),
	"desc_line_6"	char	(40),
	"desc_line_7"	char	(40),
	"desc_line_8"	char	(40),
	"desc_line_9"	char	(40),
	"desc_line_10"	char	(40),
	"supplier_ref"	char	(15),
	"management_unit"	char	(4),
	"financial_period"	numeric	(2)
	"val_fld_received"	amount	(8)
	"asset_id"	char	(6),
	"project_code"	char	(6),
	"consumable"	char	(1),
	"contract_type"	char	(3),
	"prev_years_exp"	amount	(8)
commit work;
create btree index "ol_dets_index111" on "ol_dets" (
	"cost_centre",
"account_code")
commit work;
create btree index "ol_dets_index110" on "ol_dets" (
"line_status")
commit work;
create btree index "ol_dets_index109" on "ol_dets" (
"job_id")
commit work;
create btree index "ol_dets_index037" on "ol_dets" (
	"project_code",
"line_status")
commit work;
create unique btree index "ol_dets_index003" on "ol_dets" (
	"purchase_req_no",
"order_line_no")
commit work;
create btree index "ol_dets_index035" on "ol_dets" (
"order_line_no")
commit work;
create btree index "ol_dets_index036" on "ol_dets" (
	"order_number",
"order_line_no")
commit work;
create unique btree index "ol_dets_index053" on "ol_dets" (
	"part_number",
	"line_status",
	"purchase_req_no",
"order_line_no")
commit work;
create btree index "ol_dets_index108" on "ol_dets" (
	"asset_id",
"line_status")
commit work;
create unique hash index "ol_dets_index" on "ol_dets" ("purchase_req_no","order_line_no")
commit work;
create table "plan_stat" (
	primary key ("property_id","sequence_no","pl_stat","usage_type"),
	"property_id"	numeric	(9)	not null
	"sequence_no"	numeric	(9)	not null
	"pl_stat"	char	(1)	not null,
	"usage_type"	char	(1)	not null,
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"usage_code"	char	(5));
commit work;
create btree index "plan_stat_index001" on "plan_stat" (
"pl_stat")
commit work;
create btree index "plan_stat_index002" on "plan_stat" (
"property_id")
commit work;
create unique hash index "plan_stat_index" on "plan_stat" ("property_id","sequence_no","pl_stat","usage_type")
commit work;
create table "pcouncils" (
	"pcoun_code"	char	(8)	not null primary key,
	"pcoun_descript"	char	(40));
commit work;
create btree index "pcouncils_index001" on "pcouncils" (
"pcoun_code")
commit work;
create unique hash index "pcouncils_index" on "pcouncils" ("pcoun_code")
commit work;
create table "deed_dets" (
	primary key ("property_id","deed_packet_ref","interest"),
	"property_id"	numeric	(9)	not null
	"deed_packet_ref"	char	(12)	not null,
	"interest"	char	(1)	not null,
	"addr_no_prop"	char	(4),
	"addr_own_no"	char	(4),
	"agreement_type"	char	(1),
	"agree_s_date"	huge date
	"agree_ter_days"	numeric	(3)
	"agree_ter_mnths"	numeric	(3)
	"agree_ter_yrs"	numeric	(3)
	"alien_clse_type"	char	(1),
	"alien_clse_w_p"	char	(1),
	"break_clause"	char	(4),
	"clause_descript"	text
	"county_own"	char	(20),
	"county_prop"	char	(20),
	"current_rent"	amount	(8)
	"exten_opt_days"	numeric	(3)
	"exten_opt_mnths"	numeric	(3)
	"exten_opt_yrs"	numeric	(3)
	"inc_exc"	char	(1),
	"landlord_repair"	text
	"late_pay_int"	char	(1),
	"l_lord_tenant_ex"	char	(1),
	"locality_own"	char	(30),
	"locality_prop"	char	(30),
	"name_of_prop"	char	(40),
	"ownr_organ_add"	char	(40),
	"pay_period"	char	(10),
	"post_code_prop"	char	(8),
	"post_code_own"	char	(8),
	"rent_rev_basis"	char	(1),
	"rent_rev_desc"	text
	"review_per_mth"	numeric	(9)
	"review_per_yr"	numeric	(9)
	"road_own"	char	(30),
	"road_prop"	char	(30),
	"tenant_repair"	text
	"time_critical"	char	(1),
	"title_nat_desc"	text
	"town_own"	char	(25),
	"town_prop"	char	(25),
	"usr_clause"	char	(1),
	"usr_clause_desc"	text
	"tenancy_doc_cde"	char	(4),
	"active_service"	char	(1),
	"purpose_held"	char	(1),
	"land_use_code"	char	(5),
	"rent_renew_date_1"	huge date
	"rent_renew_date_2"	huge date
	"rent_renew_date_3"	huge date
	"rent_renew_date_4"	huge date
	"rent_renew_date_5"	huge date
	"rent_renew_date_6"	huge date
	"rent_renew_date_7"	huge date
	"rent_renew_date_8"	huge date
	"rent_renew_date_9"	huge date
	"renew_date_all"	char	(117),
	"department"	char	(4),
	"cost_centre"	char	(4),
	"management_unit"	char	(4),
	"hold_committee"	char	(4),
	"man_committee"	char	(4),
	"rent_abate"	huge amount
	"service_chg"	huge amount
	"est_income"	numeric	(9)
	"est_expend"	numeric	(9)
	"sub_let_to"	char	(40),
	"sub_let_desc"	text
commit work;
create btree index "deed_dets_index001" on "deed_dets" (
	"property_id",
	"deed_packet_ref",
"interest")
commit work;
create unique hash index "deed_dets_index" on "deed_dets" ("property_id","deed_packet_ref","interest")
commit work;
create table "phys_land" (
	"phland_code"	char	(1)	not null primary key,
	"phland_descript"	char	(30));
commit work;
create btree index "phys_land_index001" on "phys_land" (
"phland_code")
commit work;
create unique hash index "phys_land_index" on "phys_land" ("phland_code")
commit work;
create table "rev_frlse" (
	primary key ("property_id","deed_packet_ref","seq_no_this","seq_no_let"),
	"property_id"	numeric	(9)	not null
	"deed_packet_ref"	char	(12)	not null,
	"seq_no_this"	numeric	(2)	not null
	"seq_no_let"	numeric	(2)	not null
	"agreed_rental"	numeric	(8)
	"interest"	char	(1),
	"live_flag"	char	(1),
	"live_flag_date"	huge date
	"notice_due_date"	huge date
	"notice_quit_date"	huge date
	"review_date"	huge date
	"rev_term_date"	huge date
	"review_terminate"	char	(1));
commit work;
create btree index "rev_frlse_index003" on "rev_frlse" (
"seq_no_let")
commit work;
create btree index "rev_frlse_index002" on "rev_frlse" (
	"property_id",
	"deed_packet_ref",
"seq_no_this")
commit work;
create btree index "rev_frlse_index001" on "rev_frlse" (
	"live_flag",
"live_flag_date")
commit work;
create unique hash index "rev_frlse_index" on "rev_frlse" ("property_id","deed_packet_ref","seq_no_this","seq_no_let")
commit work;
create table "pro_unit" (
	"property_id"	numeric	(9)	not null primary key
	"address_code"	char	(8),
	"alternative_ref"	char	(15),
	"asset_id"	char	(6),
	"capital_asset_code"	char	(21),
	"capital_sub_asset_no"	numeric	(4)
	"committee_div"	char	(6),
	"cost_centre"	char	(4),
	"hist_code_ref"	char	(15),
	"land_reg_till_no"	char	(15),
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"management_unit"	char	(4),
	"principal_funct"	char	(24),
	"pro_unit_desc"	char	(75),
	"pro_unit_alt_desc"	char	(75),
	"uniq_prop_ref_no"	char	(15));
commit work;
create btree index "pro_unit_index015" on "pro_unit" (
"property_id")
commit work;
create btree index "pro_unit_index014" on "pro_unit" (
	"level_number",
"property_id")
commit work;
create btree index "pro_unit_index013" on "pro_unit" (
	"level_number",
"level_6_code")
commit work;
create btree index "pro_unit_index012" on "pro_unit" (
	"level_number",
"level_5_code")
commit work;
create btree index "pro_unit_index011" on "pro_unit" (
	"level_number",
"level_4_code")
commit work;
create btree index "pro_unit_index010" on "pro_unit" (
	"level_number",
"level_3_code")
commit work;
create btree index "pro_unit_index009" on "pro_unit" (
	"level_number",
"level_2_code")
commit work;
create btree index "pro_unit_index008" on "pro_unit" (
	"level_number",
	"level_1_code",
	"level_2_code",
	"level_3_code",
	"level_4_code",
	"level_5_code",
	"level_6_code",
"level_7_code")
commit work;
create btree index "pro_unit_index007" on "pro_unit" (
	"level_1_code",
	"level_2_code",
	"level_3_code",
	"level_4_code",
	"level_5_code",
	"level_6_code",
"level_7_code")
commit work;
create btree index "pro_unit_index006" on "pro_unit" (
	"level_1_code",
	"level_2_code",
	"level_3_code",
	"level_4_code",
	"level_5_code",
"level_6_code")
commit work;
create btree index "pro_unit_index005" on "pro_unit" (
	"level_1_code",
	"level_2_code",
	"level_3_code",
	"level_4_code",
"level_5_code")
commit work;
create btree index "pro_unit_index004" on "pro_unit" (
	"level_1_code",
	"level_2_code",
	"level_3_code",
"level_4_code")
commit work;
create btree index "pro_unit_index003" on "pro_unit" (
	"level_1_code",
	"level_2_code",
"level_3_code")
commit work;
create btree index "pro_unit_index002" on "pro_unit" (
	"level_1_code",
"level_2_code")
commit work;
create btree index "pro_unit_index001" on "pro_unit" (
"level_1_code")
commit work;
create unique hash index "pro_unit_index" on "pro_unit" ("property_id")
commit work;
create table "aud_trans" (
	"aud_trans_key"	numeric	(9)	not null primary key
	"action_type"	char	(1),
	"aud_date"	huge date
	"aud_reason"	text
	"aud_time"	time
	"author"	char	(10),
	"fld_name"	char	(30),
	"fld_trim"	char	(78),
	"from_val"	char	(50),
	"rec_key"	char	(78),
	"tab_name"	char	(10),
	"to_val"	char	(50));
commit work;
create btree index "aud_trans_index001" on "aud_trans" (
	"aud_date",
"aud_time")
commit work;
create unique hash index "aud_trans_index" on "aud_trans" ("aud_trans_key")
commit work;
create table "ramp" (
	primary key ("property_id","occurrence"),
	"property_id"	numeric	(9)	not null
	"occurrence"	numeric	(2)	not null
	"ramp_1_A"	numeric	(3)
	"ramp_1_B"	numeric	(3)
	"ramp_1_C"	numeric	(3)
	"ramp_1_h_rail"	char	(1));
commit work;
create btree index "ramp_index001" on "ramp" (
	"property_id",
"occurrence")
commit work;
create unique hash index "ramp_index" on "ramp" ("property_id","occurrence")
commit work;
create table "priority" (
	"priority"	char	(1)	not null primary key,
	"descript"	char	(24));
commit work;
create btree index "priority_index001" on "priority" (
"priority")
commit work;
create unique hash index "priority_index" on "priority" ("priority")
commit work;
create table "pro_levs" (
	"level_number"	numeric	(1)	not null primary key
	"level_name"	char	(24),
	"level_code_length"	numeric	(2)
commit work;
create btree index "pro_levs_index001" on "pro_levs" (
"level_number")
commit work;
create unique hash index "pro_levs_index" on "pro_levs" ("level_number")
commit work;
create table "prop_type" (
	"property_type"	char	(3)	not null primary key,
	"descript"	char	(24));
commit work;
create btree index "prop_type_index001" on "prop_type" (
"property_type")
commit work;
create unique hash index "prop_type_index" on "prop_type" ("property_type")
commit work;
create table "purpose" (
	"purp_code"	char	(1)	not null primary key,
	"purp_descript"	char	(30));
commit work;
create btree index "purpose_index001" on "purpose" (
"purp_code")
commit work;
create unique hash index "purpose_index" on "purpose" ("purp_code")
commit work;
create table "as_type" (
	"asset_type_code"	char	(6)	not null primary key,
	"descript"	char	(24));
commit work;
create unique btree index "as_type_index001" on "as_type" (
"asset_type_code")
commit work;
create unique hash index "as_type_index" on "as_type" ("asset_type_code")
commit work;
create table "as_dels" (
	"asset_id"	char	(6)	not null primary key,
	"acceptance_date"	huge date
	"building_code"	char	(3),
	"bms_ref_fld"	char	(8),
	"contract_cost_pr"	amount	(9)
	"contract_cost_yt"	amount	(9)
	"contract_pm_job"	char	(1),
	"cost_centre"	char	(4),
	"date_last_comp"	huge date
	"date_next_due"	huge date
	"down_time"	amount	(8)
	"est_replace_year"	char	(4),
	"warranty_expiry"	char	(7),
	"no_failures"	numeric	(5)
	"hours_run_per_wk"	numeric	(3)
	"indexed_rep_cost"	numeric	(7)
	"labour_cost_pr"	amount	(9)
	"labour_cost_yt"	amount	(9)
	"locat_code"	char	(6),
	"locat_ref"	char	(13),
	"site_code_bt"	numeric	(6)
	"manufacturer"	char	(8),
	"material_cost_pr"	amount	(9)
	"material_cost_yt"	amount	(9)
	"model_no"	char	(20),
	"management_unit"	char	(4),
	"asset_name"	char	(24),
	"asset_no"	char	(6),
	"order_no"	numeric	(8)
	"purchase_cost_pr"	amount	(9)
	"purchase_cost_yt"	amount	(9)
	"price_index_type"	char	(3),
	"charg_cost_cent"	char	(4),
	"account_code"	char	(15),
	"del_pm_job_flag"	char	(1),
	"price"	numeric	(7)
	"rely_stats_req"	char	(1),
	"repair_time"	amount	(8)
	"serial_no"	char	(12),
	"site_code"	char	(3),
	"building_code_bt"	numeric	(6)
	"statutory_item"	char	(1),
	"start_date"	huge date
	"supplier_code"	char	(8),
	"sub_asset_no"	char	(3),
	"locat_bt1"	numeric	(6)
	"asset_type"	char	(6),
	"utilisation_cat"	char	(3),
	"workshop"	char	(3),
	"locat_bt2"	numeric	(6)
	"asset_no_bt1"	numeric	(6)
	"asset_no_bt2"	numeric	(6)
	"sub_asset_no_bt"	numeric	(6)
	"priority_code"	char	(2),
	"maintenance_plan"	char	(2),
	"resp_serv_level"	char	(2),
	"down_serv_level"	char	(2));
commit work;
create unique hash index "as_dels_index" on "as_dels" ("asset_id")
commit work;
create table "fx_dets" (
	"transaction_no"	numeric	(8)	not null primary key
	"stock_loc_code"	numeric	(2)
	"stock_code"	char	(10),
	"order_number"	numeric	(8)
	"order_line_no"	numeric	(3)
	"invoice_number"	char	(12),
	"asset_job_no"	char	(8),
	"financial_year"	char	(4),
	"fx_date"	huge date
	"fx_time"	time
	"usr"	char	(8),
	"ref_fld_number"	char	(12),
	"account_code"	char	(15),
	"cost_centre"	char	(4),
	"cost"	amount	(8)
	"quantity"	numeric	(5)
	"hours_completed"	numeric	(5)
	"percent_complete"	numeric	(3)
	"transaction_type"	char	(1),
	"comm_or_expend"	char	(1),
	"management_unit"	char	(4),
	"financial_period"	numeric	(2)
commit work;
create btree index "fx_dets_index073" on "fx_dets" (
	"transaction_no",
"transaction_type")
commit work;
create btree index "fx_dets_index072" on "fx_dets" (
	"cost_centre",
	"account_code",
	"comm_or_expend",
"transaction_type")
commit work;
create btree index "fx_dets_index054" on "fx_dets" (
	"account_code",
"fx_date")
commit work;
create btree index "fx_dets_index056" on "fx_dets" (
	"order_number",
	"order_line_no",
	"cost_centre",
	"account_code",
"transaction_type")
commit work;
create btree index "fx_dets_index071" on "fx_dets" (
	"management_unit",
	"cost_centre",
"account_code")
commit work;
create unique hash index "fx_dets_index" on "fx_dets" ("transaction_no")
commit work;
create table "schl_type" (
	"schl_type"	char	(3)	not null primary key,
	"descript"	char	(30));
commit work;
create btree index "schl_type_index001" on "schl_type" (
"schl_type")
commit work;
create unique hash index "schl_type_index" on "schl_type" ("schl_type")
commit work;
create table "site_dets" (
	"property_id"	numeric	(9)	not null primary key
	"address_number"	char	(4),
	"county"	char	(20),
	"county_council"	char	(8),
	"d_council_ward"	char	(6),
	"district_council"	char	(8),
	"electoral_div1"	char	(3),
	"electoral_div2"	char	(3),
	"electoral_div3"	char	(3),
	"electoral_div4"	char	(3),
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"locality"	char	(30),
	"nat_grid_ref"	char	(12),
	"ord_survey_ref"	char	(10),
	"parish_council"	char	(8),
	"parl_constitncy"	char	(6),
	"post_code"	char	(8),
	"road"	char	(30),
	"serv_del_flag"	char	(1),
	"site_desc"	text
	"site_name"	char	(40),
	"s_serv_team_bnd1"	char	(1),
	"s_serv_team_bnd2"	char	(2),
	"s_serv_team_bnd3"	char	(1),
	"town"	char	(25));
commit work;
create btree index "site_dets_index001" on "site_dets" (
"property_id")
commit work;
create unique hash index "site_dets_index" on "site_dets" ("property_id")
commit work;
create table "ele_dets" (
	"element_code"	char	(10)	not null primary key,
	"area_required"	char	(1),
	"descript"	char	(30),
	"element_type"	char	(2),
	"height_required"	char	(1),
	"length_required"	char	(1),
	"quantity_required"	char	(1),
	"survey_interval"	numeric	(5)
	"upgrade_interval"	numeric	(5)
	"width_required"	char	(1));
commit work;
create btree index "ele_dets_index002" on "ele_dets" (
	"element_code",
"element_type")
commit work;
create btree index "ele_dets_index001" on "ele_dets" (
"element_code")
commit work;
create unique hash index "ele_dets_index" on "ele_dets" ("element_code")
commit work;
create table "surv_dets" (
	primary key ("survey_seq_no","property_id","element_counter","element_type","element_code"),
	"survey_seq_no"	numeric	(5)	not null
	"property_id"	numeric	(9)	not null
	"element_counter"	numeric	(4)	not null
	"element_type"	char	(2)	not null,
	"element_code"	char	(10)	not null,
	"condition_code"	char	(4),
	"construct_type"	char	(5),
	"element_seq_no"	char	(4),
	"element_area"	huge amount
	"element_height"	huge amount
	"element_length"	huge amount
	"element_quantity"	numeric	(6)
	"element_text"	text
	"element_width"	huge amount
	"last_survey_date"	huge date
	"last_upgrade"	huge date
	"next_survey"	huge date
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"plan"	amount	(8)
	"plan_text"	text
	"priority"	char	(1),
	"remaining_life"	numeric	(5)
	"repair_cost"	amount	(8)
	"servicable"	amount	(8)
	"upgrade_cost"	amount	(8)
commit work;
create btree index "surv_dets_index004" on "surv_dets" (
	"survey_seq_no" DESC,
"property_id")
commit work;
create btree index "surv_dets_index003" on "surv_dets" (
	"property_id",
	"survey_seq_no",
	"element_type",
	"element_code",
"element_counter")
commit work;
create btree index "surv_dets_index002" on "surv_dets" (
	"property_id",
	"element_type",
	"element_code",
	"survey_seq_no",
"element_counter")
commit work;
create btree index "surv_dets_index001" on "surv_dets" (
	"priority",
	"servicable" DESC,
	"element_type",
"element_code")
commit work;
create unique hash index "surv_dets_index" on "surv_dets" ("survey_seq_no","property_id","element_counter","element_type","element_code")
commit work;
create table "temp_plan" (
	primary key ("property_id","temp_plan_perm"),
	"property_id"	numeric	(9)	not null
	"temp_plan_perm"	char	(20)	not null,
	"descript"	text
	"expired_date"	huge date
	"granted_date"	huge date
	"temp_stat"	char	(1),
	"submit_date"	huge date
commit work;
create btree index "temp_plan_index002" on "temp_plan" (
	"temp_plan_perm",
"property_id")
commit work;
create btree index "temp_plan_index001" on "temp_plan" (
"property_id")
commit work;
create unique hash index "temp_plan_index" on "temp_plan" ("property_id","temp_plan_perm")
commit work;
create table "ten_docs" (
	"ten_doc_code"	char	(4)	not null primary key,
	"ten_doc_descript"	char	(60));
commit work;
create btree index "ten_docs_index001" on "ten_docs" (
"ten_doc_code")
commit work;
create unique hash index "ten_docs_index" on "ten_docs" ("ten_doc_code")
commit work;
create table "tenant" (
	"tenant"	char	(10)	not null primary key,
	"descript"	char	(24));
commit work;
create btree index "tenant_index001" on "tenant" (
"tenant")
commit work;
create unique hash index "tenant_index" on "tenant" ("tenant")
commit work;
create table "tenure" (
	"tenure"	char	(6)	not null primary key,
	"descrip"	char	(30));
commit work;
create btree index "tenure_index001" on "tenure" (
"tenure")
commit work;
create unique hash index "tenure_index" on "tenure" ("tenure")
commit work;
create table "trim_flds" (
	"frm_name"	char	(10)	not null primary key,
	"title"	char	(50),
	"trim1"	char	(78),
	"trim2"	char	(78),
	"trim3"	char	(78),
	"trim4"	char	(78),
	"trim5"	char	(78),
	"trim6"	char	(78),
	"trim7"	char	(78),
	"trim8"	char	(78),
	"trim9"	char	(78),
	"trim10"	char	(78),
	"trim11"	char	(78),
	"trim12"	char	(78),
	"trim13"	char	(78),
	"trim14"	char	(78),
	"trim15"	char	(78),
	"trim16"	char	(78),
	"trim17"	char	(78),
	"trim18"	char	(78),
	"trim19"	char	(78),
	"trim20"	char	(78),
	"trim21"	char	(78),
	"trim22"	char	(78),
	"trim23"	char	(78),
	"trim24"	char	(78),
	"trim25"	char	(78),
	"trim26"	char	(78),
	"trim27"	char	(78),
	"trim28"	char	(78),
	"trim29"	char	(78),
	"trim30"	char	(78),
	"trim31"	char	(78),
	"trim32"	char	(78),
	"trim33"	char	(78),
	"trim34"	char	(78),
	"trim35"	char	(78),
	"trim36"	char	(78),
	"trim37"	char	(78),
	"trim38"	char	(78),
	"trim39"	char	(78),
	"trim40"	char	(78),
	"trim41"	char	(78),
	"trim42"	char	(78),
	"trim43"	char	(78),
	"trim44"	char	(78),
	"trim45"	char	(78),
	"trim46"	char	(78),
	"trim47"	char	(78),
	"trim48"	char	(78),
	"trim49"	char	(78),
	"trim50"	char	(78),
	"trim51"	char	(78),
	"trim52"	char	(78),
	"trim53"	char	(78),
	"trim54"	char	(78),
	"trim55"	char	(78),
	"trim56"	char	(78),
	"trim57"	char	(78),
	"trim58"	char	(78),
	"trim59"	char	(78),
	"trim60"	char	(78));
commit work;
create btree index "trim_flds_index001" on "trim_flds" (
"frm_name")
commit work;
create unique hash index "trim_flds_index" on "trim_flds" ("frm_name")
commit work;
create table "wards" (
	"ward"	char	(4)	not null primary key,
	"descript"	char	(40));
commit work;
create btree index "wards_index001" on "wards" (
"ward")
commit work;
create unique hash index "wards_index" on "wards" ("ward")
commit work;
create table "hlp_info2" (
	primary key ("hlp_level","frm_name","fld_name"),
	"hlp_level"	char	(1)	not null,
	"frm_name"	char	(44)	not null,
	"fld_name"	char	(44)	not null,
	"hlp_text"	text
commit work;
create unique hash index "hlp_info2_index" on "hlp_info2" ("hlp_level","frm_name","fld_name")
commit work;
create table "ele_types" (
	"element_type"	char	(2)	not null primary key,
	"element_descript"	char	(38));
commit work;
create btree index "ele_types_index001" on "ele_types" (
"element_type")
commit work;
create unique hash index "ele_types_index" on "ele_types" ("element_type")
commit work;
create table "ele_yrs" (
	primary key ("property_id","element_type","instance","element_code","year"),
	"property_id"	numeric	(9)	not null
	"element_type"	char	(2)	not null,
	"instance"	numeric	(2)	not null
	"element_code"	char	(10)	not null,
	"year"	char	(4)	not null,
	"actual_cost_yr"	huge amount
	"condition"	char	(4),
	"est_cost_yr"	huge amount
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"priority"	char	(4));
commit work;
create btree index "ele_yrs_index002" on "ele_yrs" (
	"property_id",
	"year",
	"element_type",
	"element_code",
"instance")
commit work;
create btree index "ele_yrs_index001" on "ele_yrs" (
	"element_type",
	"element_code",
	"property_id",
	"instance",
"year")
commit work;
create unique hash index "ele_yrs_index" on "ele_yrs" ("property_id","element_type","instance","element_code","year")
commit work;
create table "pj_dets" (
	"project_code"	char	(6)	not null primary key,
	"descript"	char	(24),
	"start_date"	huge date
	"estimated_comp"	huge date
	"req_by_cost_cent"	char	(4),
	"budget"	numeric	(8)
	"management_unit"	char	(4),
	"orig_approved"	huge amount
	"latest_approved"	huge amount
	"latest_estimated"	huge amount
	"forecast_ny"	huge amount
	"paid_prev_years"	huge amount
	"job_manager"	char	(8),
	"account_code"	char	(15),
	"forecast_ny_1"	huge amount
	"forecast_ny_2"	huge amount
	"forecast_ny_3"	huge amount
	"forecast_ny_4"	huge amount
	"forecast_ny_5"	huge amount
	"forecast_future"	huge amount
	"forecast_total"	huge amount
	"live_flag"	char	(1),
	"date_completed"	huge date
commit work;
create btree index "pj_dets_index023" on "pj_dets" (
	"account_code",
"req_by_cost_cent")
commit work;
create unique btree index "pj_dets_index022" on "pj_dets" (
	"project_code",
	"management_unit",
	"req_by_cost_cent",
"account_code")
commit work;
create unique hash index "pj_dets_index" on "pj_dets" ("project_code")
commit work;
create table "grn_dets" (
	"grn_number"	char	(10)	not null primary key,
	"del_note_no"	char	(8),
	"invoice_date"	huge date
	"locat"	numeric	(2)
	"stock_yn_flag"	char	(1),
	"account_code"	char	(15),
	"cost_centre"	char	(4),
	"received_qty"	numeric	(5)
	"received_val_fld"	amount	(9)
	"grn_date"	huge date
	"invoice_number"	char	(12),
	"order_number"	numeric	(8)
	"order_line_no"	numeric	(3)
	"stock_part_code"	char	(10),
	"supplier"	char	(8),
	"financial_year"	char	(4),
	"financial_period"	numeric	(2)
	"invoiced_val_fld"	amount	(9)
	"invoiced_qty"	numeric	(5)
	"document_type"	char	(2),
	"document_number"	numeric	(6)
	"invoice_period"	numeric	(2)
	"invoice_year"	char	(4),
	"vat_val_fld"	amount	(9)
	"entered_by"	char	(8),
	"entered_on"	huge date
	"include_in_batch"	char	(1),
	"batch_number"	numeric	(6)
commit work;
create btree index "grn_dets_index080" on "grn_dets" (
	"batch_number",
"document_type")
commit work;
create btree index "grn_dets_index079" on "grn_dets" (
	"invoice_number",
"supplier")
commit work;
create btree index "grn_dets_index046" on "grn_dets" (
"supplier")
commit work;
create unique btree index "grn_dets_index048" on "grn_dets" (
	"order_number",
	"order_line_no",
	"grn_number",
"invoice_number")
commit work;
create unique btree index "grn_dets_index060" on "grn_dets" (
"grn_number")
commit work;
create btree index "grn_dets_index077" on "grn_dets" (
	"stock_part_code",
"locat")
commit work;
create btree index "grn_dets_index078" on "grn_dets" (
	"document_type",
"document_number")
commit work;
create unique hash index "grn_dets_index" on "grn_dets" ("grn_number")
commit work;
create table "job_audt" (
	"job_id"	char	(6)	not null primary key,
	"pm_job_no_req_no"	char	(6),
	"date_cancelled"	huge date
	"ref_login_name"	char	(14),
	"reason"	char	(24));
commit work;
create unique hash index "job_audt_index" on "job_audt" ("job_id")
commit work;
create table "land_surv" (
	primary key ("property_id","survey_date"),
	"property_id"	numeric	(9)	not null
	"survey_date"	huge date	not null
	"site_area"	float	(64)
	"build_comments"	text
	"car_park_area"	numeric	(5)
	"date_measured"	huge date
	"dev_factors"	text
	"electricity"	char	(1),
	"fencing_cond"	char	(4),
	"foul_water_mains"	char	(1),
	"foul_water_plant"	char	(1),
	"gas"	char	(1),
	"gen_comments"	text
	"land_cond_code1"	char	(1),
	"land_cond_code2"	char	(1),
	"land_cond_code3"	char	(1),
	"land_cond_code4"	char	(1),
	"land_cond_code5"	char	(1),
	"land_cond_code6"	char	(1),
	"phland_code"	char	(6),
	"land_desc"	text
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"measurer"	char	(20),
	"no_car_spaces"	numeric	(4)
	"oil_heating"	char	(1),
	"ped_access"	char	(1),
	"ped_access_desc"	text
	"site_desc"	text
	"surveyor_name"	char	(20),
	"telephone"	char	(1),
	"veh_access_desc"	text
	"vehicle_access"	char	(1),
	"water"	char	(1));
commit work;
create btree index "land_surv_index001" on "land_surv" (
	"property_id",
"survey_date")
commit work;
create unique hash index "land_surv_index" on "land_surv" ("property_id","survey_date")
commit work;
create table "prem_loc" (
	primary key ("property_id","loc_fin_sys_code"),
	"property_id"	numeric	(9)	not null
	"loc_fin_sys_code"	char	(7)	not null);
commit work;
create btree index "prem_loc_index001" on "prem_loc" (
	"loc_fin_sys_code",
"property_id")
commit work;
create btree index "prem_loc_index002" on "prem_loc" (
"property_id")
commit work;
create btree index "prem_loc_index003" on "prem_loc" (
	"property_id",
"loc_fin_sys_code")
commit work;
create unique hash index "prem_loc_index" on "prem_loc" ("property_id","loc_fin_sys_code")
commit work;
create table "asbestos" (
	"property_id"	numeric	(9)	not null primary key
	"actioned_by"	char	(40),
	"asbestos_found"	char	(1),
	"date_completed"	huge date
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"lfs_code"	char	(7),
	"next_survey"	huge date
	"survey_cost"	numeric	(9)
	"survey_date"	huge date
	"surveyed_by"	char	(40),
	"urgency_number"	char	(1),
	"work_order_no"	char	(12));
commit work;
create btree index "asbestos_index001" on "asbestos" (
"property_id")
commit work;
create unique hash index "asbestos_index" on "asbestos" ("property_id")
commit work;
create table "soc_servs" (
	primary key ("soc_serv1","soc_serv2","soc_serv3"),
	"soc_serv1"	char	(1)	not null,
	"soc_serv2"	char	(2)	not null,
	"soc_serv3"	char	(1)	not null,
	"soc_serv_descript"	char	(40));
commit work;
create btree index "soc_servs_index001" on "soc_servs" (
"soc_serv1")
commit work;
create btree index "soc_servs_index002" on "soc_servs" (
	"soc_serv1",
	"soc_serv2",
"soc_serv3")
commit work;
create unique hash index "soc_servs_index" on "soc_servs" ("soc_serv1","soc_serv2","soc_serv3")
commit work;
create table "ass_dets" (
	"property_id"	numeric	(9)	not null primary key
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"asset_category"	char	(2),
	"land_and_build"	char	(1),
	"basis_of_val"	char	(5),
	"method_of_val"	char	(3),
	"type_of_prop"	char	(1));
commit work;
create btree index "ass_dets_index001" on "ass_dets" (
"property_id")
commit work;
create unique hash index "ass_dets_index" on "ass_dets" ("property_id")
commit work;
create table "land_use" (
	"land_use_code"	char	(5)	not null primary key,
	"land_use_descript"	text
commit work;
create btree index "land_use_index001" on "land_use" (
"land_use_code")
commit work;
create unique hash index "land_use_index" on "land_use" ("land_use_code")
commit work;
create table "surveys" (
	primary key ("property_id","survey_seq_no"),
	"property_id"	numeric	(9)	not null
	"survey_seq_no"	numeric	(5)	not null
	"date_surveyed"	huge date
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"nam_add_surveyor"	char	(8),
	"surveyor"	char	(30),
	"survey_descript"	char	(30),
	"survey_text"	text
commit work;
create btree index "surveys_index002" on "surveys" (
	"property_id",
"survey_seq_no")
commit work;
create btree index "surveys_index001" on "surveys" (
	"property_id",
"date_surveyed")
commit work;
create unique hash index "surveys_index" on "surveys" ("property_id","survey_seq_no")
commit work;
create table "restr_dets" (
	"property_id"	numeric	(9)	not null primary key
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"tree_pres_order"	text
	"oth_t_plan_info"	text
	"geo_min_wat_sew"	text
	"bound_type_resp"	text
	"disp_land_detail"	text
	"add_details"	text
	"puswa_not_iss_rec"	text
	"land_consrv_area"	text
	"protected_specs"	text
	"other_use_1"	text
	"other_use_2"	text
	"access_to_land"	text
commit work;
create unique hash index "restr_dets_index" on "restr_dets" ("property_id")
commit work;
create table "compl_dets" (
	primary key ("property_id","act_name"),
	"property_id"	numeric	(9)	not null
	"act_name"	char	(30)	not null,
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"compliance"	char	(1),
	"date_insp"	huge date
	"detail"	text
commit work;
create unique hash index "compl_dets_index" on "compl_dets" ("property_id","act_name")
commit work;
create table "bld_opcost" (
	primary key ("property_id","cost_date"),
	"property_id"	numeric	(9)	not null
	"cost_date"	huge date	not null
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"a_maint_cost"	huge amount
	"a_gnd_maint_cost"	huge amount
	"a_elec_cost"	huge amount
	"a_gas_cost"	huge amount
	"a_water_cost"	huge amount
	"a_fuel_oil_cost"	huge amount
	"a_sec_cost"	huge amount
	"a_rent_cost"	huge amount
	"a_rates_cost"	huge amount
	"a_clean_cost"	huge amount
	"other_a_cost"	huge amount
	"tot_a_cost"	huge amount
commit work;
create unique hash index "bld_opcost_index" on "bld_opcost" ("property_id","cost_date")
commit work;
create table "occupancy" (
	"property_id"	numeric	(9)	not null primary key
	"name"	char	(40),
	"add_no"	char	(4),
	"address1"	char	(30),
	"address2"	char	(30),
	"address3"	char	(30),
	"address4"	char	(30),
	"post_code"	char	(12),
	"area_empty"	char	(8),
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"leasehold_covenants"	text
	"other_lease_details"	text
	"current_annual_rent"	huge amount
	"rent_due_date"	huge date
	"rent_review_date"	huge date
	"date_rent_set"	huge date
	"lease_expiry_date"	huge date
	"length_of_lease"	numeric	(6)
	"date_vacated"	huge date
commit work;
create unique hash index "occupancy_index" on "occupancy" ("property_id")
commit work;
create table "energy_per" (
	"property_id"	numeric	(9)	not null primary key
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"fabric_en"	char	(4),
	"engineer_en"	char	(4),
	"energy_pe"	char	(4),
	"surv_nam"	char	(8),
	"surveyor"	char	(30),
	"fabric_up"	numeric	(9)
	"engineer_up"	numeric	(9)
	"date_of_survey"	huge date
commit work;
create unique hash index "energy_per_index" on "energy_per" ("property_id")
commit work;
create table "en_perform" (
	"energy_per"	char	(4)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "en_perform_index" on "en_perform" ("energy_per")
commit work;
create table "energy_cat" (
	"energy_cat"	char	(4)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "energy_cat_index" on "energy_cat" ("energy_cat")
commit work;
create table "fitness" (
	"property_id"	numeric	(9)	not null primary key
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"overall"	char	(4),
	"facilities"	char	(4),
	"space_rel"	char	(4),
	"locat"	char	(4),
	"environment"	char	(4),
	"amenity"	char	(4),
	"other"	char	(4),
	"cost_to_upg"	huge amount
	"cost_to_rep"	huge amount
	"date_or_surv"	huge date
	"surveyor"	char	(8),
	"surveyed_by"	char	(30));
commit work;
create unique hash index "fitness_index" on "fitness" ("property_id")
commit work;
create table "ss_maint" (
	"property_id"	numeric	(9)	not null primary key
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"sc_esc"	char	(4),
	"sc_std"	char	(4),
	"sc_alarm"	char	(4),
	"sc_bld"	char	(4),
	"sc_food"	char	(4),
	"sc_other"	char	(4),
	"sc_esc_up"	numeric	(9)
	"sc_std_up"	numeric	(9)
	"sc_alarm_up"	numeric	(9)
	"sc_bld_up"	numeric	(9)
	"sc_food_up"	numeric	(9)
	"sc_other_up"	numeric	(9)
	"overall_fs"	char	(4),
	"overall_hs"	char	(4),
	"date_of_survey"	huge date
	"surv_name"	char	(8),
	"surveyor"	char	(30));
commit work;
create unique hash index "ss_maint_index" on "ss_maint" ("property_id")
commit work;
create table "room_dets" (
	"property_id"	numeric	(9)	not null primary key
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"capacity"	huge amount
	"actual_use"	huge amount
	"floor_area"	huge amount
	"heated_vol"	huge amount
	"gross_vol"	huge amount
	"electricity"	char	(1),
	"gas"	char	(1),
	"other1"	char	(1),
	"other2"	char	(1),
	"other3"	char	(1),
	"other4"	char	(1),
	"other5"	char	(1),
	"other6"	char	(1),
	"other7"	char	(1),
	"other8"	char	(1),
	"other9"	char	(1),
	"comms"	char	(1),
	"no_other1"	numeric	(5)
	"no_other2"	numeric	(5)
	"no_other3"	numeric	(5)
	"no_other4"	numeric	(5)
	"no_other5"	numeric	(5)
	"no_other6"	numeric	(5)
	"no_other7"	numeric	(5)
	"no_other8"	numeric	(5)
	"no_other9"	numeric	(5)
	"no_comms"	numeric	(5)
	"no_electricity"	numeric	(5)
	"no_gas"	numeric	(5)
commit work;
create unique hash index "room_dets_index" on "room_dets" ("property_id")
commit work;
create table "fit_code" (
	"fit_code"	char	(4)	not null primary key,
	"descript"	char	(24));
commit work;
create unique hash index "fit_code_index" on "fit_code" ("fit_code")
commit work;
create table "encumber" (
	primary key ("property_id","deed_packet_ref","encum_benefit_cde","record_type"),
	"property_id"	numeric	(9)	not null
	"deed_packet_ref"	char	(12)	not null,
	"encum_benefit_cde"	char	(2)	not null,
	"record_type"	char	(1)	not null,
	"descript"	text
commit work;
create btree index "encumber_index001" on "encumber" (
	"property_id",
	"deed_packet_ref",
	"encum_benefit_cde",
"record_type")
commit work;
create btree index "encumber_index002" on "encumber" (
	"property_id",
	"deed_packet_ref",
	"record_type",
"encum_benefit_cde")
commit work;
create unique hash index "encumber_index" on "encumber" ("property_id","deed_packet_ref","encum_benefit_cde","record_type")
commit work;
create table "stat_dets" (
	"stat_code"	char	(4)	not null primary key,
	"stat_descript"	char	(40));
commit work;
create unique hash index "stat_dets_index" on "stat_dets" ("stat_code")
commit work;
create table "ratings" (
	primary key ("property_id","valuation_list"),
	"property_id"	numeric	(9)	not null
	"valuation_list"	char	(15)	not null,
	"glh_cons_ref"	char	(12),
	"building_age"	char	(4),
	"building_cond"	char	(1),
	"charity_rel"	char	(1),
	"class_listed"	char	(1),
	"college"	text
	"contractor"	text
	"county"	char	(25),
	"dfe_return"	char	(1),
	"estate_ref_1"	char	(8),
	"estate_ref_2"	char	(4),
	"estate_ref_3"	char	(10),
	"exit_area_f"	numeric	(9)
	"exit_area_m"	numeric	(9)
	"formula"	text
	"gross_val_1"	numeric	(6)
	"gross_val_2"	numeric	(6)
	"gross_val_3"	numeric	(6)
	"gross_val_4"	numeric	(6)
	"gross_val_5"	numeric	(6)
	"ind_ware_work"	text
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"lifts"	char	(1),
	"modern_c_heat"	text
	"mkt_rent_prev"	text
	"modern_a_cond"	text
	"net_int_code1_f"	numeric	(9)
	"net_int_code2_f"	numeric	(9)
	"net_int_code3_f"	numeric	(9)
	"net_int_code1_m"	numeric	(9)
	"net_int_code2_m"	numeric	(9)
	"net_int_code3_m"	numeric	(9)
	"net_val_1"	numeric	(6)
	"net_val_2"	numeric	(6)
	"net_val_3"	numeric	(6)
	"net_val_4"	numeric	(6)
	"net_val_5"	numeric	(6)
	"occupier_com"	char	(20),
	"occupier_ten"	char	(20),
	"office"	text
	"other_use"	text
	"other"	text
	"plant_machine_t"	text
	"play_f_tenn_c"	text
	"pool_use_excl"	char	(1),
	"pool_use_joint"	char	(19),
	"prime_1"	numeric	(4)
	"prime_2"	numeric	(4)
	"prime_3"	numeric	(4)
	"prime_4"	numeric	(4)
	"prime_5"	numeric	(4)
	"profits"	text
	"property_type"	char	(3),
	"prop_owner"	char	(20),
	"pupils_recog"	numeric	(9)
	"pupils_stand"	numeric	(9)
	"pup_onroll_1"	amount	(7)
	"pup_onroll_2"	amount	(7)
	"pup_onroll_3"	amount	(7)
	"pup_onroll_4"	amount	(7)
	"pup_onroll_5"	amount	(7)
	"pup_rec_1"	numeric	(4)
	"pup_rec_2"	numeric	(4)
	"pup_rec_3"	numeric	(4)
	"pup_rec_4"	numeric	(4)
	"pup_rec_5"	numeric	(4)
	"pup_stand_1"	numeric	(4)
	"pup_stand_2"	numeric	(4)
	"pup_stand_3"	numeric	(4)
	"pup_stand_4"	numeric	(4)
	"pup_stand_5"	numeric	(4)
	"rates_pay_1"	huge amount
	"rates_pay_2"	huge amount
	"rates_pay_3"	huge amount
	"rates_pay_4"	huge amount
	"rates_pay_5"	huge amount
	"rate_val_1993"	amount	(9)
	"rating_author"	char	(12),
	"rca_area_m"	numeric	(9)
	"rca_area_f"	numeric	(9)
	"school_ref_no"	char	(4),
	"s_hall_use_excl"	char	(1),
	"s_hall_use_joint"	char	(20),
	"shop"	text
	"start_date_1"	huge date
	"start_date_2"	huge date
	"start_date_3"	huge date
	"start_date_4"	huge date
	"start_date_5"	huge date
	"superfluity_1"	amount	(7)
	"superfluity_2"	amount	(7)
	"superfluity_3"	amount	(7)
	"superfluity_4"	amount	(7)
	"superfluity_5"	amount	(7)
	"super_date_1"	huge date
	"super_date_2"	huge date
	"super_date_3"	huge date
	"super_date_4"	huge date
	"super_date_5"	huge date
	"victorian_desc"	char	(12),
	"year_1"	char	(5),
	"year_2"	char	(5),
	"year_3"	char	(5),
	"year_4"	char	(5),
	"year_5"	char	(5));
commit work;
create btree index "ratings_index003" on "ratings" (
	"property_id",
"valuation_list")
commit work;
create btree index "ratings_index001" on "ratings" (
"property_id")
commit work;
create btree index "ratings_index002" on "ratings" (
	"valuation_list",
"glh_cons_ref")
commit work;
create unique hash index "ratings_index" on "ratings" ("property_id","valuation_list")
commit work;
create table "alt_st_dts" (
	"property_id"	numeric	(9)	not null primary key
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"address_number"	char	(4),
	"locality"	char	(30),
	"road"	char	(30),
	"site_name"	char	(40),
	"town"	char	(25),
	"county"	char	(20),
	"post_code"	char	(8),
	"site_desc"	text
	"gas_sup_l_office"	char	(8),
	"gas_service_dets"	text
	"elec_sup_l_office"	char	(8),
	"elec_serv_dets"	text
	"water_sup_l_office"	char	(8),
	"water_serv_dets"	text
	"dr_auth_l_office"	char	(8),
	"dr_arrangement"	text
	"oth_sup_name_1"	char	(8),
	"oth_sup_dets_1"	text
	"oth_sup_name_2"	char	(8),
	"oth_sup_dets_2"	text
	"loc_plan_officer"	char	(8),
	"h_way_authority"	char	(8),
	"river_authority"	char	(8),
	"district_valuer"	char	(8),
	"hlth_sfe_l_office"	char	(8),
	"other"	char	(8),
	"telecom_provider"	char	(8),
	"telecom_det"	text
	"land_area_hect"	huge amount
	"hard_area_hect"	huge amount
	"disp_land_area"	huge amount
	"soft_area_hect"	huge amount
	"car_park_area"	huge amount
	"no_of_spaces"	numeric	(5)
	"terr_plan_no"	char	(8),
	"listed_building"	char	(8),
	"exist_use_des"	text
	"land_val_pres_use"	huge amount
	"present_use_dt"	huge date
	"pot_use_desig"	text
	"land_val_pot_use"	huge amount
	"pot_use_date"	huge date
	"non_domestic_rv"	huge amount
	"non_dom_date"	huge date
	"exist_consent"	text
	"exist_consent_exp"	huge date
	"surveyed_by"	char	(8),
	"surv_name"	char	(30),
	"date_of_survey"	huge date
commit work;
create unique hash index "alt_st_dts_index" on "alt_st_dts" ("property_id")
commit work;
create table "hold_comm" (
	"hold_comm_code"	char	(4)	not null primary key,
	"hold_comm_descript"	char	(24));
commit work;
create btree index "hold_comm_index001" on "hold_comm" (
"hold_comm_code")
commit work;
create unique hash index "hold_comm_index" on "hold_comm" ("hold_comm_code")
commit work;
create table "serv_deps" (
	"serv_deps_code"	char	(5)	not null primary key,
	"serv_deps_descript"	char	(24));
commit work;
create btree index "serv_deps_index001" on "serv_deps" (
"serv_deps_code")
commit work;
create unique hash index "serv_deps_index" on "serv_deps" ("serv_deps_code")
commit work;
create table "bu_rec" (
	primary key ("financial_year","cost_centre","account_code"),
	"financial_year"	char	(4)	not null,
	"cost_centre"	char	(4)	not null,
	"account_code"	char	(15)	not null,
	"annual_budget"	numeric	(8)
	"same_each_period"	char	(1),
	"dummy_period"	numeric	(2)
	"management_unit"	char	(4),
	"budget_period_1"	numeric	(8)
	"budget_period_2"	numeric	(8)
	"budget_period_3"	numeric	(8)
	"budget_period_4"	numeric	(8)
	"budget_period_5"	numeric	(8)
	"budget_period_6"	numeric	(8)
	"budget_period_7"	numeric	(8)
	"budget_period_8"	numeric	(8)
	"budget_period_9"	numeric	(8)
	"budget_period_10"	numeric	(8)
	"budget_period_11"	numeric	(8)
	"budget_period_12"	numeric	(8)
	"budget_period_13"	numeric	(8)
	"commt_period_1"	huge amount
	"commt_period_2"	huge amount
	"commt_period_3"	huge amount
	"commt_period_4"	huge amount
	"commt_period_5"	huge amount
	"commt_period_6"	huge amount
	"commt_period_7"	huge amount
	"commt_period_8"	huge amount
	"commt_period_9"	huge amount
	"commt_period_10"	huge amount
	"commt_period_11"	huge amount
	"commt_period_12"	huge amount
	"commt_period_13"	huge amount
	"expend_period_1"	huge amount
	"expend_period_2"	huge amount
	"expend_period_3"	huge amount
	"expend_period_4"	huge amount
	"expend_period_5"	huge amount
	"expend_period_6"	huge amount
	"expend_period_7"	huge amount
	"expend_period_8"	huge amount
	"expend_period_9"	huge amount
	"expend_period_10"	huge amount
	"expend_period_11"	huge amount
	"expend_period_12"	huge amount
	"expend_period_13"	huge amount
	"last_year_actual"	huge amount
	"estimated_actual"	numeric	(8)
commit work;
create btree index "bu_rec_index124" on "bu_rec" (
	"account_code",
"cost_centre")
commit work;
create btree index "bu_rec_index042" on "bu_rec" (
	"financial_year",
"account_code")
commit work;
create unique btree index "bu_rec_index014" on "bu_rec" (
	"financial_year",
	"cost_centre",
"account_code")
commit work;
create btree index "bu_rec_index006" on "bu_rec" (
	"cost_centre",
"account_code")
commit work;
create unique hash index "bu_rec_index" on "bu_rec" ("financial_year","cost_centre","account_code")
commit work;
create table "pm_job" (
	"pm_job_id"	char	(6)	not null primary key,
	"asset_id"	char	(6),
	"frequency_weeks"	numeric	(3)
	"next_wk_sched_n"	numeric	(6)
	"next_wk_sched"	char	(7),
	"trade"	char	(1),
	"grade_1"	char	(3),
	"grade_2"	char	(3),
	"grade_3"	char	(3),
	"grade_4"	char	(3),
	"quantity_1"	numeric	(1)
	"quantity_2"	numeric	(1)
	"quantity_3"	numeric	(1)
	"quantity_4"	numeric	(1)
	"estimated_cost"	amount	(8)
	"no_of_omissions"	numeric	(2)
	"job_type_code"	char	(2),
	"wk_cont_time_hrs"	amount	(5)
	"allowce_time_hrs"	amount	(5)
	"priority_code"	char	(2),
	"access_code"	char	(1),
	"asset_cost_cent"	char	(4),
	"charg_cost_cent"	char	(4),
	"account_code"	char	(15),
	"series_no"	numeric	(1)
	"category"	char	(2),
	"safety_permit_yn"	char	(1),
	"date_last_compl"	huge date
	"skip_flag"	char	(1),
	"contract_code"	char	(6),
	"contract_type"	char	(3),
	"dorc_flag"	char	(1),
	"last_wk_transfer"	char	(7),
	"statutory_job"	char	(1));
commit work;
create btree index "pm_job_index147" on "pm_job" (
	"asset_id",
"statutory_job")
commit work;
create unique btree index "pm_job_index146" on "pm_job" (
	"asset_id",
	"dorc_flag",
	"trade",
	"series_no",
	"frequency_weeks",
"next_wk_sched_n")
commit work;
create unique btree index "pm_job_index145" on "pm_job" (
	"dorc_flag",
	"asset_id",
	"trade",
	"series_no",
"frequency_weeks")
commit work;
create btree index "pm_job_index144" on "pm_job" (
	"asset_id",
	"trade",
	"series_no",
	"frequency_weeks",
"next_wk_sched_n")
commit work;
create btree index "pm_job_index143" on "pm_job" (
	"next_wk_sched_n",
	"asset_cost_cent",
	"trade",
	"job_type_code",
"priority_code")
commit work;
create unique btree index "pm_job_index142" on "pm_job" (
"pm_job_id")
commit work;
create unique hash index "pm_job_index" on "pm_job" ("pm_job_id")
commit work;
create table "adv_note" (
	"advice_note"	char	(15)	not null primary key,
	"advice_text"	text
commit work;
create unique hash index "adv_note_index" on "adv_note" ("advice_note")
commit work;
create table "ca_dels" (
	primary key ("capital_asset_code","capital_sub_asset_no"),
	"capital_asset_code"	char	(21)	not null,
	"capital_sub_asset_no"	numeric	(4)	not null
	"notes"	char	(50),
	"charge_type"	char	(6),
	"int_type"	char	(2),
	"pr_index_type"	char	(3),
	"purchase_type"	char	(1),
	"acceptance_date"	huge date
	"replacement_date"	huge date
	"remaining_life"	numeric	(4)
	"last_charged"	char	(6),
	"purchase_price"	huge amount
	"indexed_replacement_cost"	huge amount
	"depreciation_to_date"	huge amount
	"net_book_val_fld"	huge amount
	"interest"	huge amount
	"division"	char	(4),
	"management_unit"	char	(4),
	"cost_centre"	char	(4),
	"account_code"	char	(15),
	"asset_id"	char	(6),
	"property_id"	numeric	(9)
	"prev_capital_asset_code"	char	(21),
	"prev_capital_sub_asset_no"	numeric	(4)
	"residual_val_fld"	huge amount
	"apportionment_count"	numeric	(4)
commit work;
create btree index "ca_dels_index_02" on "ca_dels" (
"property_id")
commit work;
create btree index "ca_dels_index_01" on "ca_dels" (
"asset_id")
commit work;
create unique hash index "ca_dels_index" on "ca_dels" ("capital_asset_code","capital_sub_asset_no")
commit work;
create table "lettings" (
	primary key ("property_id","deed_packet_ref","lfs_code","occurrence_s_d_i"),
	"property_id"	numeric	(9)	not null
	"deed_packet_ref"	char	(12)	not null,
	"lfs_code"	char	(7)	not null,
	"occurrence_s_d_i"	numeric	(2)	not null
	"active_service"	char	(1),
	"agreement_date"	huge date
	"agreement_type"	char	(1),
	"agree_term_days"	numeric	(3)
	"agree_term_mths"	numeric	(3)
	"agree_term_yrs"	numeric	(3)
	"alien_clause"	char	(1),
	"alien_clause_desc"	text
	"alien_clause_type"	char	(1),
	"break_clause"	char	(4),
	"current_rent"	huge amount
	"division"	char	(4),
	"business_unit"	char	(4),
	"department"	char	(4),
	"essence_time"	char	(1),
	"est_expend"	numeric	(9)
	"est_income"	numeric	(9)
	"exten_opt_days"	numeric	(3)
	"exten_opt_mths"	numeric	(3)
	"exten_opt_yrs"	numeric	(3)
	"hold_committee"	char	(4),
	"include_exclude"	char	(1),
	"insured_by"	char	(1),
	"interest"	char	(1),
	"landlord_repair"	text
	"land_use_code"	char	(5),
	"late_payment"	char	(1),
	"live_flag"	char	(1),
	"live_flag_date"	huge date
	"l_lord_ten_excl"	char	(1),
	"man_committee"	char	(4),
	"ownr_organ_add"	char	(40),
	"ownr_address_no"	char	(4),
	"ownr_road"	char	(30),
	"ownr_locality"	char	(30),
	"ownr_town"	char	(25),
	"ownr_county"	char	(20),
	"ownr_post_code"	char	(8),
	"pay_period"	char	(10),
	"purpose_held"	char	(1),
	"rent_abate"	huge amount
	"rent_basis"	char	(1),
	"rent_basis_desc"	text
	"rent_renew_date_1"	huge date
	"rent_renew_date_2"	huge date
	"rent_renew_date_3"	huge date
	"rent_renew_date_4"	huge date
	"rent_renew_date_5"	huge date
	"rent_renew_date_6"	huge date
	"rent_renew_date_7"	huge date
	"rent_renew_date_8"	huge date
	"rent_renew_date_9"	huge date
	"renew_date_all"	char	(99),
	"review_per_mths"	numeric	(3)
	"review_per_yrs"	numeric	(3)
	"service_charges"	char	(1),
	"service_chg"	huge amount
	"sub_let_desc"	text
	"sub_let_to"	char	(40),
	"tenancy_doc_cde"	char	(10),
	"tenant_repair"	text
	"term_indicator"	char	(1),
	"usr_clause"	char	(1),
	"usr_desc"	text
commit work;
create btree index "lettings_index001" on "lettings" (
"lfs_code")
commit work;
create btree index "lettings_index004" on "lettings" (
	"property_id",
	"deed_packet_ref",
"lfs_code")
commit work;
create btree index "lettings_index003" on "lettings" (
"occurrence_s_d_i")
commit work;
create btree index "lettings_index002" on "lettings" (
	"live_flag",
"live_flag_date")
commit work;
create unique hash index "lettings_index" on "lettings" ("property_id","deed_packet_ref","lfs_code","occurrence_s_d_i")
commit work;
create table "cw_job" (
	"cw_job_id"	char	(6)	not null primary key,
	"project_code"	char	(6),
	"job_id_req_no"	char	(6),
	"work_type"	char	(1),
	"docket_no"	char	(6),
	"asset_id"	char	(6),
	"management_unit"	char	(4),
	"reason_for_delay"	char	(1),
	"out_of_seq_flag"	char	(1),
	"job_type_code"	char	(2),
	"trade"	char	(1),
	"grade_1"	char	(3),
	"grade_2"	char	(3),
	"grade_3"	char	(3),
	"grade_4"	char	(3),
	"quantity_1"	numeric	(1)
	"quantity_2"	numeric	(1)
	"quantity_3"	numeric	(1)
	"quantity_4"	numeric	(1)
	"asset_cost_cent"	char	(4),
	"charg_cost_cent"	char	(4),
	"account_code"	char	(15),
	"category"	char	(2),
	"priority_code"	char	(2),
	"week_planned"	char	(7),
	"date_reported"	huge date
	"date_to_comp_ex"	huge date
	"wk_cont_time_hrs"	amount	(5)
	"allowce_time_hrs"	amount	(5)
	"rev_wk_cont_time"	amount	(5)
	"rev_allow_time"	amount	(5)
	"tot_hours_compl"	amount	(5)
	"labour_cost"	amount	(9)
	"materials_cost"	amount	(9)
	"fault_code"	char	(3),
	"failure_yn"	char	(1),
	"downtime_hours"	amount	(5)
	"time_to_repr_hrs"	amount	(5)
	"wrk_done_summary"	char	(24),
	"access_code"	char	(1),
	"series"	numeric	(1)
	"frequency"	numeric	(3)
	"site_code"	char	(3),
	"building_code"	char	(3),
	"locat_code"	char	(6),
	"asset_no"	char	(6),
	"sub_asset_no"	char	(3),
	"asset_name"	char	(24),
	"asset_type"	char	(6),
	"time_reported"	time
	"contract_code"	char	(6),
	"contract_type"	char	(3),
	"dorc_flag"	char	(1),
	"status_flag"	char	(1),
	"workshop"	char	(3),
	"estimated_cost"	amount	(8)
	"estimated_hrs"	amount	(5)
	"purch_order_flag"	char	(1),
	"safety_permit_yn"	char	(1),
	"reported_by"	char	(24),
	"site_code_bt"	numeric	(6)
	"building_code_bt"	numeric	(6)
	"locat_bt1"	numeric	(6)
	"locat_bt2"	numeric	(6)
	"asset_no_bt1"	numeric	(6)
	"asset_no_bt2"	numeric	(6)
	"sub_asset_no_bt"	numeric	(6)
	"statutory_job"	char	(1),
	"resp_date_plan"	huge date
	"resp_time_plan"	time
	"comp_date_plan"	huge date
	"comp_time_plan"	time
	"maintenance_plan"	char	(2),
	"resp_serv_level"	char	(2),
	"down_serv_level"	char	(2),
	"logged_by"	char	(10),
	"time_resp"	time
	"time_resp_a"	amount	(5)
	"date_act_resp"	huge date
	"log_date"	huge date
	"log_time"	time
	"phoenix_code"	char	(6),
	"usr_ref_fld"	char	(12),
	"delay_time_comp_a"	amount	(5)
	"delay_time_comp"	time
	"delay_date_comp"	huge date
	"delay_time_resp_a"	amount	(5)
	"delay_time_resp"	time
	"delay_date_act_resp"	huge date
commit work;
create btree index "cw_job_index134" on "cw_job" (
	"wk_cont_time_hrs",
"docket_no")
commit work;
create btree index "cw_job_index133" on "cw_job" (
	"delay_date_comp",
	"wk_cont_time_hrs",
	"docket_no",
"status_flag")
commit work;
create btree index "cw_job_index132" on "cw_job" (
	"site_code_bt",
	"building_code_bt",
	"locat_bt1",
	"locat_bt2",
	"asset_no_bt1",
	"asset_no_bt2",
"sub_asset_no_bt")
commit work;
create btree index "cw_job_index131" on "cw_job" (
	"asset_id",
	"dorc_flag",
	"trade",
	"series",
"week_planned")
commit work;
create btree index "cw_job_index130" on "cw_job" (
	"dorc_flag",
	"asset_id",
	"trade",
	"series",
"work_type")
commit work;
create btree index "cw_job_index129" on "cw_job" (
"job_id_req_no")
commit work;
create unique btree index "cw_job_index128" on "cw_job" (
"cw_job_id")
commit work;
create btree index "cw_job_index116" on "cw_job" (
	"docket_no",
	"dorc_flag",
"status_flag")
commit work;
create btree index "cw_job_index044" on "cw_job" (
"status_flag")
commit work;
create btree index "cw_job_index109" on "cw_job" (
	"docket_no",
"wk_cont_time_hrs")
commit work;
create unique hash index "cw_job_index" on "cw_job" ("cw_job_id")
commit work;
create table "land_val" (
	"property_id"	numeric	(9)	not null primary key
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"method_of_val"	char	(3),
	"hard_surf_area"	float	(64)
	"hsa_pnds_per_hect"	numeric	(9)
	"hsa_value"	numeric	(9)
	"open_surf_area"	float	(64)
	"osa_pnds_per_hect"	numeric	(9)
	"osa_value"	numeric	(9)
	"end_adjustment"	numeric	(9)
	"total_land_area"	float	(64)
	"total_value"	numeric	(9)
	"comments"	text
	"eff_val_date"	huge date
	"date_val_carr_out"	huge date
	"valuer_code"	char	(4));
commit work;
create btree index "land_val_index001" on "land_val" (
"property_id")
commit work;
create unique hash index "land_val_index" on "land_val" ("property_id")
commit work;
create table "bdg_dets" (
	primary key ("building_code","site_code"),
	"building_code"	char	(3)	not null,
	"site_code"	char	(3)	not null,
	"phoenix_code"	char	(6),
	"property_id"	numeric	(9)
	"building_name"	char	(24));
commit work;
create unique btree index "bdg_dets_index012" on "bdg_dets" (
	"site_code",
"building_code")
commit work;
create unique btree index "bdg_dets_index123" on "bdg_dets" (
	"building_code",
"site_code")
commit work;
create unique hash index "bdg_dets_index" on "bdg_dets" ("building_code","site_code")
commit work;
create table "jb_costs" (
	"uniquifier"	numeric	(6)	not null primary key
	"docket_number"	char	(6),
	"cost_type"	char	(1),
	"cost_ref"	char	(30),
	"cost"	amount	(8)
commit work;
create table "level_menu" (
	"form_nam"	char	(10)	not null primary key,
	"lev_attach_1"	char	(1),
	"lev_attach_2"	char	(1),
	"lev_attach_3"	char	(1),
	"lev_attach_4"	char	(1),
	"lev_attach_5"	char	(1),
	"lev_attach_6"	char	(1),
	"lev_attach_7"	char	(1));
commit work;
create btree index "level_menu_index001" on "level_menu" (
"form_nam")
commit work;
create unique hash index "level_menu_index" on "level_menu" ("form_nam")
commit work;
create table "trans_log" (
	primary key ("capital_asset_code","capital_sub_asset_no","run_type"),
	"capital_asset_code"	char	(21)	not null,
	"capital_sub_asset_no"	numeric	(4)	not null
	"run_type"	numeric	(1)	not null
	"transfer_date"	huge date
commit work;
create unique hash index "trans_log_index" on "trans_log" ("capital_asset_code","capital_sub_asset_no","run_type")
commit work;
create table "walk_tmp" (
	"sequence_number"	numeric	(6)	not null primary key
	"capital_asset_code"	char	(21),
	"capital_sub_asset_no"	numeric	(4)
	"notes"	char	(50),
	"purchase_price"	huge amount
	"indexed_replacement_cost"	huge amount
	"dep_int_this_per"	huge amount
	"new_val_fld"	char	(25),
	"old_val_fld"	char	(25),
	"transaction_type"	char	(3),
	"division"	char	(4),
	"asset_group"	char	(3),
	"account_code"	char	(4),
	"cap_chgs_centre"	char	(10),
	"cap_chgs_account"	char	(10),
	"serv_code"	char	(3));
commit work;
create unique hash index "walk_tmp_index" on "walk_tmp" ("sequence_number")
commit work;
create table "dist_plan" (
	"property_id"	numeric	(9)	not null primary key
	"airfield_nearby"	char	(1),
	"anct_monument"	char	(1),
	"arch_interest"	char	(1),
	"conserv_area"	char	(1),
	"date_adopted"	huge date
	"dist_adopt_plan"	char	(1),
	"educ_policy"	char	(1),
	"emp_area_spec_res"	char	(1),
	"flood_plain"	char	(1),
	"green_belt"	char	(1),
	"green_settle"	char	(1),
	"implic_detail_1"	text
	"l_conserv_area"	char	(1),
	"l_develop_area"	char	(1),
	"level_1_code"	char	(20),
	"level_2_code"	char	(20),
	"level_3_code"	char	(20),
	"level_4_code"	char	(20),
	"level_5_code"	char	(20),
	"level_6_code"	char	(20),
	"level_7_code"	char	(20),
	"level_number"	numeric	(1)
	"nature_reserve"	char	(1),
	"o_head_lines"	char	(1),
	"o_nat_beau_area"	char	(1),
	"other_desc"	text
	"other_policy"	char	(1),
	"p_build_policy"	char	(1),
	"plan_title"	text
	"rec_policy"	char	(1),
	"regional_park"	char	(1),
	"res_area_spec_res"	char	(1),
	"rural_area"	char	(1),
	"rural_settle"	char	(1),
	"sewers_below"	char	(1),
	"shop_policy"	char	(1),
	"site_implic"	char	(1),
	"soc_policy"	char	(1),
	"specif_settle"	char	(1),
	"sssi"	char	(1),
	"tour_policy"	char	(1),
	"town_plan"	char	(1),
	"town_policy"	char	(1),
	"trans_policy"	char	(1),
	"tree_pres_order"	char	(1),
	"util_policy"	char	(1),
	"waste_policy"	char	(1),
	"oil_line"	char	(1));
commit work;
create btree index "dist_plan_index001" on "dist_plan" (
"property_id")
commit work;
create unique hash index "dist_plan_index" on "dist_plan" ("property_id")
commit work;
create table "trans_srv" (
	"asset_group"	char	(3)	not null primary key,
	"serv_code"	char	(3));
commit work;
create unique hash index "trans_srv_index" on "trans_srv" ("asset_group")
commit work;
create table "trans_acc" (
	primary key ("asset_group","detail_or_contra"),
	"asset_group"	char	(3)	not null,
	"detail_or_contra"	char	(1)	not null,
	"account"	char	(4));
commit work;
create unique hash index "trans_acc_index" on "trans_acc" ("asset_group","detail_or_contra")
commit work;
create table "ap_dets" (
	primary key ("cap_asset_code","cap_asset_sub","division","management_unit","cost_centre","account_code","donated"),
	"cap_asset_code"	char	(21)	not null,
	"cap_asset_sub"	numeric	(4)	not null
	"division"	char	(4)	not null,
	"management_unit"	char	(4)	not null,
	"cost_centre"	char	(4)	not null,
	"account_code"	char	(15)	not null,
	"percentage"	amount	(3)
	"donated"	char	(1)	not null);
commit work;
create btree index "ap_dets_index159" on "ap_dets" (
	"cap_asset_code",
"cap_asset_sub")
commit work;
create unique hash index "ap_dets_index" on "ap_dets" ("cap_asset_code","cap_asset_sub","division","management_unit","cost_centre","account_code","donated")
commit work;
create table "ap_dels" (
	primary key ("capital_asset_code","capital_sub_asset_code","division","management_unit","cost_centre","account_code","donated"),
	"capital_asset_code"	char	(21)	not null,
	"capital_sub_asset_code"	numeric	(4)	not null
	"division"	char	(4)	not null,
	"management_unit"	char	(4)	not null,
	"cost_centre"	char	(4)	not null,
	"account_code"	char	(15)	not null,
	"percentage"	amount	(3)
	"donated"	char	(1)	not null);
commit work;
create unique hash index "ap_dels_index" on "ap_dels" ("capital_asset_code","capital_sub_asset_code","division","management_unit","cost_centre","account_code","donated")
commit work;
create view formacc as
select usr_acc."profile_code",usr_acc."form_nam",formdef."menu_text"
       from usr_acc, formdef  
       where (usr_acc."form_nam" = formdef."form_nam") ;
commit work;
create view cap_mu as
select ca_dets."acceptance_date",ca_dets."account_code",ca_dets."apportionment_count",ca_dets."asset_id",ca_dets."asset_status",ca_dets."capital_asset_code",ca_dets."capital_sub_asset_no",ca_dets."charge_type",ca_dets."cost_centre",ca_dets."depreciation_to_date",ca_dets."division",ca_dets."indexed_replacement_cost",ca_dets."interest",ca_dets."last_charged",ca_dets."management_unit",ca_dets."net_book_val_fld",ca_dets."notes",ca_dets."pr_index_type",ca_dets."prev_capital_asset_code",ca_dets."prev_capital_sub_asset_no",ca_dets."property_id",ca_dets."purchase_price",ca_dets."purchase_type",ca_dets."remaining_life",ca_dets."replacement_date",ca_dets."residual_val_fld",mu_dets."address_line_1",mu_dets."address_line_2",mu_dets."address_line_3",mu_dets."address_line_4",mu_dets."committee_or_division",mu_dets."descript",mu_dets."locat",mu_dets."manager_name",mu_dets."telephone_ext",mu_dets."telephone_no"
       from ca_dets, mu_dets    
       where (ca_dets."management_unit" = mu_dets."management_unit") ;
commit work;
create view dv_mu_bc as
select div_dets."committee_or_division",div_dets."descript",mu_dets."management_unit",bc_dets."cost_centre_code"
       from bc_dets, div_dets, mu_dets    
       where (div_dets."committee_or_division" = mu_dets."committee_or_division")  
       and (mu_dets."committee_or_division" = bc_dets."committee_or_division")  
       and (mu_dets."management_unit" = bc_dets."management_unit") ;
commit work;
