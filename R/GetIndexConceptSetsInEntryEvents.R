#' Get Concept Set used in Cohort Entry Events
#'
#' This function retrieves the concept set id for the concept sets used in entry event criteria.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A list containing the unique domains, the number of unique domains, and a tibble indicating the presence of each domain.
#' @export
getIndexConceptSetsInEntryEvents <- function(cohortDefinition) {
  conceptSetsInCohortDefinition <-
    extractConceptSetsInCohortDefinition(cohortDefinition)
  
  cohortEntryEvents <-
    getNumberOfCohortEntryEvents(cohortDefinition = cohortDefinition)
  
  conceptSetsInEntryEventCriteria <- c()
  for (i in (1:cohortEntryEvents)) {
    conceptSetsInEntryEventCriteria[[i]] <-
      dplyr::tibble(
        conceptSetId = cohortDefinition$PrimaryCriteria$CriteriaList[[i]][[1]]$CodesetId,
        codeSetDomainName = names(cohortDefinition$PrimaryCriteria$CriteriaList[[i]])
      )
  }
  
  conceptSetsInCohortDefinition <- conceptSetsInCohortDefinition |>
    dplyr::inner_join(conceptSetsInEntryEventCriteria |> dplyr::bind_rows(),
                      by = "conceptSetId")
  
  return(conceptSetsInCohortDefinition)
}