CREATE TABLE `your_project.your_dataset.cdmDatabaseSchema.VISIT_OCCURRENCE` (
  `visit_occurrence_id` INT64,
  `person_id` INT64,
  `visit_concept_id` INT64,
  `visit_start_date` DATE,
  `visit_start_datetime` DATETIME,
  `visit_end_date` DATE,
  `visit_end_datetime` DATETIME,
  `visit_type_concept_id` INT64,
  `provider_id` INT64,
  `care_site_id` INT64,
  `visit_source_value` STRING(50),
  `visit_source_concept_id` INT64,
  `admitted_from_concept_id` INT64,
  `admitted_from_source_value` STRING(50),
  `discharged_to_concept_id` INT64
)

