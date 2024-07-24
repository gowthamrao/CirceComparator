#' @export
getInclusionRuleQualifyingEventLimit <- function(cohortDefinition) {
  cohortDefinition$ExpressionLimit |> as.character()
}
