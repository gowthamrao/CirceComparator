#' @export
areCohortEventsRestrictedByVisit <-
  function(cohortDefinition) {
    if (!"VisitOccurrence" %in% getDomainsInEntryEvents(cohortDefinition = cohortDefinition)) {
      checkIfObjectExistsInNestedList(
        nestedList = cohortDefinition,
        object = "VisitOccurrence"
      )
    } else {
      FALSE
    }
  }
