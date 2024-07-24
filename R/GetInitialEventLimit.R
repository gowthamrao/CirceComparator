#' @export
getInitialEventLimit <- function(cohortDefinition) {
  # this is the limit used first part of entry event criteria
  cohortDefinition$PrimaryCriteria$PrimaryCriteriaLimit |> as.character()
}
