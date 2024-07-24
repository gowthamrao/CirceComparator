#' Parse Censor Window from OHDSI Circe Cohort Definition
#'
#' This function parses the censor window dates from an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A list containing the parsed censor window start and end dates.
#' @export
readCensorWindow <- function(cohortDefinition) {
  censorWindowStartDate <-
    as.Date(cohortDefinition$CensorWindow[["StartDate"]])
  censorWindowStartDate <-
    as.Date(cohortDefinition$CensorWindow[["EndDate"]])
  output <- c()
  output$censorWindowStartDate <- censorWindowStartDate
  output$censorWindowEndDateDate <- censorWindowStartDate
  return(output)
}
