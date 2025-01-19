database universe

globals "../UTILS/globals.4gl"

main

define vl_complaint_no array[55] of like comp.complaint_no
define vl_loop			integer
define vl_today			date
define vl_h				like comp.time_closed_h
define vl_m				like comp.time_closed_m

	if not set_envs() then
		exit program
	end if

	let vl_complaint_no[1] = "4606"
	let vl_complaint_no[2] = "4555"
	let vl_complaint_no[3] = "4476"
	let vl_complaint_no[4] = "4420"
	let vl_complaint_no[5] = "4406"
	let vl_complaint_no[6] = "4358"
	let vl_complaint_no[7] = "4219"
	let vl_complaint_no[8] = "4200"
	let vl_complaint_no[9] = "4128"
	let vl_complaint_no[10] = "4168"
	let vl_complaint_no[11] = "4115"
	let vl_complaint_no[12] = "3974"
	let vl_complaint_no[13] = "3955"
	let vl_complaint_no[14] = "3942"
	let vl_complaint_no[15] = "3921"
	let vl_complaint_no[16] = "3805"
	let vl_complaint_no[17] = "3764"
	let vl_complaint_no[18] = "3599"
	let vl_complaint_no[19] = "3563"
	let vl_complaint_no[20] = "3508"
	let vl_complaint_no[21] = "3500"
	let vl_complaint_no[22] = "3203"
	let vl_complaint_no[23] = "3172"
	let vl_complaint_no[24] = "3096"
	let vl_complaint_no[25] = "2980"
	let vl_complaint_no[26] = "2926"
	let vl_complaint_no[27] = "2898"
	let vl_complaint_no[28] = "2897"
	let vl_complaint_no[29] = "2863"
	let vl_complaint_no[30] = "2738"
	let vl_complaint_no[31] = "2607"
	let vl_complaint_no[32] = "2595"
	let vl_complaint_no[33] = "2549"
	let vl_complaint_no[34] = "2517"
	let vl_complaint_no[35] = "2479"
	let vl_complaint_no[36] = "2398"
	let vl_complaint_no[37] = "2206"
	let vl_complaint_no[38] = "2191"
	let vl_complaint_no[39] = "1976"
	let vl_complaint_no[40] = "1860"
	let vl_complaint_no[41] = "1852"
	let vl_complaint_no[42] = "1753"
	let vl_complaint_no[43] = "1752"
	let vl_complaint_no[44] = "1694"
	let vl_complaint_no[45] = "1592"
	let vl_complaint_no[46] = "1369"
	let vl_complaint_no[47] = "1290"
	let vl_complaint_no[48] = "1287"
	let vl_complaint_no[49] = "1280"
	let vl_complaint_no[50] = "1092"
	let vl_complaint_no[51] = "779"
	let vl_complaint_no[52] = "770"
	let vl_complaint_no[53] = "709"
	let vl_complaint_no[54] = "697"
	let vl_complaint_no[55] = "690"

	for vl_loop = 1 to 55
		let vl_today = today
		call get_time() returning vl_h, vl_m
		update comp set date_closed = vl_today, time_closed_h = vl_h,
			time_closed_m = vl_m
			where complaint_no = vl_complaint_no[vl_loop]
		if vg_crm_enhanced = "Y" then
			call pop_ci_export_variables(vl_complaint_no[vl_loop])
			let vr_crm_import_export.transaction_type = "C"
			call unload_crm_export_file(vr_crm_import_export.*)
		end if
	end for

end main

function join()

end function
