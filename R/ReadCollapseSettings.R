#' Parse Collapse Settings from OHDSI Circe Cohort Definition
#'
#' This function parses the collapse settings from an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A list containing the parsed collapse settings, including `collapseType` and `eraPad`.
#' @export
readCollapseSettings <- function(cohortDefinition) {
  pathDepthsAndValues <- extractPathsDepthsAndValues(nestedList = cohortDefinition)

  output <- list()
  output$collapseType <-
    pathDepthsAndValues |>
    dplyr::filter(path == "CollapseSettings$CollapseType") |>
    dplyr::pull(value)

  output$eraPad <-
    pathDepthsAndValues |>
    dplyr::filter(path == "CollapseSettings$EraPad") |>
    dplyr::pull(value)

  return(output)
}
