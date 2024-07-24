#' Parse Collapse Settings from OHDSI Circe Cohort Definition
#'
#' This function parses the collapse settings from an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A list containing the parsed collapse settings, including `collapseType` and `eraPad`.
#' @export
readCollapseSettings <- function(cohortDefinition) {
  output <- list()
  output$collapseType <-
    cohortDefinition$CollapseSettings$CollapseType
  output$eraPad <- cohortDefinition$CollapseSettings$EraPad
  return(output)
}
