#' Parse Censor Window from OHDSI Circe Cohort Definition
#'
#' This function parses the censor window dates from an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A list containing the parsed censor window start and end dates.
#' @export
readCensorWindow <- function(cohortDefinition) {
  output <- c()

  if (!is.null(cohortDefinition$CensorWindow[["StartDate"]])) {
    output$censorWindowStartDate <-
      as.Date(cohortDefinition$CensorWindow[["StartDate"]])
  }

  if (!is.null(cohortDefinition$CensorWindow[["EndDate"]])) {
    output$censorWindowEndDateDate <-
      as.Date(cohortDefinition$CensorWindow[["EndDate"]])
  }

  if (length(output) == 0) {
    output <- NULL
  }
  return(output)
}
