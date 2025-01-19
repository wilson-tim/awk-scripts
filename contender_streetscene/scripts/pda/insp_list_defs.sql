-- The defaults
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
         def_cont_i.action,
         comp.item_ref,
         comp.site_ref,
         comp.postcode,
         site.site_name_1,
         site.ward_code,
         defi_rect.rectify_date, 
         defi_rect.rectify_time_h,
         defi_rect.rectify_time_m,
         defi_rect.rectify_time_h,
         defi_rect.rectify_time_m,
         comp.recvd_by,
         comp.comp_code,
         pda_user.user_name 
  from defh, defi_rect, def_cont_i, comp, site, patr_area, pda_user
  where comp.action_flag = 'D'
  and   comp.date_closed is null
  and   patr_area.po_code = pda_user.po_code
  and   patr_area.pa_site_flag = 'P'
  and   comp.pa_area = patr_area.area_c
  and   defh.cust_def_no = comp.dest_ref
  and   defh.default_status = 'Y'
  and   def_cont_i.cust_def_no = comp.dest_ref
  and   defi_rect.default_no = comp.dest_ref
  and   site.site_ref = comp.site_ref
  and   defi_rect.seq_no =
   ( select max(seq_no)
     from defi_rect
     where defi_rect.default_no = comp.dest_ref
   )
