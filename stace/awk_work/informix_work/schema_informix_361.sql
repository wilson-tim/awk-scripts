-- Pharaoh 3.61 & JSB 
-- Mon Apr 9 16:06:55 2001
--
-- This is for a database created with:
-- creatdb -dpharaoh -vvol0 -Ovollen=8388608 -Ofiletype=regular -Opreallocate
--         -Odesc='Pharaoh Database'
-- (The above two lines are written as one.) This creates a database with
-- a preallocated root partion of 8MB, which is about twice the size required
-- to hold the pharaoh database description.
--
-- CHANGES:
-- Date      : Table      - Description
-- 19/12/2000: ca_dets    - added field "notes_extra" char (50) 
-- 19/12/2000: ca_dels    - added field "notes_extra" char (50) 
-- 16/02/2001: ph_hist    - added field "reason_for_delay" char (24)
-- 19/02/2001: ol_dets    - changed field "val_fld_received" amount (8) 
--                        - configuration (display (10,2)) to
--                        - huge amount configuration (display (14,2))
-- 19/02/2001: ol_dets    - changed field "prev_years_exp" amount (8) 
--                        - configuration (display (10,2)) to
--                        - huge amount configuration (display (14,2))
-- 19/02/2001: cd_dets    - changed field "purchase_ordno" char (8) to
--                        - numeric (8) configuration (display (9))
-- 06/03/2001: nhs_sup    - added table nhs_sup
-- 09/04/2001: pm_job     - added field "suspend" char (1)
-- 11/05/2001: ALL TABLES - added in the description line the module each table
--                        - is associated with
-- 14/05/2001: pm_safety_permit - New table created as part of 3.6 upgrade 
--                                Item 3.
-- 14/05/2001: cw_safety_permit - New table created as part of 3.6 upgrade 
--                                Item 3.
-- 14/05/2001: ph_safety_permit - New table created as part of 3.6 upgrade 
--                                Item 3.
-- 17/05/2001: ph_hist    - added field "safety_permit_yn" char (1)
-- 17/05/2001: ol_dets    - added field "vat_est_cost" amount (8)
--                        - configuration (display (10,2))
-- 05/06/2001: cw_job     - added field "dckt_iss_yn" char (1)
-- 05/06/2001: pj_dets    - added field "programme_est" huge amount
--                        - configuration (display (18,2))
-- 05/06/2001: bu_rec     - added field "budget_group" char (4)
-- 11/06/2001: control    - added field "accruals_entered_yn" char (1)
-- 08/10/2001: grn_dets   - changed field "invoice_number" char (12) to
--                        - char (18)
-- 08/10/2001: fx_dets    - changed field "invoice_number" char (12) to
--                        - char (18)
-- 29/10/2001: pj_dets    - added field "job_sponsor"   char    (8)
-- 31/10/2001: ph_hist    - added field "time_reported" time
--
--
create database '//scodev/u1/pharaoh/pharaoh_test/data_live';

create table ac_dets (
	account_code	char	(15)	not null primary key,
	descript	char	(24));

create table ac_type (
	access_code	char	(1)	not null primary key,
	descript	char	(24));

create table add_inf (
	asset_id	char	(6)	not null primary key,
	descript_1	char	(50),
	descript_2	char	(50),
	descript_3	char	(50),
	descript_4	char	(50),
	descript_5	char	(50),
	descript_6	char	(50),
	descript_7	char	(50));

create table aliases (
	alias_code	char	(30)	not null,
	system_type	char	(3)	not null,
	trim_descript	char	(50),
	primary key (alias_code,system_type));

create table hrs_wrkd (
	uniquifier	serial (1)	not null primary key,
	clock_card_no	char	(6),
	date_recorded	 date,
	activity_code	char	(4),
	entered_date	 date,
	entered_time	datetime hour to minute,
	docket_number	char	(6),
	hours	money	(5),
	datetime hour to minute_factor	money	(4),
	entered_by	char	(8),
	team_id	char	(6),
	rep_category	integer

create table cost_hist (
	uniquifier	integer	not null,
	docket_number	char	(6)	not null,
	cost_type	char	(1),
	cost_ref	char	(30),
	cost	money	(8)
	primary key (uniquifier,docket_number));

create table as_costs (
	asset_id	char	(6)	not null,
	year	char	(4)	not null,
	site	char	(3),
	building_code	char	(3),
	locat_code	char	(6),
	management_unit	char	(4),
	asset_number	char	(6),
	sub_asset_number	char	(3),
	hours_ytd	money	(7),
	labour_costs_ytd	money	(9),
	mat_costs_ytd	money	(9),
	purch_costs_ytd	money	(9),
	contr_costs_ytd	money	(9)
	primary key (asset_id,year));

create table control (
	current_pm_year	char	(4)	not null primary key,
	last_docket_no	char	(6),
	curr_fin_year	char	(4),
	curr_fin_period	integer,
	dte_last_per_end	 date,
	tol_pos_var_perc	money	(5),
	tol_neg_var_perc	money	(5),
	default_inv_addr	char	(8),
	control_acc_code	char	(15),
	write_off_acc	char	(15),
	stores_issue_acc	char	(15),
	invy_stock_type	char	(1),
	last_asset_id	char	(6),
	last_pm_job_id	char	(6),
	last_phist_id	char	(6),
	docket_type	char	(1),
	l_use_login	char	(1),
	n_use_login	char	(1),
	s_use_login	char	(1),
	p_use_login	char	(1),
	stock_asset_id	char	(6),
	jobbing_limit	money	(9),
	default_spooler	char	(20),
	def_trade	char	(1),
	def_job_type	char	(2),
	def_cost_centre	char	(4),
	def_account_code	char	(15),
	allowed_backdate	integer,
	mod_date_time	char	(1),
	modify_priority	char	(1),
	last_week_trans	integer,
	last_cw_job_id	char	(6),
	system_type	char	(3),
	mand_projects	char	(1),
	last_proj_code	char	(6),
	company_name	char	(35),
	adjust_budgets	char	(1),
	accruals_yn	char	(1),
	link_lnp_sites	char	(1),
	ac_transfer_flag	char	(1),
	gen_asset_ids	char	(1),
	stand_work_hrs	money	(4),
	hoc_percentage	money	(5),
	hol_percentage	money	(5),
	perform_man	char	(1),
	validate_cc_ac	char	(1),
	last_capital_asset_tx_no	integer,
	days_lag	integer,
	county	char	(30),
	stat_bar_mode	char	(1),
	department	char	(4),
	division	char	(4),
	business_unit	char	(4),
	link_ao_to_ca	char	(1),
	accruals_entered_yn	char	(1));

create table as_spare (
	asset_id	char	(6)	not null,
	stock_code	char	(10)	not null,
	descript_1	char	(40),
	descript_2	char	(40),
	primary key (asset_id,stock_code));

create table oh_dets (
	purchase_req_no	integer	not null primary key,
	order_number	integer,
	order_date	 date,
	order_desc	char	(40),
	special_instrs	char	(40),
	validated_ref	char	(8),
	validated_date	 date,
	authorised_ref	char	(8),
	date_authorised	 date,
	purch_req_date	 date,
	supplier_code	char	(8),
	delivery_address	char	(8),
	invoice_address	char	(8),
	print_yn_flag	char	(1),
	financial_year	char	(4),
	order_status	char	(1),
	stock_locat	integer,
	order_type	char	(1),
	order_or_credit	char	(1),
	cost_centre	char	(4),
	management_unit	char	(4),
	financial_period	integer,
	orig_order_no	char	(8));

create table au_limit (
	contract_type	char	(3)	not null,
	grade	char	(3)	not null,
	maximum_val_fld	money	(9),
	minimum_val_fld	money	(9)
	primary key (contract_type,grade));

create table auth_grd (
	auth_grade	char	(3)	not null primary key,
	descript	char	(24));

create table std_jobs (
	standard_job_id	char	(12)	not null primary key,
	grade_1	char	(3),
	quantity_1	integer,
	grade_2	char	(3),
	quantity_2	integer,
	grade_3	char	(3),
	quantity_3	integer,
	grade_4	char	(3),
	quantity_4	integer,
	trade_code	char	(1),
	safety_permit	char	(1),
	standard_hours	money	(5),
	descript_1	char	(50),
	descript_2	char	(50),
	descript_3	char	(50),
	descript_4	char	(50),
	descript_5	char	(50),
	descript_6	char	(50),
	descript_7	char	(50),
	external_descript	char	(11));

create table bld_appt (
	site_code	char	(3)	not null,
	building_code	char	(3)	not null,
	occupy_dept	char	(3)	not null,
	percentage	money	(5)
	primary key (site_code,building_code,occupy_dept));

create table occ_dept (
	occ_department	char	(3)	not null primary key,
	occ_descript	char	(24));

create table fin_pers (
	period	char	(6)	not null primary key,
	start_date	 date,
	end_date	 date,
	minimus		money,
	charges_run_date	 date,
	index_y_or_n	char	(1),
	no_of_periods	integer	not null

create table doc_type (
	document_type	char	(2)	not null primary key,
	descript	char	(24),
	minimum_val_fld	integer,
	maximum_val_fld	integer,
	last_used_number	integer,
	warning_level	integer,
	external_code	char	(8));

create table as_locs (
	identifier	char	(10)	not null,
	asset_id	char	(6)	not null,
	primary key (identifier,asset_id));

create table calendar (
	calendar_date	 date	not null primary key,
	calendar_day	char	(3),
	start_time	datetime hour to minute,
	hours_worked	money	(4)

create table cc_dets (
	clock_card_no	char	(6)	not null primary key,
	grade	char	(3),
	cost_centre	char	(4),
	workshop	char	(3),
	trade	char	(1),
	basic_hours	money	(5),
	name	char	(24),
	team_id	char	(6),
	date_joined	 date,
	date_left	 date

create table perm_plan (
	property_id	integer	not null,
	plan_ref_code	char	(20)	not null,
	descript	text,
	granted_date	 date,
	rescind_date	 date,
	perm_stat	char	(1),
	submit_date	 date
	primary key (property_id,plan_ref_code));

create table blck_appt (
	property_id	integer	not null,
	block_ref	char	(2)	not null,
	department	char	(4)	not null,
	division	char	(4)	not null,
	business_unit	char	(4)	not null,
	apport_percent	money	(6),
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer
	primary key (property_id,block_ref,department,division,business_unit));

create table lse_o_acq (
	property_id	integer	not null,
	seq_no	integer	not null,
	deed_packet_ref	char	(12)	not null,
	record_type	char	(4)	not null,
	type_flag	char	(1)	not null,
	acq_app_sale_date	 date	not null,
	acreage	float	(64),
	area_other	float	(64),
	expiry_date	 date,
	initial_capital	integer,
	secondary_terr_ref	char	(7),
	val_in	integer,
	yearly_rate	integer
	primary key (property_id,seq_no,deed_packet_ref,record_type,type_flag,acq_app_sale_date));

create table int_rate (
	int_type	char	(2)	not null,
	fin_year	char	(4)	not null,
	descript	char	(24),
	interest	money	(6)
	primary key (int_type,fin_year));

create table ca_dets (
	capital_asset_code	char	(21)	not null,
	capital_sub_asset_no	integer	not null,
	notes	char	(50),
	charge_type	char	(6),
	pr_index_type	char	(3),
	purchase_type	char	(1),
	acceptance_date	 date,
	replacement_date	 date,
	remaining_life	integer,
	last_charged	char	(6),
	purchase_price		money,
	indexed_replacement_cost		money,
	depreciation_to_date		money,
	net_book_val_fld		money,
	interest		money,
	division	char	(4),
	management_unit	char	(4),
	cost_centre	char	(4),
	account_code	char	(15),
	asset_id	char	(6),
	property_id	integer,
	prev_capital_asset_code	char	(21),
	int_type	char	(2),
	prev_capital_sub_asset_no	integer,
	asset_status	char	(2),
	residual_val_fld		money,
	apportionment_count	integer,
        notes_extra char    (50),
	primary key (capital_asset_code,capital_sub_asset_no));

create table ch_type (
	charge_code	char	(6)	not null primary key,
	descript	char	(24),
	classification	char	(1),
	life	integer,
	depreciation_type	char	(1),
	asset_group	char	(3),
	basis_of_valuation	char	(24));

create table con_det (
	contract_code	char	(6)	not null primary key,
	descript_1	char	(50),
	descript_2	char	(50),
	descript_3	char	(50),
	descript_4	char	(50),
	descript_5	char	(50),
	descript_6	char	(50),
	descript_7	char	(50));

create table pw_dets (
	usr_code	char	(20)	not null primary key,
	descript	byte);

create table as_group (
	group_code	char	(3)	not null primary key,
	descript	char	(24),
	cost_centre	char	(4),
	account_code	char	(15));

create table ct_type (
	contract_type	char	(3)	not null primary key,
	descript	char	(24),
	auth_required	char	(1));

create table cw_dets (
	cw_dets_job_id	char	(6)	not null primary key,
	detail_1	char	(50),
	detail_2	char	(50),
	detail_3	char	(50),
	detail_4	char	(50),
	detail_5	char	(50),
	detail_6	char	(50),
	detail_7	char	(50));

create table ch_hist (
	cap_ass_code	char	(21)	not null,
	cap_ass_sub	integer	not null,
	charge_period	char	(6)	not null,
	ind_rep_cost		money,
	residual_val_fld		money,
	dep_this_per		money,
	int_this_per		money,
	dep_to_date		money,
	asset_group	char	(3),
	primary key (cap_ass_code,cap_ass_sub,charge_period));

create table wk_teams (
	team_id	char	(6)	not null primary key,
	descript	char	(24),
	finalised_week	char	(7),
	overtime_target	money	(5),
	leave_target	money	(5),
	sick_target	money	(5),
	absence_target	money	(5),
	divert_target	money	(5),
	wait_target	money	(5),
	travel_target	money	(5),
	available_target	money	(5),
	missing_target	money	(5),
	unassigned_target	money	(5),
	spent_target	money	(5),
	standard_target	money	(5),
	actual_target	money	(5),
	cost_target	money	(5),
	productivity_target	money	(5),
	measured_target	money	(5)

create table ass_con (
	asset_id	char	(6)	not null,
	contract_code	char	(6)	not null,
	primary key (asset_id,contract_code));

create table activity (
	activity_code	char	(4)	not null primary key,
	descript	char	(24),
	reporting_category	integer,
	payment_factor	money	(5),
	attached_to_job	char	(1),
	paid_time	char	(1),
	attendance_activity	char	(1),
	cost_centre	char	(4),
	account_code	char	(15));

create table ap_hist (
	capital_asset_code	char	(21)	not null,
	capital_sub_asset_code	integer	not null,
	effective_date	 date	not null,
	division	char	(4),
	management_unit	char	(4),
	cost_centre	char	(4),
	account_code	char	(15),
	percentage	money	(3),
	donated	char	(1),
	primary key (capital_asset_code,capital_sub_asset_code,effective_date));

create table cx_dets (
	sequence_number	serial (1)	not null primary key,
	capital_asset_code	char	(21),
	capital_sub_asset_code	integer,
	transaction_date	 date,
	transaction_time	datetime hour to minute,
	originator	char	(15),
	transaction_type	char	(3),
	old_val_fld	char	(25),
	new_val_fld	char	(25),
	reason	char	(24),
	division	char	(6),
	management_unit	char	(4),
	cost_centre	char	(4),
	account_code	char	(15),
	effective_date	 date,
	effective_period	char	(6));

create table b_drc_dets (
	property_id	integer	not null primary key,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	asset_category	char	(2),
	grs_int_flr_area	integer,
	asset_value	integer,
	age_of_block	integer,
	life_of_block	integer,
	condition_of_block	char	(4),
	eco_obs_factor	integer,
	func_obs_factor	integer,
	environment_factor	integer,
	drc_for_block	integer,
	eff_val_date	 date,
	date_val_carr_out	 date,
	valuer_code	char	(4));

create table hlp_info (
	hlp_level	char	(1)	not null,
	frm_name	char	(44)	not null,
	fld_name	char	(44)	not null,
	instance	integer	not null,
	hlp_line	char	(40),
	primary key (hlp_level,frm_name,fld_name,instance));

create table cd_dets (
	contract_code	char	(6)	not null primary key,
	budget	integer,
	purchase_ordno	integer,
	descript	char	(24),
	start_date	 date,
	period_months	integer,
	termin_period	integer,
	supplier_code	char	(8),
	renewal_date	 date,
	payment_method	char	(2),
	sup_contract_ref	char	(8),
	contract_type	char	(3),
	live_flag	char	(1),
	date_completed	 date

create table as_invy (
	asset_id	char	(6)	not null,
	inv_code	char	(8)	not null,
	descript	char	(24),
	serial_no	char	(20),
	quantity	integer,
	price	money	(9)
	primary key (asset_id,inv_code));

create table department (
	dept_code	char	(5)	not null primary key,
	dept_descript	char	(40));

create table deployment (
	depl_code	char	(1)	not null primary key,
	depl_descript	char	(40));

create table pu_type (
	purchase_type	char	(1)	not null primary key,
	descript	char	(24));

create table formdef (
	menu_name	char	(10)	not null,
	form_nam	char	(10)	not null,
	position	integer,
	available	char	(1),
	menu_text	char	(35),
	primary key (menu_name,form_nam));

create table blck_dets (
	property_id	integer	not null,
	block_ref	char	(2)	not null,
	approx_flag	char	(1),
	area_x_cost	integer,
	bcis_index	char	(5),
	block_usage1	char	(5),
	block_usage2	char	(5),
	block_usage3	char	(5),
	block_usage4	char	(5),
	block_usage5	char	(5),
	block_usage6	char	(5),
	block_usage_all	char	(42),
	construct_year	char	(4),
	demolition_cost	integer,
	ext_works_ind	money	(7),
	fees_index	money	(7),
	fire_rein_val	integer,
	g_ext_b_area_m	integer,
	g_int_flr_sq_m		money,
	handover_date	 date,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	listed_build	char	(1),
	listed_grade	char	(5),
	listing_desc	text,
	l_survey_date	 date,
	nxt_survey_date	 date,
	max_flrs_no	integer,
	net_flr_meas	char	(1),
	net_flr_sq_m1	integer,
	net_flr_sq_m2	integer,
	net_flr_sq_m3	integer,
	net_flr_sq_m4	integer,
	net_flr_sq_m5	integer,
	net_flr_sq_m6	integer,
	net_flr_sq_m7	integer,
	net_flr_sq_m8	integer,
	net_int_area		money,
	net_let_area		money,
	no_of_rooms	integer,
	number_of_floors	integer,
	overall_blck_cond	char	(4),
	room_count_src	char	(1),
	survey_source	char	(1),
	temp_construct	char	(1),
	usable_rms_no_1	integer,
	usable_rms_no_2	integer,
	usable_rms_no_3	integer,
	usable_rms_no_4	integer,
	usable_rms_no_5	integer,
	usable_rms_no_6	integer,
	usable_rms_no_7	integer,
	usable_rms_no_8	integer,
	total_usable_rms	integer,
	total_area_rms	integer,
	gross_int_sq_m1	integer,
	gross_int_sq_m2	integer,
	gross_int_sq_m3	integer,
	gross_int_sq_m4	integer,
	gross_int_sq_m5	integer,
	gross_int_sq_m6	integer,
	gross_int_sq_m7	integer,
	gross_int_sq_m8	integer,
	remaining_life	integer,
	const_type	char	(4),
	l_upgrade_date	 date,
	upgrade_text	text,
	blck_text	text,
	disabled_access	text,
	net_space_sqm		money,
	net_int_sqm		money,
	bal_area_sqm		money,
	other_area		money,
	heated_vol_cum		money,
	l_mkt_valuation		money,
	present_date	 date,
	p_mrkt_value		money,
	potential_date	 date,
	fire_date	 date,
	l_ins_renw_date	 date,
	demolition_date	 date,
	other_val		money,
	g_ext_flr_sq_m		money,
	room_area_sqm		money,
	gross_vol_cu_m		money,
	other_date	 date
	primary key (property_id,block_ref));

create table setup (
	dummy	char	(1)	not null primary key,
	usr	char	(1),
	initialise	text,
	err_message	text

create table plan_appl (
	property_id	integer	not null,
	sequence_no	integer	not null,
	decision_date	 date,
	descript	text,
	granted_flag	char	(1),
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	planning_applic	char	(20),
	plan_stat	char	(1),
	submit_date	 date,
	temp_or_perm	char	(1),
	primary key (property_id,sequence_no));

create table rep_cat (
	reporting_cat_id	integer	not null primary key,
	descript	char	(24));

create table ft_type (
	fault_code	char	(3)	not null primary key,
	descript	char	(24));

create table ph_j_det (
	job_dets_id	char	(6)	not null primary key,
	detail_1	char	(50),
	detail_2	char	(50),
	detail_3	char	(50),
	detail_4	char	(50),
	detail_5	char	(50),
	detail_6	char	(50),
	detail_7	char	(50));

create table fye_dets (
	financial_year	char	(4)	not null primary key,
	descript	char	(24),
	no_periods_in_yr	integer

create table gd_type (
	grade_code	char	(3)	not null primary key,
	descript	char	(24),
	hourly_rate	money	(4)

create table rgn_dets (
	return_number	integer	not null primary key,
	return_date	 date,
	financial_period	integer,
	financial_year	char	(4),
	returned_from	char	(8),
	returned_to	char	(8),
	order_number	integer,
	order_line_no	integer,
	credit_note_no	char	(12),
	grn_number	char	(10),
	return_quantity	integer,
	return_val_fld	money	(9),
	credit_qty	integer,
	credit_val_fld	money	(9),
	locat	integer,
	credit_date	 date,
	document_type	char	(2),
	document_number	integer,
	credit_period	integer,
	credit_year	char	(4),
	vat_val_fld	money	(9),
	entered_by	char	(8),
	entered_on	 date,
	include_in_batch	char	(1),
	batch_number	integer,
	account_code	char	(15),
	cost_centre	char	(4));

create table pi_index (
	index_code	char	(3)	not null,
	history_number	integer	not null,
	descript	char	(24),
	last_updated	 date,
	old_val_fld	money	(6),
	new_val_fld	money	(6),
	effective_date	 date
	primary key (index_code,history_number));

create table jb_type (
	job_type_code	char	(2)	not null primary key,
	descript	char	(24));

create table jc_type (
	job_category	char	(2)	not null primary key,
	descript	char	(24));

create table scan_dckt (
	docket_no	char	(6)	not null primary key,
	trade	char	(1),
	delay_date_comp	 date,
	detail_1	char	(50),
	detail_2	char	(50),
	detail_3	char	(50),
	detail_4	char	(50),
	detail_5	char	(50),
	detail_6	char	(50),
	detail_7	char	(50),
	batch_number	integer

create table ex_type (
	exception_status	char	(2)	not null primary key,
	descript	char	(24));

create table ln_type (
	order_line_stat	char	(1)	not null primary key,
	descript	char	(24));

create table lo_dets (
	stock_loc_code	integer	not null primary key,
	cost_centre	char	(4),
	b_fwd_grn_val_fld	money	(9),
	b_fwd_grn_qty	integer,
	descript	char	(24),
	address_code	char	(8));

create table loc_dets (
	locat_code	char	(6)	not null,
	site_code	char	(3)	not null,
	building_code	char	(3)	not null,
	descript	char	(24),
	primary key (locat_code,site_code,building_code));

create table ls_dets (
	stock_code	char	(10)	not null,
	stock_loc_code	integer	not null,
	b_fwd_arch_val	money	(8),
	grn_counter	integer,
	b_fwd_wip_qty	integer,
	b_fwd_wip_val	money	(8),
	stock_balance	integer,
	min_stock_level	integer,
	max_stock_level	integer,
	re_order_level	integer,
	on_order_balance	integer,
	on_order_ord_no	integer,
	date_last_issued	 date,
	usage_this_year	integer,
	his_annual_usage	integer,
	bin_ref_fld	char	(10),
	brought_fwd_qty	integer,
	brought_fwd_val	money	(8),
	stock_val_fld	money	(9),
	b_fwd_arch_qty	integer,
	quotation_requested	char	(1),
	primary key (stock_code,stock_loc_code));

create table main_pln (
	main_plan_code	char	(2)	not null primary key,
	descript	char	(24));

create table ag_type (
	agree_type	char	(1)	not null primary key,
	descript	char	(30));

create table nam_adds (
	name_and_address	char	(8)	not null primary key,
	discount	char	(1),
	name	char	(30),
	address_line_1	char	(30),
	address_line_2	char	(30),
	address_line_3	char	(30),
	address_line_4	char	(30),
	telephone_no	char	(15),
	telex_no	char	(15),
	fax_number	char	(15),
	contact_name	char	(24),
	supplier_type	char	(2),
	delivery_charge	char	(1),
	lead_time	integer,
	buyer_text_1	char	(40),
	buyer_text_2	char	(40),
	extension	char	(6),
	buyer_text_3	char	(40),
	buyer_text_4	char	(40),
	buyer_text_5	char	(40),
	buyer_text_6	char	(40),
	buyer_text_7	char	(40),
	buyer_text_8	char	(40),
	payment_indic	char	(2),
	apprv_contractor	char	(1),
	on_cg_apprv_list	char	(1),
	date_approved	 date,
	min_order_val_fld	integer,
	max_order_val_fld	integer,
	post_code	char	(15),
	supplier_type2	char	(2),
	supplier_type3	char	(2),
	supplier_type4	char	(2),
	supplier_type5	char	(2),
	supplier_type6	char	(2));

create table mu_dets (
	management_unit	char	(4)	not null primary key,
	descript	char	(24),
	address_line_1	char	(25),
	address_line_2	char	(25),
	address_line_3	char	(25),
	address_line_4	char	(15),
	telephone_no	char	(15),
	telephone_ext	char	(8),
	manager_name	char	(24),
	locat	char	(16),
	committee_or_division	char	(4));

create table pj_sched (
	project_code	char	(6)	not null,
	line_number	integer	not null,
	target_date	 date,
	forecast_date	 date,
	actual_date	 date,
	percent_complete	char	(3),
	primary key (project_code,line_number));

create table ph_w_don (
	work_done_id	char	(6)	not null primary key,
	detail_1	char	(50),
	detail_2	char	(50),
	detail_3	char	(50),
	detail_4	char	(50),
	detail_5	char	(50),
	detail_6	char	(50),
	detail_7	char	(50));

create table os_type (
	order_stat_code	char	(1)	not null primary key,
	descript	char	(24));

create table ot_type (
	order_type_code	char	(1)	not null primary key,
	descript	char	(24));

create table usrdef (
	usr_code	char	(10)	not null primary key,
	locat_code	integer,
	create_n_orders	char	(1),
	create_p_orders	char	(1),
	usr_name	char	(24),
	profile_code	char	(2),
	default_printer	char	(10),
	usr_title	char	(24),
	cw_del_allowed	char	(1),
	pm_del_allowed	char	(1),
	create_l_orders	char	(1),
	create_s_orders	char	(1),
	ord_auth_limit	money	(9),
	usr_auth_grade	char	(3),
	hlp_level	char	(1));

create table ph_hist (
	perm_history_id	char	(6)	not null primary key,
	workshop	char	(3),
	account_code	char	(15),
	asset_id	char	(6),
	site_code	char	(3),
	building_code	char	(3),
	curr_job_file_id	char	(6),
	project_code	char	(6),
	contract_code	char	(6),
	estimated_cost	money	(8),
	frequency	integer,
	management_unit	char	(4),
	contract_type	char	(3),
	trade	char	(1),
	pm_job_no_req_no	char	(6),
	priority_code	char	(2),
	work_type	char	(1),
	docket_no	char	(6),
	ref_fld	char	(12),
	locat_code	char	(6),
	asset_no	char	(6),
	sub_asset_no	char	(3),
	asset_name	char	(24),
	asset_cost_cent	char	(4),
	labour_cost	money	(9),
	materials_cost	money	(9),
	asset_type	char	(6),
	category	char	(2),
	job_type_code	char	(2),
	wrk_done_summary	char	(24),
	week_planned	char	(7),
	date_reported	 date,
	date_to_comp_ex	 date,
	date_act_comp	 date,
	total_actual_hrs	money	(5),
	purchase_cost	money	(9),
	contract_cost	money	(9),
	fault_code	char	(3),
	series	integer,
	charg_cost_cent	char	(4),
	financial_year	char	(4),
	period	integer,
	dorc_flag	char	(1),
	out_of_seq_flag	char	(1),
	status_flag	char	(1),
	wk_cont_time_hrs	money	(5),
	site_code_bt	integer,
	building_code_bt	integer,
	locat_bt1	integer,
	locat_bt2	integer,
	asset_no_bt1	integer,
	asset_no_bt2	integer,
	sub_asset_no_bt	integer,
	allowce_time_hrs	money	(5),
	rev_allow_time	money	(5),
	rev_wk_cont_time	money	(5),
	maintenance_plan	char	(2),
	resp_serv_level	char	(2),
	down_serv_level	char	(2),
	resp_date_plan	 date,
	resp_time_plan	datetime hour to minute,
	comp_date_plan	 date,
	comp_time_plan	datetime hour to minute,
	date_act_resp	 date,
	datetime hour to minute_resp	datetime hour to minute,
	datetime hour to minute_resp_a	money	(4),
	tot_hours_resp	money	(6),
	datetime hour to minute_comp	datetime hour to minute,
	datetime hour to minute_comp_a	money	(4),
	tot_hours_comp	money	(6),
	logged_by	char	(10),
	log_date	 date,
	log_time	datetime hour to minute,
	phoenix_code	char	(6),
	reported_by	char	(24),
        reason_for_delay char (24),
        safety_permit_yn char (1),
       	datetime hour to minute_reported    	datetime hour to minute

create table ph_spare (
	locat_code	integer	not null,
	docket_no	char	(6)	not null,
	stock_no	char	(10)	not null,
	quantity_used	integer,
	cost	money	(9),
	stock_desc_1	char	(40),
	stock_desc_2	char	(40),
	primary key (locat_code,docket_no,stock_no));

create table cc_phist (
	uniquifier	serial (1)	not null primary key,
	clock_card_no	char	(6),
	date_recorded	 date,
	activity_code	char	(4),
	entered_date	 date,
	entered_time	datetime hour to minute,
	hours	money	(5),
	docket_number	char	(6),
	datetime hour to minute_factor	money	(4),
	name	char	(24),
	hourly_rate	money	(4),
	entered_by	char	(8),
	team_id	char	(6),
	rep_category	integer

create table pi_dets (
	payment_indic	char	(2)	not null primary key,
	descript	char	(24));

create table scan_hrs (
	uniquifier	serial (1)	not null primary key,
	clock_card_no	char	(6),
	date_recorded	 date,
	docket_number	char	(6),
	hours	money	(5),
	datetime hour to minute_factor	money	(4),
	batch_number	integer

create table pj_stage (
	line_number	integer	not null primary key,
	descript	char	(24),
	fill_percentage	char	(1));

create table pl_dets (
	pl_name	char	(10)	not null primary key,
	pl_locn	char	(30),
	pl_plen	integer

create table pm_dets (
	pm_dets_job_id	char	(6)	not null primary key,
	detail_1	char	(50),
	detail_2	char	(50),
	detail_3	char	(50),
	detail_4	char	(50),
	detail_5	char	(50),
	detail_6	char	(50),
	detail_7	char	(50));

create table sk_items (
	stock_code	char	(10)	not null primary key,
	stock_class	char	(2),
	abc_class	char	(1),
	descript_1	char	(40),
	descript_2	char	(40),
	stock_type	char	(1),
	ratio_code	char	(3),
	supplier_code_1	char	(8),
	supplier_ref_1	char	(15),
	supplier_code_2	char	(8),
	supplier_ref_2	char	(15),
	supplier_code_3	char	(8),
	supplier_ref_3	char	(15),
	consumable_flag	char	(1),
	altern_stk_code	char	(10),
	date_loaded	 date,
	end_date	 date,
	supp_1_preferred	char	(1),
	supp_2_preferred	char	(1),
	supp_3_preferred	char	(1),
	live_flag	char	(1));

create table pm_spare (
	pm_job_id	char	(6)	not null,
	stock_number	char	(10)	not null,
	quantity	integer,
	cost	money	(9)
	primary key (pm_job_id,stock_number));

create table pr_index (
	price_index_type	char	(3)	not null primary key,
	original_val_fld	integer,
	amended_val_fld	integer,
	date_last_update	 date,
	descript	char	(24));

create table pr_type (
	priority_code	char	(2)	not null primary key,
	descript	char	(24));

create table prj_det (
	project_code	char	(6)	not null primary key,
	descript_1	char	(50),
	descript_2	char	(50),
	descript_3	char	(50),
	descript_4	char	(50),
	descript_5	char	(50),
	descript_6	char	(50),
	descript_7	char	(50));

create table re_type (
	reason_for_delay	char	(1)	not null primary key,
	descript	char	(24));

create table si_dets (
	site_code	char	(3)	not null primary key,
	descript	char	(24));

create table sic_dets (
	ratio_code	char	(3)	not null primary key,
	supply_uom	char	(6),
	issue_uom	char	(6),
	ratio_val_fld	money	(9)

create table helpdesk (
	cw_job_id	char	(6)	not null primary key,
	work_done	char	(40),
	datetime hour to minute_completed	datetime hour to minute,
	date_completed	 date

create table as_dets (
	asset_id	char	(6)	not null primary key,
	down_time	money	(8),
	no_failures	integer,
	hours_run_per_wk	integer,
	repair_time	money	(8),
	start_date	 date,
	bms_ref_fld	char	(8),
	rely_stats_req	char	(1),
	site_code	char	(3),
	building_code	char	(3),
	locat_code	char	(6),
	management_unit	char	(4),
	asset_no	char	(6),
	sub_asset_no	char	(3),
	asset_name	char	(24),
	asset_type	char	(6),
	statutory_item	char	(1),
	manufacturer	char	(8),
	supplier_code	char	(8),
	order_no	integer,
	acceptance_date	 date,
	warranty_expiry	char	(7),
	price	integer,
	serial_no	char	(12),
	model_no	char	(20),
	est_replace_year	char	(4),
	indexed_rep_cost	integer,
	locat_ref	char	(13),
	contract_pm_job	char	(1),
	price_index_type	char	(3),
	cost_centre	char	(4),
	workshop	char	(3),
	del_pm_job_flag	char	(1),
	charg_cost_cent	char	(4),
	account_code	char	(15),
	date_last_comp	 date,
	date_next_due	 date,
	labour_cost_pr	money	(9),
	material_cost_pr	money	(9),
	purchase_cost_pr	money	(9),
	contract_cost_pr	money	(9),
	site_code_bt	integer,
	labour_cost_yt	money	(9),
	building_code_bt	integer,
	locat_bt1	integer,
	locat_bt2	integer,
	asset_no_bt1	integer,
	asset_no_bt2	integer,
	sub_asset_no_bt	integer,
	utilisation_cat	char	(3),
	material_cost_yt	money	(9),
	purchase_cost_yt	money	(9),
	contract_cost_yt	money	(9),
	priority_code	char	(2),
	maintenance_plan	char	(2),
	resp_serv_level	char	(2),
	phoenix_code	char	(6),
	down_serv_level	char	(2));

create table skc_dets (
	class_code	char	(2)	not null primary key,
	descript	char	(24));

create table sla_dets (
	resp_or_down	char	(1)	not null,
	serv_lev_code	char	(2)	not null,
	descript	char	(24),
	datetime hour to minute_in_hours	money	(5),
	elapse_or_work	char	(1),
	hours_or_days	char	(1),
	primary key (resp_or_down,serv_lev_code));

create table sp_type (
	supplier_type	char	(2)	not null primary key,
	descript	char	(24));

create table spares (
	docket_number	char	(6)	not null,
	stock_number	char	(10)	not null,
	locat_code	integer	not null,
	cost	money	(8),
	quantity_used	integer,
	date_issued	 date,
	ident_yn	char	(1),
	primary key (docket_number,stock_number,locat_code));

create table ss_type (
	status_code	char	(1)	not null primary key,
	descript	char	(24));

create table ssu_dets (
	stock_code	char	(10)	not null,
	supplier_code	char	(8)	not null,
	unit_of_supply	char	(6),
	last_inv_date	 date,
	u_price_last_inv	money	(9),
	min_order_qty	integer,
	lead_time	integer,
	carr_del_charges	char	(1),
	text_line_1	char	(40),
	text_line_2	char	(40),
	text_line_3	char	(40),
	text_line_4	char	(40),
	text_line_5	char	(40),
	text_line_6	char	(40),
	text_line_7	char	(40),
	text_line_8	char	(40),
	text_line_9	char	(40),
	text_line_10	char	(40),
	payment_indic	char	(2),
	primary key (stock_code,supplier_code));

create table stk_type (
	stock_type_code	char	(1)	not null primary key,
	pur_account_code	char	(15),
	descript	char	(24));

create table sx_dets (
	transaction_no	integer	not null primary key,
	transaction_type	char	(1),
	trans_no_ref	integer,
	docket_number	integer,
	requisition_no	char	(6),
	job_number	char	(6),
	account_code	char	(15),
	cost_centre	char	(4),
	sx_date	 date,
	sx_time	datetime hour to minute,
	usr	char	(8),
	quantity	integer,
	ref_fld	char	(12),
	order_number	integer,
	order_line_no	integer,
	stock_code	char	(10),
	movement_date	 date,
	stock_loc_code	integer,
	financial_year	char	(4),
	trn_val_fld	money	(8),
	financial_period	integer

create table tec_det (
	asset_id	char	(6)	not null primary key,
	descript_1	char	(50),
	descript_2	char	(50),
	descript_3	char	(50),
	descript_4	char	(50),
	descript_5	char	(50),
	descript_6	char	(50),
	descript_7	char	(50));

create table tn_dets (
	transaction_type	char	(2)	not null primary key,
	transaction_no	integer

create table tr_type (
	trade_code	char	(1)	not null primary key,
	descript	char	(24));

create table usr_acc (
	menu_name	char	(10)	not null,
	form_nam	char	(10)	not null,
	profile_code	char	(2)	not null,
	allow_add	char	(1),
	allow_update	char	(1),
	allow_find	char	(1),
	allow_delete	char	(1),
	primary key (menu_name,form_nam,profile_code));

create table usr_pro (
	profile_code	char	(2)	not null primary key,
	descript	char	(24));

create table wk_done (
	work_done_job_id	char	(6)	not null primary key,
	detail_1	char	(50),
	detail_2	char	(50),
	detail_3	char	(50),
	detail_4	char	(50),
	detail_5	char	(50),
	detail_6	char	(50),
	detail_7	char	(50));

create table wk_nums (
	year	char	(4)	not null,
	week_number	integer	not null,
	week_start	 date,
	week_end	 date
	primary key (year,week_number));

create table ws_type (
	workshop_code	char	(3)	not null primary key,
	descript	char	(24));

create table yr_nums (
	year	char	(4)	not null primary key,
	number_of_weeks	integer

create table prin_func (
	principal_funct	char	(5)	not null primary key,
	descript	char	(24));

create table alt_val (
	property_id	integer	not null primary key,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	asset_category	char	(2),
	basis_of_val	char	(5),
	method_of_val	char	(3),
	area_of_land	float	(64),
	total_value	integer,
	comments	text,
	eff_val_date	 date,
	date_val_carr_out	 date,
	valuer_code	char	(4));

create table districts (
	dist_code	char	(8)	not null primary key,
	dist_descript	char	(40));

create table premises (
	loc_fin_sys_code	char	(7)	not null primary key,
	address_no	char	(4),
	alloc_bus_unit	char	(4),
	alloc_pur_concat	char	(35),
	alloc_depart	char	(4),
	alloc_div	char	(4),
	alloc_hold_com	char	(4),
	alloc_pur_code1	char	(5),
	alloc_pur_code2	char	(5),
	alloc_pur_code3	char	(5),
	alloc_pur_code4	char	(5),
	alloc_pur_code5	char	(5),
	alloc_serv_dept	char	(5),
	alt_premis_desc	char	(40),
	alt_premis_name	char	(40),
	alt_tel_no	char	(20),
	area	float	(64),
	cons_area	char	(1),
	county	char	(20),
	county_usr	char	(8),
	deployment_use	char	(1),
	dist_council_code	char	(8),
	elect_div	char	(3),
	gross_int_floor	integer,
	link_let_id	char	(12),
	link_let_interest	char	(1),
	link_let_seq_no	integer,
	listed_building	char	(5),
	live_flag	char	(1),
	live_flag_date	 date,
	locality	char	(30),
	log_acknowl_date	 date,
	log_issued_date	 date,
	max_hrs_use_pw	money	(6),
	nat_grid_ref	char	(12),
	oth_agree_cap_cl		money,
	oth_agree_cap_stf		money,
	oth_cur_ft_equiv		money,
	oth_cur_ft_staff		money,
	oth_cur_ft_clien		money,
	oth_cur_pt_clien		money,
	oth_cur_pt_staff		money,
	oth_des_cap_cl		money,
	oth_des_cap_stf		money,
	other_cap		money,
	post_code	char	(8),
	premises_notes	text,
	premis_name	char	(40),
	road	char	(30),
	s_serv_team_bound1	char	(1),
	s_serv_team_bound2	char	(2),
	s_serv_team_bound3	char	(1),
	occ_start_date	 date,
	tel_no	char	(20),
	third_pty_occup	char	(8),
	town	char	(25),
	usage_depart	char	(4),
	usage_bus_unit	char	(4),
	usage_code1	char	(5),
	usage_code2	char	(5),
	usage_code3	char	(5),
	usage_code4	char	(5),
	usage_code5	char	(5),
	usage_concat	char	(35),
	usage_division	char	(4),
	usage_manag_com	char	(4),
	usage_serv_dept	char	(5),
	ward	char	(4));

create table bc_dets (
	cost_centre_code	char	(4)	not null primary key,
	descript	char	(24),
	management_unit	char	(4),
	committee_or_division	char	(4));

create table div_dets (
	committee_or_division	char	(4)	not null primary key,
	descript	char	(24));

create table sord_dets (
	standard_code	char	(12)	not null primary key,
	descript_1	char	(40),
	descript_2	char	(40),
	descript_3	char	(40),
	descript_4	char	(40),
	descript_5	char	(40),
	descript_6	char	(40),
	descript_7	char	(40),
	descript_8	char	(40),
	descript_9	char	(40),
	descript_10	char	(40));

create table dec_l_let (
	property_id	integer	not null,
	deed_packet_ref	char	(12)	not null,
	seq_no_let	integer	not null,
	seq_no_this	integer	not null,
	lfs_code	char	(7)	not null,
	interest	char	(1),
	live_flag	char	(1),
	live_flag_date	 date,
	l_lord_ext_yr	char	(4),
	l_lord_int_yr	char	(4),
	tenant_ext_yr	char	(4),
	tenant_int_yr	char	(4),
	primary key (property_id,deed_packet_ref,seq_no_let,seq_no_this,lfs_code));

create table dec_l_own (
	property_id	integer	not null,
	deed_packet_ref	char	(12)	not null,
	sequence_no	integer	not null,
	interest	char	(1),
	live_flag	char	(1),
	live_flag_date	 date,
	l_lord_ext_yr	char	(4),
	l_lord_int_yr	char	(4),
	tenant_ext_yr	char	(4),
	tenant_int_yr	char	(4),
	primary key (property_id,deed_packet_ref,sequence_no));

create table art_works (
	property_id	integer	not null,
	l_f_s_code	char	(7)	not null,
	sequence_no	integer	not null,
	art_category	char	(1),
	artist_name	char	(30),
	condition_code	char	(4),
	condition_desc	text,
	date_created	 date,
	date_visited	 date,
	descript	text,
	dimensions	char	(30),
	grid_ref	char	(12),
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	live_flag	char	(1),
	live_flag_date	 date,
	locat_block	char	(1),
	locat_desc	text,
	obvious_damage	text,
	provenance	text,
	visitor	char	(20),
	work_name	text
	primary key (property_id,l_f_s_code,sequence_no));

create table valuers (
	valuer_code	char	(4)	not null primary key,
	valuer_desc	char	(50));

create table asset_pro (
	property_id	integer	not null primary key,
	adverse_use_det	text,
	adverse_use_oth	char	(1),
	boundary_issue	char	(1),
	conclusion	char	(1),
	date_commenced	 date,
	date_inspected	 date,
	date_resolved	 date,
	encroachment	char	(1),
	hcc_land_misuse	char	(1),
	hcc_plan_misuse	char	(1),
	how_resolved	text,
	illegal_dumping	text,
	inspected_by	char	(30),
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	overhead_cables	char	(1),
	right_of_way	char	(1),
	rights_of_light	char	(1),
	r_of_way_obstr	char	(1));

create table bcis_dets (
	bcis_code	char	(5)	not null primary key,
	bcis_descript	char	(40),
	cap_acctg_cost	money	(9),
	demolition_perc	money	(7),
	ext_works_perc	money	(7),
	fees_perc	money	(7),
	insurance_cost	money	(9)

create table bcis_dets2 (
	sub_value	integer	not null primary key,
	rebuild_period	integer,
	inflation	money	(5)

create table b_val_dets (
	property_id	integer	not null primary key,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	asset_category	char	(2),
	basis_of_val	char	(5),
	method_of_val	char	(3),
	comments	text,
	block_value	integer,
	eff_val_date	 date,
	date_val_carr_out	 date,
	valuer_code	char	(4));

create table ccouncils (
	ccoun_code	char	(8)	not null primary key,
	ccoun_descript	char	(40));

create table condition (
	condition	char	(4)	not null primary key,
	descript	char	(24));

create table constit (
	constit_code	char	(6)	not null primary key,
	constit_descript	char	(40));

create table construct (
	construct	char	(4)	not null primary key,
	descript	char	(24));

create table disabl (
	property_id	integer	not null primary key,
	alarms_flashing	char	(1),
	danger_signed	char	(1),
	disabled_entry	char	(1),
	disabled_hlp	char	(1),
	disabled_toilet	char	(1),
	doors_open_i_o	char	(1),
	doors_obstructed	char	(1),
	door_width	integer,
	entry_distance	integer,
	frame_openable	char	(1),
	ind_meet_rooms	char	(1),
	int_chg_floors	char	(1),
	int_floor_ramps	char	(1),
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	lift_1_5_area	char	(1),
	lift_present	char	(1),
	light_n_handles	char	(1),
	l_ctrls_braille	char	(1),
	l_ctrls_w_chair	char	(1),
	l_tap_cloak_rms	char	(1),
	l_tap_dble_rms	char	(1),
	map_braille	char	(1),
	no_car_spaces	integer,
	no_dble_entrys	integer,
	no_disabled_wc	integer,
	ramps_h_rail	char	(1),
	routes_coloured	char	(1),
	stair_h_rail	char	(1),
	steps_h_rail	char	(1),
	signs_braille	char	(1),
	signs_visible	char	(1),
	solid_bay_entry	char	(1),
	survey_date	 date,
	voice_message	char	(1),
	wc_alarm	char	(1),
	w_chair_basin	char	(1),
	w_chair_drier	char	(1),
	w_chair_entry	char	(1),
	w_chair_flush	char	(1),
	w_chair_openable	char	(1),
	w_chair_wc	char	(1));

create table deeds (
	property_id	integer	not null,
	deed_packet_ref	char	(12)	not null,
	interest	char	(1)	not null,
	comments	text,
	enc_ben	char	(1),
	hold_committee1	char	(4),
	hold_committee2	char	(4),
	hold_committee3	char	(4),
	hold_committee4	char	(4),
	hold_committee5	char	(4),
	interest_p_a	char	(1),
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	lfs_code	char	(7),
	no_deeds_in_pack	integer,
	owner_quality	char	(10),
	primary key (property_id,deed_packet_ref,interest));

create table schl_dets (
	lfs_code	char	(7)	not null primary key,
	alt_tel_no	char	(20),
	cur_ft_pupils	integer,
	cur_pt_pupils	integer,
	current_ft_staff	integer,
	current_pt_staff	money	(5),
	des_ref_no	char	(5),
	hard_play_area	float	(64),
	h_teacher_name	char	(25),
	hvy_prac_spce_sqm	integer,
	lgt_prac_spce_sqm	integer,
	live_flag	char	(1),
	live_flag_date	 date,
	gen_tch_spce_sqm	integer,
	perm_acc_act_cap	money	(7),
	perm_acc_class_no	integer,
	perm_acc_tch_area	integer,
	perm_acc_tot_area	money	(6),
	play_field_hect	float	(64),
	rec_area_hect	float	(64),
	schl_actual_cap	money	(4),
	schl_potent_cap	money	(4),
	schl_std_add_lim	integer,
	school_category	char	(1),
	school_phone_no	char	(20),
	school_ref_no	char	(4),
	school_type	char	(3),
	sprt_pe_spce_sqm	integer,
	temp_acc_no_rooms	integer,
	temp_acc_tot_area	money	(6),
	temp_act_tch_area	money	(6),
	tot_eq_ft_pupils	money	(7),
	tot_ft_eq_staff	money	(6)

create table elect_divs (
	elect_code	char	(3)	not null primary key,
	elect_descript	char	(40));

create table enc_ben (
	enc_or_ben	char	(1)	not null,
	enc_ben_code	char	(2)	not null,
	enc_ben_descript	char	(30),
	primary key (enc_or_ben,enc_ben_code));

create table fyi_lines (
	frm_name	char	(10)	not null,
	fyi_identifier	char	(28)	not null,
	fyi_line	char	(77),
	primary key (frm_name,fyi_identifier));

create table rev_lsoth (
	property_id	integer	not null,
	deed_packet_ref	char	(12)	not null,
	seq_no_this	integer	not null,
	agreed_rental	integer,
	live_flag	char	(1),
	live_flag_date	 date,
	notice_due_date	 date,
	notice_quit_date	 date,
	rev_term_date	 date,
	review_date	 date,
	review_terminate	char	(1),
	record_type	char	(1),
	primary key (property_id,deed_packet_ref,seq_no_this));

create table ol_dets (
	purchase_req_no	integer	not null,
	order_line_no	integer	not null,
	unit_of_supply	char	(6),
	job_id	char	(6),
	job_type	char	(1),
	order_number	integer,
	originator_ref	char	(8),
	total_est_cost	money	(8),
	rem_commitment	money	(8),
	expenditure	money	(8),
	contrt_quote_ref	char	(6),
	date_originated	 date,
	validated_ref	char	(8),
	date_validated	 date,
	financial_year	char	(4),
	account_code	char	(15),
	cost_centre	char	(4),
	requisition_no	char	(6),
	exp_delivery	 date,
	line_status	char	(1),
	exception_status	char	(2),
	part_number	char	(10),
	part_price	money	(8),
	qty_ordered	integer,
	qty_rec_to_date	integer,
	qty_invoiced	integer,
	percent_complete	integer,
	percent_invoiced	integer,
	desc_line_1	char	(40),
	desc_line_2	char	(40),
	desc_line_3	char	(40),
	desc_line_4	char	(40),
	desc_line_5	char	(40),
	desc_line_6	char	(40),
	desc_line_7	char	(40),
	desc_line_8	char	(40),
	desc_line_9	char	(40),
	desc_line_10	char	(40),
	supplier_ref	char	(15),
	management_unit	char	(4),
	financial_period	integer,
	val_fld_received		money,
	asset_id	char	(6),
	project_code	char	(6),
	consumable	char	(1),
	contract_type	char	(3),
	prev_years_exp		money,
	vat_est_cost	money  (8)
	primary key (purchase_req_no,order_line_no));

create table plan_stat (
	property_id	integer	not null,
	sequence_no	integer	not null,
	pl_stat	char	(1)	not null,
	usage_type	char	(1)	not null,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	usage_code	char	(5),
	primary key (property_id,sequence_no,pl_stat,usage_type));

create table pcouncils (
	pcoun_code	char	(8)	not null primary key,
	pcoun_descript	char	(40));

create table deed_dets (
	property_id	integer	not null,
	deed_packet_ref	char	(12)	not null,
	interest	char	(1)	not null,
	addr_no_prop	char	(4),
	addr_own_no	char	(4),
	agreement_type	char	(1),
	agree_s_date	 date,
	agree_ter_days	integer,
	agree_ter_mnths	integer,
	agree_ter_yrs	integer,
	alien_clse_type	char	(1),
	alien_clse_w_p	char	(1),
	break_clause	char	(4),
	clause_descript	text,
	county_own	char	(20),
	county_prop	char	(20),
	current_rent	money	(8),
	exten_opt_days	integer,
	exten_opt_mnths	integer,
	exten_opt_yrs	integer,
	inc_exc	char	(1),
	landlord_repair	text,
	late_pay_int	char	(1),
	l_lord_tenant_ex	char	(1),
	locality_own	char	(30),
	locality_prop	char	(30),
	name_of_prop	char	(40),
	ownr_organ_add	char	(40),
	pay_period	char	(10),
	post_code_prop	char	(8),
	post_code_own	char	(8),
	rent_rev_basis	char	(1),
	rent_rev_desc	text,
	review_per_mth	integer,
	review_per_yr	integer,
	road_own	char	(30),
	road_prop	char	(30),
	tenant_repair	text,
	datetime hour to minute_critical	char	(1),
	title_nat_desc	text,
	town_own	char	(25),
	town_prop	char	(25),
	usr_clause	char	(1),
	usr_clause_desc	text,
	tenancy_doc_cde	char	(4),
	active_service	char	(1),
	purpose_held	char	(1),
	land_use_code	char	(5),
	rent_renew_date_1	 date,
	rent_renew_date_2	 date,
	rent_renew_date_3	 date,
	rent_renew_date_4	 date,
	rent_renew_date_5	 date,
	rent_renew_date_6	 date,
	rent_renew_date_7	 date,
	rent_renew_date_8	 date,
	rent_renew_date_9	 date,
	renew_date_all	char	(117),
	department	char	(4),
	cost_centre	char	(4),
	management_unit	char	(4),
	hold_committee	char	(4),
	man_committee	char	(4),
	rent_abate		money,
	service_chg		money,
	est_income	integer,
	est_expend	integer,
	sub_let_to	char	(40),
	sub_let_desc	text
	primary key (property_id,deed_packet_ref,interest));

create table phys_land (
	phland_code	char	(1)	not null primary key,
	phland_descript	char	(30));

create table rev_frlse (
	property_id	integer	not null,
	deed_packet_ref	char	(12)	not null,
	seq_no_this	integer	not null,
	seq_no_let	integer	not null,
	agreed_rental	integer,
	interest	char	(1),
	live_flag	char	(1),
	live_flag_date	 date,
	notice_due_date	 date,
	notice_quit_date	 date,
	review_date	 date,
	rev_term_date	 date,
	review_terminate	char	(1),
	primary key (property_id,deed_packet_ref,seq_no_this,seq_no_let));

create table pro_unit (
	property_id	serial (1)	not null primary key,
	address_code	char	(8),
	alternative_ref	char	(15),
	asset_id	char	(6),
	capital_asset_code	char	(21),
	capital_sub_asset_no	integer,
	committee_div	char	(6),
	cost_centre	char	(4),
	hist_code_ref	char	(15),
	land_reg_till_no	char	(15),
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	management_unit	char	(4),
	principal_funct	char	(24),
	pro_unit_desc	char	(75),
	pro_unit_alt_desc	char	(75),
	uniq_prop_ref_no	char	(15));

create table aud_trans (
	aud_trans_key	serial (1)	not null primary key,
	action_type	char	(1),
	aud_date	 date,
	aud_reason	text,
	aud_time	datetime hour to minute,
	author	char	(10),
	fld_name	char	(30),
	fld_trim	char	(78),
	from_val	char	(50),
	rec_key	char	(78),
	tab_name	char	(10),
	to_val	char	(50));

create table ramp (
	property_id	integer	not null,
	occurrence	integer	not null,
	ramp_1_A	integer,
	ramp_1_B	integer,
	ramp_1_C	integer,
	ramp_1_h_rail	char	(1),
	primary key (property_id,occurrence));

create table priority (
	priority	char	(1)	not null primary key,
	descript	char	(24));

create table pro_levs (
	level_number	integer	not null primary key,
	level_name	char	(24),
	level_code_length	integer

create table prop_type (
	property_type	char	(3)	not null primary key,
	descript	char	(24));

create table purpose (
	purp_code	char	(1)	not null primary key,
	purp_descript	char	(30));

create table as_type (
	asset_type_code	char	(6)	not null primary key,
	descript	char	(24));

create table as_dels (
	asset_id	char	(6)	not null primary key,
	acceptance_date	 date,
	building_code	char	(3),
	bms_ref_fld	char	(8),
	contract_cost_pr	money	(9),
	contract_cost_yt	money	(9),
	contract_pm_job	char	(1),
	cost_centre	char	(4),
	date_last_comp	 date,
	date_next_due	 date,
	down_time	money	(8),
	est_replace_year	char	(4),
	warranty_expiry	char	(7),
	no_failures	integer,
	hours_run_per_wk	integer,
	indexed_rep_cost	integer,
	labour_cost_pr	money	(9),
	labour_cost_yt	money	(9),
	locat_code	char	(6),
	locat_ref	char	(13),
	site_code_bt	integer,
	manufacturer	char	(8),
	material_cost_pr	money	(9),
	material_cost_yt	money	(9),
	model_no	char	(20),
	management_unit	char	(4),
	asset_name	char	(24),
	asset_no	char	(6),
	order_no	integer,
	purchase_cost_pr	money	(9),
	purchase_cost_yt	money	(9),
	price_index_type	char	(3),
	charg_cost_cent	char	(4),
	account_code	char	(15),
	del_pm_job_flag	char	(1),
	price	integer,
	rely_stats_req	char	(1),
	repair_time	money	(8),
	serial_no	char	(12),
	site_code	char	(3),
	building_code_bt	integer,
	statutory_item	char	(1),
	start_date	 date,
	supplier_code	char	(8),
	sub_asset_no	char	(3),
	locat_bt1	integer,
	asset_type	char	(6),
	utilisation_cat	char	(3),
	workshop	char	(3),
	locat_bt2	integer,
	asset_no_bt1	integer,
	asset_no_bt2	integer,
	sub_asset_no_bt	integer,
	priority_code	char	(2),
	maintenance_plan	char	(2),
	resp_serv_level	char	(2),
	down_serv_level	char	(2));

create table fx_dets (
	transaction_no	integer	not null primary key,
	stock_loc_code	integer,
	stock_code	char	(10),
	order_number	integer,
	order_line_no	integer,
	invoice_number	char	(18),
	asset_job_no	char	(8),
	financial_year	char	(4),
	fx_date	 date,
	fx_time	datetime hour to minute,
	usr	char	(8),
	ref_fld_number	char	(12),
	account_code	char	(15),
	cost_centre	char	(4),
	cost	money	(8),
	quantity	integer,
	hours_completed	integer,
	percent_complete	integer,
	transaction_type	char	(1),
	comm_or_expend	char	(1),
	management_unit	char	(4),
	financial_period	integer

create table schl_type (
	schl_type	char	(3)	not null primary key,
	descript	char	(30));

create table site_dets (
	property_id	integer	not null primary key,
	address_number	char	(4),
	county	char	(20),
	county_council	char	(8),
	d_council_ward	char	(6),
	district_council	char	(8),
	electoral_div1	char	(3),
	electoral_div2	char	(3),
	electoral_div3	char	(3),
	electoral_div4	char	(3),
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	locality	char	(30),
	nat_grid_ref	char	(12),
	ord_survey_ref	char	(10),
	parish_council	char	(8),
	parl_constitncy	char	(6),
	post_code	char	(8),
	road	char	(30),
	serv_del_flag	char	(1),
	site_desc	text,
	site_name	char	(40),
	s_serv_team_bnd1	char	(1),
	s_serv_team_bnd2	char	(2),
	s_serv_team_bnd3	char	(1),
	town	char	(25));

create table ele_dets (
	element_code	char	(10)	not null primary key,
	area_required	char	(1),
	descript	char	(30),
	element_type	char	(2),
	height_required	char	(1),
	length_required	char	(1),
	quantity_required	char	(1),
	survey_interval	integer,
	upgrade_interval	integer,
	width_required	char	(1));

create table surv_dets (
	survey_seq_no	integer	not null,
	property_id	integer	not null,
	element_counter	integer	not null,
	element_type	char	(2)	not null,
	element_code	char	(10)	not null,
	condition_code	char	(4),
	construct_type	char	(5),
	element_seq_no	char	(4),
	element_area		money,
	element_height		money,
	element_length		money,
	element_quantity	integer,
	element_text	text,
	element_width		money,
	last_survey_date	 date,
	last_upgrade	 date,
	next_survey	 date,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	plan	money	(8),
	plan_text	text,
	priority	char	(1),
	remaining_life	integer,
	repair_cost	money	(8),
	servicable	money	(8),
	upgrade_cost	money	(8)
	primary key (survey_seq_no,property_id,element_counter,element_type,element_code));

create table temp_plan (
	property_id	integer	not null,
	temp_plan_perm	char	(20)	not null,
	descript	text,
	expired_date	 date,
	granted_date	 date,
	temp_stat	char	(1),
	submit_date	 date
	primary key (property_id,temp_plan_perm));

create table ten_docs (
	ten_doc_code	char	(4)	not null primary key,
	ten_doc_descript	char	(60));

create table tenant (
	tenant	char	(10)	not null primary key,
	descript	char	(24));

create table tenure (
	tenure	char	(6)	not null primary key,
	descrip	char	(30));

create table trim_flds (
	frm_name	char	(10)	not null primary key,
	title	char	(50),
	trim1	char	(78),
	trim2	char	(78),
	trim3	char	(78),
	trim4	char	(78),
	trim5	char	(78),
	trim6	char	(78),
	trim7	char	(78),
	trim8	char	(78),
	trim9	char	(78),
	trim10	char	(78),
	trim11	char	(78),
	trim12	char	(78),
	trim13	char	(78),
	trim14	char	(78),
	trim15	char	(78),
	trim16	char	(78),
	trim17	char	(78),
	trim18	char	(78),
	trim19	char	(78),
	trim20	char	(78),
	trim21	char	(78),
	trim22	char	(78),
	trim23	char	(78),
	trim24	char	(78),
	trim25	char	(78),
	trim26	char	(78),
	trim27	char	(78),
	trim28	char	(78),
	trim29	char	(78),
	trim30	char	(78),
	trim31	char	(78),
	trim32	char	(78),
	trim33	char	(78),
	trim34	char	(78),
	trim35	char	(78),
	trim36	char	(78),
	trim37	char	(78),
	trim38	char	(78),
	trim39	char	(78),
	trim40	char	(78),
	trim41	char	(78),
	trim42	char	(78),
	trim43	char	(78),
	trim44	char	(78),
	trim45	char	(78),
	trim46	char	(78),
	trim47	char	(78),
	trim48	char	(78),
	trim49	char	(78),
	trim50	char	(78),
	trim51	char	(78),
	trim52	char	(78),
	trim53	char	(78),
	trim54	char	(78),
	trim55	char	(78),
	trim56	char	(78),
	trim57	char	(78),
	trim58	char	(78),
	trim59	char	(78),
	trim60	char	(78));

create table wards (
	ward	char	(4)	not null primary key,
	descript	char	(40));

create table hlp_info2 (
	hlp_level	char	(1)	not null,
	frm_name	char	(44)	not null,
	fld_name	char	(44)	not null,
	hlp_text	text
	primary key (hlp_level,frm_name,fld_name));

create table ele_types (
	element_type	char	(2)	not null primary key,
	element_descript	char	(38));

create table ele_yrs (
	property_id	integer	not null,
	element_type	char	(2)	not null,
	instance	integer	not null,
	element_code	char	(10)	not null,
	year	char	(4)	not null,
	actual_cost_yr		money,
	condition	char	(4),
	est_cost_yr		money,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	priority	char	(4),
	primary key (property_id,element_type,instance,element_code,year));

create table pj_dets (
	project_code	char	(6)	not null primary key,
	descript	char	(24),
	start_date	 date,
	estimated_comp	 date,
	req_by_cost_cent	char	(4),
	budget	integer,
	management_unit	char	(4),
	orig_approved		money,
	latest_approved		money,
	latest_estimated		money,
	forecast_ny		money,
	paid_prev_years		money,
	job_manager	char	(8),
	account_code	char	(15),
	forecast_ny_1		money,
	forecast_ny_2		money,
	forecast_ny_3		money,
	forecast_ny_4		money,
	forecast_ny_5		money,
	forecast_future		money,
	forecast_total		money,
	live_flag	char	(1),
	date_completed	 date,
	programme_est		money,
        job_sponsor   char    (8));

create table grn_dets (
	grn_number	char	(10)	not null primary key,
	del_note_no	char	(8),
	invoice_date	 date,
	locat	integer,
	stock_yn_flag	char	(1),
	account_code	char	(15),
	cost_centre	char	(4),
	received_qty	integer,
	received_val_fld	money	(9),
	grn_date	 date,
	invoice_number	char	(18),
	order_number	integer,
	order_line_no	integer,
	stock_part_code	char	(10),
	supplier	char	(8),
	financial_year	char	(4),
	financial_period	integer,
	invoiced_val_fld	money	(9),
	invoiced_qty	integer,
	document_type	char	(2),
	document_number	integer,
	invoice_period	integer,
	invoice_year	char	(4),
	vat_val_fld	money	(9),
	entered_by	char	(8),
	entered_on	 date,
	include_in_batch	char	(1),
	batch_number	integer

create table job_audt (
	job_id	char	(6)	not null primary key,
	pm_job_no_req_no	char	(6),
	date_cancelled	 date,
	ref_login_name	char	(14),
	reason	char	(24));

create table land_surv (
	property_id	integer	not null,
	survey_date	 date	not null,
	site_area	float	(64),
	build_comments	text,
	car_park_area	integer,
	date_measured	 date,
	dev_factors	text,
	electricity	char	(1),
	fencing_cond	char	(4),
	foul_water_mains	char	(1),
	foul_water_plant	char	(1),
	gas	char	(1),
	gen_comments	text,
	land_cond_code1	char	(1),
	land_cond_code2	char	(1),
	land_cond_code3	char	(1),
	land_cond_code4	char	(1),
	land_cond_code5	char	(1),
	land_cond_code6	char	(1),
	phland_code	char	(6),
	land_desc	text,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	measurer	char	(20),
	no_car_spaces	integer,
	oil_heating	char	(1),
	ped_access	char	(1),
	ped_access_desc	text,
	site_desc	text,
	surveyor_name	char	(20),
	telephone	char	(1),
	veh_access_desc	text,
	vehicle_access	char	(1),
	water	char	(1),
	primary key (property_id,survey_date));

create table prem_loc (
	property_id	integer	not null,
	loc_fin_sys_code	char	(7)	not null,
	primary key (property_id,loc_fin_sys_code));

create table asbestos (
	property_id	integer	not null primary key,
	actioned_by	char	(40),
	asbestos_found	char	(1),
	date_completed	 date,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	lfs_code	char	(7),
	next_survey	 date,
	survey_cost	integer,
	survey_date	 date,
	surveyed_by	char	(40),
	urgency_number	char	(1),
	work_order_no	char	(12));

create table soc_servs (
	soc_serv1	char	(1)	not null,
	soc_serv2	char	(2)	not null,
	soc_serv3	char	(1)	not null,
	soc_serv_descript	char	(40),
	primary key (soc_serv1,soc_serv2,soc_serv3));

create table ass_dets (
	property_id	integer	not null primary key,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	asset_category	char	(2),
	land_and_build	char	(1),
	basis_of_val	char	(5),
	method_of_val	char	(3),
	type_of_prop	char	(1));

create table land_use (
	land_use_code	char	(5)	not null primary key,
	land_use_descript	text

create table surveys (
	property_id	integer	not null,
	survey_seq_no	integer	not null,
	date_surveyed	 date,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	nam_add_surveyor	char	(8),
	surveyor	char	(30),
	survey_descript	char	(30),
	survey_text	text
	primary key (property_id,survey_seq_no));

create table restr_dets (
	property_id	integer	not null primary key,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	tree_pres_order	text,
	oth_t_plan_info	text,
	geo_min_wat_sew	text,
	bound_type_resp	text,
	disp_land_detail	text,
	add_details	text,
	puswa_not_iss_rec	text,
	land_consrv_area	text,
	protected_specs	text,
	other_use_1	text,
	other_use_2	text,
	access_to_land	text

create table compl_dets (
	property_id	integer	not null,
	act_name	char	(30)	not null,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	compliance	char	(1),
	date_insp	 date,
	detail	text
	primary key (property_id,act_name));

create table bld_opcost (
	property_id	integer	not null,
	cost_date	 date	not null,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	a_maint_cost		money,
	a_gnd_maint_cost		money,
	a_elec_cost		money,
	a_gas_cost		money,
	a_water_cost		money,
	a_fuel_oil_cost		money,
	a_sec_cost		money,
	a_rent_cost		money,
	a_rates_cost		money,
	a_clean_cost		money,
	other_a_cost		money,
	tot_a_cost		money
	primary key (property_id,cost_date));

create table occupancy (
	property_id	integer	not null primary key,
	name	char	(40),
	add_no	char	(4),
	address1	char	(30),
	address2	char	(30),
	address3	char	(30),
	address4	char	(30),
	post_code	char	(12),
	area_empty	char	(8),
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	leasehold_covenants	text,
	other_lease_details	text,
	current_annual_rent		money,
	rent_due_date	 date,
	rent_review_date	 date,
	date_rent_set	 date,
	lease_expiry_date	 date,
	length_of_lease	integer,
	date_vacated	 date

create table energy_per (
	property_id	integer	not null primary key,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	fabric_en	char	(4),
	engineer_en	char	(4),
	energy_pe	char	(4),
	surv_nam	char	(8),
	surveyor	char	(30),
	fabric_up	integer,
	engineer_up	integer,
	date_of_survey	 date

create table en_perform (
	energy_per	char	(4)	not null primary key,
	descript	char	(24));

create table energy_cat (
	energy_cat	char	(4)	not null primary key,
	descript	char	(24));

create table fitness (
	property_id	integer	not null primary key,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	overall	char	(4),
	facilities	char	(4),
	space_rel	char	(4),
	locat	char	(4),
	environment	char	(4),
	amenity	char	(4),
	other	char	(4),
	cost_to_upg		money,
	cost_to_rep		money,
	date_or_surv	 date,
	surveyor	char	(8),
	surveyed_by	char	(30));

create table ss_maint (
	property_id	integer	not null primary key,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	sc_esc	char	(4),
	sc_std	char	(4),
	sc_alarm	char	(4),
	sc_bld	char	(4),
	sc_food	char	(4),
	sc_other	char	(4),
	sc_esc_up	integer,
	sc_std_up	integer,
	sc_alarm_up	integer,
	sc_bld_up	integer,
	sc_food_up	integer,
	sc_other_up	integer,
	overall_fs	char	(4),
	overall_hs	char	(4),
	date_of_survey	 date,
	surv_name	char	(8),
	surveyor	char	(30));

create table room_dets (
	property_id	integer	not null primary key,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	capacity		money,
	actual_use		money,
	floor_area		money,
	heated_vol		money,
	gross_vol		money,
	electricity	char	(1),
	gas	char	(1),
	other1	char	(1),
	other2	char	(1),
	other3	char	(1),
	other4	char	(1),
	other5	char	(1),
	other6	char	(1),
	other7	char	(1),
	other8	char	(1),
	other9	char	(1),
	comms	char	(1),
	no_other1	integer,
	no_other2	integer,
	no_other3	integer,
	no_other4	integer,
	no_other5	integer,
	no_other6	integer,
	no_other7	integer,
	no_other8	integer,
	no_other9	integer,
	no_comms	integer,
	no_electricity	integer,
	no_gas	integer

create table fit_code (
	fit_code	char	(4)	not null primary key,
	descript	char	(24));

create table encumber (
	property_id	integer	not null,
	deed_packet_ref	char	(12)	not null,
	encum_benefit_cde	char	(2)	not null,
	record_type	char	(1)	not null,
	descript	text
	primary key (property_id,deed_packet_ref,encum_benefit_cde,record_type));

create table stat_dets (
	stat_code	char	(4)	not null primary key,
	stat_descript	char	(40));

create table ratings (
	property_id	integer	not null,
	valuation_list	char	(15)	not null,
	glh_cons_ref	char	(12),
	building_age	char	(4),
	building_cond	char	(1),
	charity_rel	char	(1),
	class_listed	char	(1),
	college	text,
	contractor	text,
	county	char	(25),
	dfe_return	char	(1),
	estate_ref_1	char	(8),
	estate_ref_2	char	(4),
	estate_ref_3	char	(10),
	exit_area_f	integer,
	exit_area_m	integer,
	formula	text,
	gross_val_1	integer,
	gross_val_2	integer,
	gross_val_3	integer,
	gross_val_4	integer,
	gross_val_5	integer,
	ind_ware_work	text,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	lifts	char	(1),
	modern_c_heat	text,
	mkt_rent_prev	text,
	modern_a_cond	text,
	net_int_code1_f	integer,
	net_int_code2_f	integer,
	net_int_code3_f	integer,
	net_int_code1_m	integer,
	net_int_code2_m	integer,
	net_int_code3_m	integer,
	net_val_1	integer,
	net_val_2	integer,
	net_val_3	integer,
	net_val_4	integer,
	net_val_5	integer,
	occupier_com	char	(20),
	occupier_ten	char	(20),
	office	text,
	other_use	text,
	other	text,
	plant_machine_t	text,
	play_f_tenn_c	text,
	pool_use_excl	char	(1),
	pool_use_joint	char	(19),
	prime_1	integer,
	prime_2	integer,
	prime_3	integer,
	prime_4	integer,
	prime_5	integer,
	profits	text,
	property_type	char	(3),
	prop_owner	char	(20),
	pupils_recog	integer,
	pupils_stand	integer,
	pup_onroll_1	money	(7),
	pup_onroll_2	money	(7),
	pup_onroll_3	money	(7),
	pup_onroll_4	money	(7),
	pup_onroll_5	money	(7),
	pup_rec_1	integer,
	pup_rec_2	integer,
	pup_rec_3	integer,
	pup_rec_4	integer,
	pup_rec_5	integer,
	pup_stand_1	integer,
	pup_stand_2	integer,
	pup_stand_3	integer,
	pup_stand_4	integer,
	pup_stand_5	integer,
	rates_pay_1		money,
	rates_pay_2		money,
	rates_pay_3		money,
	rates_pay_4		money,
	rates_pay_5		money,
	rate_val_1993	money	(9),
	rating_author	char	(12),
	rca_area_m	integer,
	rca_area_f	integer,
	school_ref_no	char	(4),
	s_hall_use_excl	char	(1),
	s_hall_use_joint	char	(20),
	shop	text,
	start_date_1	 date,
	start_date_2	 date,
	start_date_3	 date,
	start_date_4	 date,
	start_date_5	 date,
	superfluity_1	money	(7),
	superfluity_2	money	(7),
	superfluity_3	money	(7),
	superfluity_4	money	(7),
	superfluity_5	money	(7),
	super_date_1	 date,
	super_date_2	 date,
	super_date_3	 date,
	super_date_4	 date,
	super_date_5	 date,
	victorian_desc	char	(12),
	year_1	char	(5),
	year_2	char	(5),
	year_3	char	(5),
	year_4	char	(5),
	year_5	char	(5),
	primary key (property_id,valuation_list));

create table alt_st_dts (
	property_id	integer	not null primary key,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	address_number	char	(4),
	locality	char	(30),
	road	char	(30),
	site_name	char	(40),
	town	char	(25),
	county	char	(20),
	post_code	char	(8),
	site_desc	text,
	gas_sup_l_office	char	(8),
	gas_service_dets	text,
	elec_sup_l_office	char	(8),
	elec_serv_dets	text,
	water_sup_l_office	char	(8),
	water_serv_dets	text,
	dr_auth_l_office	char	(8),
	dr_arrangement	text,
	oth_sup_name_1	char	(8),
	oth_sup_dets_1	text,
	oth_sup_name_2	char	(8),
	oth_sup_dets_2	text,
	loc_plan_officer	char	(8),
	h_way_authority	char	(8),
	river_authority	char	(8),
	district_valuer	char	(8),
	hlth_sfe_l_office	char	(8),
	other	char	(8),
	telecom_provider	char	(8),
	telecom_det	text,
	land_area_hect		money,
	hard_area_hect		money,
	disp_land_area		money,
	soft_area_hect		money,
	car_park_area		money,
	no_of_spaces	integer,
	terr_plan_no	char	(8),
	listed_building	char	(8),
	exist_use_des	text,
	land_val_pres_use		money,
	present_use_dt	 date,
	pot_use_desig	text,
	land_val_pot_use		money,
	pot_use_date	 date,
	non_domestic_rv		money,
	non_dom_date	 date,
	exist_consent	text,
	exist_consent_exp	 date,
	surveyed_by	char	(8),
	surv_name	char	(30),
	date_of_survey	 date

create table hold_comm (
	hold_comm_code	char	(4)	not null primary key,
	hold_comm_descript	char	(24));

create table serv_deps (
	serv_deps_code	char	(5)	not null primary key,
	serv_deps_descript	char	(24));

create table bu_rec (
	financial_year	char	(4)	not null,
	cost_centre	char	(4)	not null,
	account_code	char	(15)	not null,
	annual_budget	integer,
	same_each_period	char	(1),
	dummy_period	integer,
	management_unit	char	(4),
	budget_period_1	integer,
	budget_period_2	integer,
	budget_period_3	integer,
	budget_period_4	integer,
	budget_period_5	integer,
	budget_period_6	integer,
	budget_period_7	integer,
	budget_period_8	integer,
	budget_period_9	integer,
	budget_period_10	integer,
	budget_period_11	integer,
	budget_period_12	integer,
	budget_period_13	integer,
	commt_period_1		money,
	commt_period_2		money,
	commt_period_3		money,
	commt_period_4		money,
	commt_period_5		money,
	commt_period_6		money,
	commt_period_7		money,
	commt_period_8		money,
	commt_period_9		money,
	commt_period_10		money,
	commt_period_11		money,
	commt_period_12		money,
	commt_period_13		money,
	expend_period_1		money,
	expend_period_2		money,
	expend_period_3		money,
	expend_period_4		money,
	expend_period_5		money,
	expend_period_6		money,
	expend_period_7		money,
	expend_period_8		money,
	expend_period_9		money,
	expend_period_10		money,
	expend_period_11		money,
	expend_period_12		money,
	expend_period_13		money,
	last_year_actual		money,
	estimated_actual	integer,
	budget_group	char	(4),
	primary key (financial_year,cost_centre,account_code));

create table pm_job (
	pm_job_id	char	(6)	not null primary key,
	asset_id	char	(6),
	frequency_weeks	integer,
	next_wk_sched_n	integer,
	next_wk_sched	char	(7),
	trade	char	(1),
	grade_1	char	(3),
	grade_2	char	(3),
	grade_3	char	(3),
	grade_4	char	(3),
	quantity_1	integer,
	quantity_2	integer,
	quantity_3	integer,
	quantity_4	integer,
	estimated_cost	money	(8),
	no_of_omissions	integer,
	job_type_code	char	(2),
	wk_cont_time_hrs	money	(5),
	allowce_time_hrs	money	(5),
	priority_code	char	(2),
	access_code	char	(1),
	asset_cost_cent	char	(4),
	charg_cost_cent	char	(4),
	account_code	char	(15),
	series_no	integer,
	category	char	(2),
	safety_permit_yn	char	(1),
	date_last_compl	 date,
	skip_flag	char	(1),
	contract_code	char	(6),
	contract_type	char	(3),
	dorc_flag	char	(1),
	last_wk_transfer	char	(7),
	statutory_job	char	(1),
	suspend	char	(1));

create table adv_note (
	advice_note	char	(15)	not null primary key,
	advice_text	text

create table ca_dels (
	capital_asset_code	char	(21)	not null,
	capital_sub_asset_no	integer	not null,
	notes	char	(50),
	charge_type	char	(6),
	int_type	char	(2),
	pr_index_type	char	(3),
	purchase_type	char	(1),
	acceptance_date	 date,
	replacement_date	 date,
	remaining_life	integer,
	last_charged	char	(6),
	purchase_price		money,
	indexed_replacement_cost		money,
	depreciation_to_date		money,
	net_book_val_fld		money,
	interest		money,
	division	char	(4),
	management_unit	char	(4),
	cost_centre	char	(4),
	account_code	char	(15),
	asset_id	char	(6),
	property_id	integer,
	prev_capital_asset_code	char	(21),
	prev_capital_sub_asset_no	integer,
	residual_val_fld		money,
	apportionment_count	integer,
        notes_extra char    (50),
	primary key (capital_asset_code,capital_sub_asset_no));

create table lettings (
	property_id	integer	not null,
	deed_packet_ref	char	(12)	not null,
	lfs_code	char	(7)	not null,
	occurrence_s_d_i	integer	not null,
	active_service	char	(1),
	agreement_date	 date,
	agreement_type	char	(1),
	agree_term_days	integer,
	agree_term_mths	integer,
	agree_term_yrs	integer,
	alien_clause	char	(1),
	alien_clause_desc	text,
	alien_clause_type	char	(1),
	break_clause	char	(4),
	current_rent		money,
	division	char	(4),
	business_unit	char	(4),
	department	char	(4),
	essence_time	char	(1),
	est_expend	integer,
	est_income	integer,
	exten_opt_days	integer,
	exten_opt_mths	integer,
	exten_opt_yrs	integer,
	hold_committee	char	(4),
	include_exclude	char	(1),
	insured_by	char	(1),
	interest	char	(1),
	landlord_repair	text,
	land_use_code	char	(5),
	late_payment	char	(1),
	live_flag	char	(1),
	live_flag_date	 date,
	l_lord_ten_excl	char	(1),
	man_committee	char	(4),
	ownr_organ_add	char	(40),
	ownr_address_no	char	(4),
	ownr_road	char	(30),
	ownr_locality	char	(30),
	ownr_town	char	(25),
	ownr_county	char	(20),
	ownr_post_code	char	(8),
	pay_period	char	(10),
	purpose_held	char	(1),
	rent_abate		money,
	rent_basis	char	(1),
	rent_basis_desc	text,
	rent_renew_date_1	 date,
	rent_renew_date_2	 date,
	rent_renew_date_3	 date,
	rent_renew_date_4	 date,
	rent_renew_date_5	 date,
	rent_renew_date_6	 date,
	rent_renew_date_7	 date,
	rent_renew_date_8	 date,
	rent_renew_date_9	 date,
	renew_date_all	char	(99),
	review_per_mths	integer,
	review_per_yrs	integer,
	service_charges	char	(1),
	service_chg		money,
	sub_let_desc	text,
	sub_let_to	char	(40),
	tenancy_doc_cde	char	(10),
	tenant_repair	text,
	term_indicator	char	(1),
	usr_clause	char	(1),
	usr_desc	text
	primary key (property_id,deed_packet_ref,lfs_code,occurrence_s_d_i));

create table cw_job (
	cw_job_id	char	(6)	not null primary key,
	project_code	char	(6),
	job_id_req_no	char	(6),
	work_type	char	(1),
	docket_no	char	(6),
	asset_id	char	(6),
	management_unit	char	(4),
	reason_for_delay	char	(1),
	out_of_seq_flag	char	(1),
	job_type_code	char	(2),
	trade	char	(1),
	grade_1	char	(3),
	grade_2	char	(3),
	grade_3	char	(3),
	grade_4	char	(3),
	quantity_1	integer,
	quantity_2	integer,
	quantity_3	integer,
	quantity_4	integer,
	asset_cost_cent	char	(4),
	charg_cost_cent	char	(4),
	account_code	char	(15),
	category	char	(2),
	priority_code	char	(2),
	week_planned	char	(7),
	date_reported	 date,
	date_to_comp_ex	 date,
	wk_cont_time_hrs	money	(5),
	allowce_time_hrs	money	(5),
	rev_wk_cont_time	money	(5),
	rev_allow_time	money	(5),
	tot_hours_compl	money	(5),
	labour_cost	money	(9),
	materials_cost	money	(9),
	fault_code	char	(3),
	failure_yn	char	(1),
	downtime_hours	money	(5),
	datetime hour to minute_to_repr_hrs	money	(5),
	wrk_done_summary	char	(24),
	access_code	char	(1),
	series	integer,
	frequency	integer,
	site_code	char	(3),
	building_code	char	(3),
	locat_code	char	(6),
	asset_no	char	(6),
	sub_asset_no	char	(3),
	asset_name	char	(24),
	asset_type	char	(6),
	datetime hour to minute_reported	datetime hour to minute,
	contract_code	char	(6),
	contract_type	char	(3),
	dorc_flag	char	(1),
	status_flag	char	(1),
	workshop	char	(3),
	estimated_cost	money	(8),
	estimated_hrs	money	(5),
	purch_order_flag	char	(1),
	safety_permit_yn	char	(1),
	reported_by	char	(24),
	site_code_bt	integer,
	building_code_bt	integer,
	locat_bt1	integer,
	locat_bt2	integer,
	asset_no_bt1	integer,
	asset_no_bt2	integer,
	sub_asset_no_bt	integer,
	statutory_job	char	(1),
	resp_date_plan	 date,
	resp_time_plan	datetime hour to minute,
	comp_date_plan	 date,
	comp_time_plan	datetime hour to minute,
	maintenance_plan	char	(2),
	resp_serv_level	char	(2),
	down_serv_level	char	(2),
	logged_by	char	(10),
	datetime hour to minute_resp	datetime hour to minute,
	datetime hour to minute_resp_a	money	(5),
	date_act_resp	 date,
	log_date	 date,
	log_time	datetime hour to minute,
	phoenix_code	char	(6),
	usr_ref_fld	char	(12),
	delay_time_comp_a	money	(5),
	delay_time_comp	datetime hour to minute,
	delay_date_comp	 date,
	delay_time_resp_a	money	(5),
	delay_time_resp	datetime hour to minute,
	delay_date_act_resp	 date,
        dckt_iss_yn  char (1));

create table land_val (
	property_id	integer	not null primary key,
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	method_of_val	char	(3),
	hard_surf_area	float	(64),
	hsa_pnds_per_hect	integer,
	hsa_value	integer,
	open_surf_area	float	(64),
	osa_pnds_per_hect	integer,
	osa_value	integer,
	end_adjustment	integer,
	total_land_area	float	(64),
	total_value	integer,
	comments	text,
	eff_val_date	 date,
	date_val_carr_out	 date,
	valuer_code	char	(4));

create table bdg_dets (
	building_code	char	(3)	not null,
	site_code	char	(3)	not null,
	phoenix_code	char	(6),
	property_id	integer,
	building_name	char	(24),
	primary key (building_code,site_code));

create table jb_costs (
	uniquifier	serial (1)	not null primary key,
	docket_number	char	(6),
	cost_type	char	(1),
	cost_ref	char	(30),
	cost	money	(8)

create table level_menu (
	form_nam	char	(10)	not null primary key,
	lev_attach_1	char	(1),
	lev_attach_2	char	(1),
	lev_attach_3	char	(1),
	lev_attach_4	char	(1),
	lev_attach_5	char	(1),
	lev_attach_6	char	(1),
	lev_attach_7	char	(1));

create table trans_log (
	capital_asset_code	char	(21)	not null,
	capital_sub_asset_no	integer	not null,
	run_type	integer	not null,
	transfer_date	 date
	primary key (capital_asset_code,capital_sub_asset_no,run_type));

create table walk_tmp (
	sequence_number	serial (1)	not null primary key,
	capital_asset_code	char	(21),
	capital_sub_asset_no	integer,
	notes	char	(50),
	purchase_price		money,
	indexed_replacement_cost		money,
	dep_int_this_per		money,
	new_val_fld	char	(25),
	old_val_fld	char	(25),
	transaction_type	char	(3),
	division	char	(4),
	asset_group	char	(3),
	account_code	char	(4),
	cap_chgs_centre	char	(10),
	cap_chgs_account	char	(10),
	serv_code	char	(3));

create table dist_plan (
	property_id	integer	not null primary key,
	airfield_nearby	char	(1),
	anct_monument	char	(1),
	arch_interest	char	(1),
	conserv_area	char	(1),
	date_adopted	 date,
	dist_adopt_plan	char	(1),
	educ_policy	char	(1),
	emp_area_spec_res	char	(1),
	flood_plain	char	(1),
	green_belt	char	(1),
	green_settle	char	(1),
	implic_detail_1	text,
	l_conserv_area	char	(1),
	l_develop_area	char	(1),
	level_1_code	char	(20),
	level_2_code	char	(20),
	level_3_code	char	(20),
	level_4_code	char	(20),
	level_5_code	char	(20),
	level_6_code	char	(20),
	level_7_code	char	(20),
	level_number	integer,
	nature_reserve	char	(1),
	o_head_lines	char	(1),
	o_nat_beau_area	char	(1),
	other_desc	text,
	other_policy	char	(1),
	p_build_policy	char	(1),
	plan_title	text,
	rec_policy	char	(1),
	regional_park	char	(1),
	res_area_spec_res	char	(1),
	rural_area	char	(1),
	rural_settle	char	(1),
	sewers_below	char	(1),
	shop_policy	char	(1),
	site_implic	char	(1),
	soc_policy	char	(1),
	specif_settle	char	(1),
	sssi	char	(1),
	tour_policy	char	(1),
	town_plan	char	(1),
	town_policy	char	(1),
	trans_policy	char	(1),
	tree_pres_order	char	(1),
	util_policy	char	(1),
	waste_policy	char	(1),
	oil_line	char	(1));

create table trans_srv (
	asset_group	char	(3)	not null primary key,
	serv_code	char	(3));

create table trans_acc (
	asset_group	char	(3)	not null,
	detail_or_contra	char	(1)	not null,
	account	char	(4),
	primary key (asset_group,detail_or_contra));

create table ap_dets (
	cap_asset_code	char	(21)	not null,
	cap_asset_sub	integer	not null,
	division	char	(4)	not null,
	management_unit	char	(4)	not null,
	cost_centre	char	(4)	not null,
	account_code	char	(15)	not null,
	percentage	money	(3),
	donated	char	(1)	not null,
	primary key (cap_asset_code,cap_asset_sub,division,management_unit,cost_centre,account_code,donated));

create table ap_dels (
	capital_asset_code	char	(21)	not null,
	capital_sub_asset_code	integer	not null,
	division	char	(4)	not null,
	management_unit	char	(4)	not null,
	cost_centre	char	(4)	not null,
	account_code	char	(15)	not null,
	percentage	money	(3),
	donated	char	(1)	not null,
	primary key (capital_asset_code,capital_sub_asset_code,division,management_unit,cost_centre,account_code,donated));

create table nhs_sup (
	transaction_no	integer	not null primary key,
	batch_id	 date,
	docket_no	char	(6),
	stock_no	char	(10),
	stock_description	char	(40),
	date_issued	 date,
	quantity_issued	integer,
	cost	money	(9),
	transferred	char	(1));

create table pm_safety_permit (
        pm_job_id        char (6)     not null primary key,
        permit_det1      char(24),
        permit_det2      char(24),
        permit_det3      char(24),
        permit_det4      char(24),
        permit_det5      char(24));

create table cw_safety_permit (
        cw_job_id        char (6)     not null primary key,
        permit_det1      char(24),
        permit_det2      char(24),
        permit_det3      char(24),
        permit_det4      char(24),
        permit_det5      char(24));

create table ph_safety_permit (
        perm_history_id  char (6)     not null primary key,
        permit_det1      char(24),
        permit_det2      char(24),
        permit_det3      char(24),
        permit_det4      char(24),
        permit_det5      char(24));
