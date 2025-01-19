-- The samples
insert into insp_list (
    complaint_no,
    state,
    action_flag,
    action,
    item_ref,
    site_ref,
    postcode,
    site_name_1,
    ward_code,
    do_date,
    end_time_h,
    end_time_m,
    start_time_h,
    start_time_m,
    recvd_by,
    comp_code,
    user_name )
  select comp.complaint_no,
         'W',
         comp.action_flag,
         '',
         comp.item_ref,
         comp.site_ref,
         comp.postcode,
         site.site_name_1,
         site.ward_code,
         comp.date_entered,
         si_i_sched.end_time_h,
         si_i_sched.end_time_m,
         si_i_sched.start_time_h,
         si_i_sched.start_time_m,
         comp.recvd_by,
         comp.comp_code,
         pda_user.user_name
  from comp, patr_area, pda_user, site, outer si_i_sched
  where comp.action_flag = 'P'
  and   comp.date_closed is null
  and   patr_area.po_code = pda_user.po_code
  and   patr_area.pa_site_flag = 'P'
  and   comp.pa_area = patr_area.area_c
  and   site.site_ref = comp.site_ref
  and   si_i_sched.site_ref = comp.site_ref
  and   si_i_sched.item_ref = comp.item_ref
  and   si_i_sched.feature_ref = comp.feature_ref
  and   si_i_sched.contract_ref = comp.contract_ref
  and 
    (
      ( si_i_sched.occur_day = 'AXXXXXX'
        and weekday(comp.date_entered) = 1 )
      or
      ( si_i_sched.occur_day = 'XAXXXXX'
        and weekday(comp.date_entered) = 2 )
      or
      ( si_i_sched.occur_day = 'XXAXXXX'
        and weekday(comp.date_entered) = 3 )
      or
      ( si_i_sched.occur_day = 'XXXAXXX'
        and weekday(comp.date_entered) = 4 )
      or
      ( si_i_sched.occur_day = 'XXXXAXX'
        and weekday(comp.date_entered) = 5 )
      or
      ( si_i_sched.occur_day = 'XXXXXAX'
        and weekday(comp.date_entered) = 6 )
      or
      ( si_i_sched.occur_day = 'XXXXXXA'
        and weekday(comp.date_entered) = 0 )
    ) 
  and   si_i_sched.seq_no =
   ( select max(seq_no)
     from si_i_sched
     where site_ref = comp.site_ref
     and   item_ref = comp.item_ref
     and   feature_ref = comp.feature_ref
     and   contract_ref = comp.contract_ref
     and   occur_day = si_i_sched.occur_day
   )
