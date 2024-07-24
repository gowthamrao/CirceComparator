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
