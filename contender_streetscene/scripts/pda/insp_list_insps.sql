-- The complaints
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
         comp.ent_time_h,
         comp.ent_time_m,
         comp.ent_time_h,
         comp.ent_time_m,
         comp.recvd_by,
         comp.comp_code,
         pda_user.user_name
  from comp, site, patr_area, pda_user
  where comp.action_flag = 'I'
  and   comp.date_closed is null
  and   patr_area.po_code = pda_user.po_code
  and   patr_area.pa_site_flag = 'P'
  and   comp.pa_area = patr_area.area_c
  and   site.site_ref = comp.site_ref
