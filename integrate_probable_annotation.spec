/*
A KBase module: integrate_probable_annotation
This module intergrate probable annoation into a genome object.
*/

module integrate_probable_annotation {

	/*
	A string representing a genome id.
	*/

	typedef string genome_id;
	/*
	A string representing a output genome id.
	*/

	typedef string outputGenome;
	/*
	A string representing a workspace name.
	*/

	typedef string workspace_name;

	/*
	A string representing a missing Role data.
	*/

	typedef string missing_role_data;

	typedef structure {
		string role_description;
		float perc_identity;
		int genome_hits;
		string hit_location;
		string blast_score;
		string protein_sequence;

	} MissingRolesData;

	typedef structure {
	   list <MissingRolesData> missingRoles;
	} missingRoleHits;


	funcdef integrate_annotation(workspace_name, genome_id, missing_role_data, outputGenome)  returns (missingRoleHits) authentication required;
};