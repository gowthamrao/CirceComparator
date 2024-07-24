#' @export
getNumberOfConceptSets <- function(cohortDefinition) {
  length(cohortDefinition$ConceptSets) |> as.integer()
}
