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

	let vl_complaint_no[1] = "1"

	for vl_loop = 1 to 1
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
