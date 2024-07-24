#' Get Initial Event Limit
#'
#' This function retrieves the initial event limit from the primary criteria of an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A character string representing the initial event limit used in the primary criteria.
#' @export
getInitialEventLimit <- function(cohortDefinition) {
  # this is the limit used first part of entry event criteria
  cohortDefinition$PrimaryCriteria$PrimaryCriteriaLimit |> as.character()
}
