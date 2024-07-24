#' Get Inclusion Rule Qualifying Event Limit
#'
#' This function retrieves the inclusion rule qualifying event limit from an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A character string representing the inclusion rule qualifying event limit.
#' @export
getInclusionRuleQualifyingEventLimit <- function(cohortDefinition) {
  cohortDefinition$ExpressionLimit |> as.character()
}
