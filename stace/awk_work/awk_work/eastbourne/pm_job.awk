# This is part of the aborted EASTBOURNE data conversion effort.
# This function picks out the asset_cost_centre from the Assets.txt using
# Asset_ID, Asset, and Sub from pm_job.txt.

function retreive_asset_cc(asset_id_ls, asset_ls, sub_ls,                                site_ls, get_owner_ls, asset_line_no_ls){

# Setting up the flag for whether the asset has been found or not.
   get_owner_ls="N"
   print "start"

# Start the loop to go through each line of the assets.txt file searching for
# the asset given to the function. 
   while((getline < "ASSETS.TXT") > 0){

   # This line checks to see if the line is the start of an asset record, and 
   # if it is then reset the asset record line counter to one (the start of the
   # asset record).
      if ($1=="Asset" && $2=="Register" && $3=="Maintenance"){
         asset_line_no_ls=1
      }

   # This line gets the site value and stores it in a variable.
      if($1=="Site" && asset_line_no_ls=4) site_ls=$2

   # This line matches the "asset id", "asset" and "sub" asset numbers for
   # the current asset record and sets the found asset flag to "Y" if they
   # match the asset supplied to the function.
      if($1=="Building" && asset_line_no_ls=5){
         if($(NF-2)==asset_ls && $(NF-1)==sub_ls && $(NF)==asset_id_ls){
            get_owner_ls="Y"
         }
      }

   # Return the asset owner (cost_centre) for the asset, if it is the asset
   # that was supplied to the function. 
      if($1=="Owner" && asset_line_no_ls==10 && get_owner_ls=="Y"){
         if($2 != ""){
            return substr($2,1,3) substr($2,4)}
         else{
            if(site_ls=="002") return "B01"
            if(site_ls=="003") return "D01"
            if(site_ls=="020") return "E01"
            if(site_ls=="090") return "B02"
            if(site_ls=="111") return "E01"
         }
      }
   # Increments the asset record line counter
      ++asset_line_no_ls
      print NR
   }
}
 
{print retreive_asset_cc("999","000","8054")}
