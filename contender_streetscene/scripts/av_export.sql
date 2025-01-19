UNLOAD TO "av_export.csv"
SELECT
	comp.complaint_no,
	comp.date_entered,
	comp.site_ref,
	comp.location_c,
	comp.easting,
	comp.northing,
	comp_av.car_id,
	makes.make_desc,
	models.model_desc,
	colour.colour_desc,
	comp.action_flag,
	comp_av.officer_id
FROM
	universe.colour colour,
	universe.comp comp,
	universe.comp_av comp_av,
	universe.makes makes,
	universe.models models
WHERE
	comp.complaint_no = comp_av.complaint_no
    AND
	comp_av.make_ref = makes.make_ref
    AND
	comp_av.model_ref = models.model_ref
    AND
	comp_av.colour_ref = colour.colour_ref
    AND
	comp.date_closed IS NULL;
