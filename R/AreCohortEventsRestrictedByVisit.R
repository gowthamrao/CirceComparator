#' Check if Cohort Events are Restricted by Visit
#'
#' This function checks if cohort events are restricted by visit occurrence in an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A logical value indicating whether cohort events are restricted by visit occurrence.
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
