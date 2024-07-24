#' Parse Cohort Exit Strategy from OHDSI Circe Cohort Definition
#'
#' This function parses the cohort exit strategy from an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A list containing the parsed cohort exit strategy, including `exitStrategy`,
#'         `dateOffSetField`, `dateOffSet`, `drugCodeSetId`, `persistenceWindow`, and `surveillanceWindow`.
#' @export
readCohortExit <- function(cohortDefinition) {
  output <- c()
  if (is.null(cohortDefinition$EndStrategy)) {
    output$exitStrategy <- "end of continuous observation"
  } else if (!is.null(cohortDefinition$EndStrategy$DateOffset)) {
    output$exitStrategy <- "fixed duration relative to initial event"
    output$dateOffSetField <-
      cohortDefinition$EndStrategy$DateOffset$DateField
    output$dateOffSet <-
      cohortDefinition$EndStrategy$DateOffset$Offset
  } else if (!is.null(cohortDefinition$EndStrategy$CustomEra)) {
    output$exitStrategy <- "end of continuous drug exposure"
    output$drugCodeSetId <-
      cohortDefinition$EndStrategy$CustomEra[["DrugCodesetId"]]
    output$persistenceWindow <-
      cohortDefinition$EndStrategy$CustomEra[["GapDays"]]
    output$surveillanceWindow <-
      cohortDefinition$EndStrategy$CustomEra[["Offset"]]
  }
  return(output)
}
