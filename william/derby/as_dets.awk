BEGIN {
  id=18043
}

{
  for (i=17977; i<=18011; i++) { 
    print "insert into as_dets select '" id "',down_time,no_failures,hours_run_per_wk,repair_time,start_date,bms_ref_fld,rely_stats_req,'" $1 "',building_code,locat_code,management_unit,asset_no,sub_asset_no,asset_name,asset_type," "statutory_item,manufacturer,supplier_code,order_no,acceptance_date," "warranty_expiry,price,serial_no,model_no,est_replace_year,indexed_rep_cost,locat_ref," "contract_pm_job,price_index_type,cost_centre,workshop,del_pm_job_flag," "charg_cost_cent,account_code,date_last_comp,date_next_due,labour_cost_pr," "material_cost_pr,purchase_cost_pr,contract_cost_pr," $2 ",labour_cost_yt,building_code_bt," "locat_bt1,locat_bt2,asset_no_bt1,asset_no_bt2,sub_asset_no_bt,utilisation_cat," "material_cost_yt,purchase_cost_yt,contract_cost_yt,priority_code," "maintenance_plan,resp_serv_level,phoenix_code,down_serv_level,risk_code,rfid_tag_no," "date_job_last_comp,asset_status from as_dets where asset_id = '" i "';"
  id++
  }
}

END {}
