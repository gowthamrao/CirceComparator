#' Get Initial Event Restriction Additional Criteria Limit
#'
#' This function retrieves the limit value for additional criteria used in initial event restriction of an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A character string representing the limit value for additional criteria in initial event restriction.
#'         If no additional criteria exist, the default value is "All".
#' @export
getInitialEventRestrictionAdditionalCriteriaLimit <- function(cohortDefinition) {
  # default Value is 'All' . It is only run if 'AdditionalCriteria' rule exits.
  if (hasInitialEventRestrictionAdditionalCriteria(cohortDefinition = cohortDefinition)) {
    limitValue <- cohortDefinition$QualifiedLimit |> as.character()
  } else {
    limitValue <- "All"
  }
  return(limitValue)
}
