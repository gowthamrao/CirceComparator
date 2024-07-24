#' Get Number of Inclusion Rules
#'
#' This function retrieves the number of inclusion rules defined in an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return An integer representing the number of inclusion rules.
#' @export
getNumberOfInclusionRules <- function(cohortDefinition) {
  length(cohortDefinition$InclusionRules)
}
