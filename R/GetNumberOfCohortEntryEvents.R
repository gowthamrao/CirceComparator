#' Get Number of Cohort Entry Events
#'
#' This function retrieves the number of entry events defined in the primary criteria of an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return An integer representing the number of cohort entry events.
#' @export
getNumberOfCohortEntryEvents <- function(cohortDefinition) {
  cohortDefinition$PrimaryCriteria$CriteriaList |> length()
}
