CREATE TABLE cdmdatabaseschema.visit_occurrence (
    visit_occurrence_id integer NOT NULL,
    person_id integer NOT NULL,
    visit_concept_id integer NOT NULL,
    visit_start_date date NOT NULL,
    visit_start_datetime timestamp NULL,
    visit_end_date date NOT NULL,
    visit_end_datetime timestamp NULL,
    visit_type_concept_id integer NOT NULL,
    provider_id integer NULL,
    care_site_id integer NULL,
    visit_source_value varchar(50) NULL,
    visit_source_concept_id integer NULL,
    admitted_from_concept_id integer NULL,
    admitted_from_source_value varchar(50) NULL,
    discharged_to_concept_id integer NULL
);
