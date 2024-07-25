#' Get Concept Set Definition Set from Cohort Definition
#'
#' This function returns a data frame with conceptSetId, conceptSetName, etc
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A data frame
#' @export
extractConceptSetsInCohortDefinition <- function(cohortDefinition) {
  ConceptSetDiagnostics::extractConceptSetsInCohortDefinition(cohortExpression = cohortDefinition)
}
