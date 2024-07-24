#' @export
getNumberOfCohortEntryEvents <- function(cohortDefinition) {
  cohortDefinition$PrimaryCriteria$CriteriaList |> length()
}
