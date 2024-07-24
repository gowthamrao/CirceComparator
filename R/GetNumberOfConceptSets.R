#' Get Number of Concept Sets
#'
#' This function retrieves the number of concept sets defined in an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return An integer representing the number of concept sets.
#' @export
getNumberOfConceptSets <- function(cohortDefinition) {
  length(cohortDefinition$ConceptSets) |> as.integer()
}
