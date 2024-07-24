#' Get Continuous Prior Observation Period Requirement
#'
#' This function retrieves the continuous prior observation period requirements from an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A list containing the prior and post days of the observation window.
#' @export
getContinuousPriorObservationPeriodRequirement <-
  function(cohortDefinition) {
    priorDays <-
      as.integer(cohortDefinition$PrimaryCriteria$ObservationWindow[["PriorDays"]])
    postDays <-
      as.integer(cohortDefinition$PrimaryCriteria$ObservationWindow[["PostDays"]])
    output <- c()
    output$priorDays <- priorDays
    output$postDays <- postDays
    return(output)
  }
