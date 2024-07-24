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
