#' Get Domains in Cohort Entry Events
#'
#' This function retrieves the unique domains present in the cohort entry events of an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A list containing the unique domains, the number of unique domains, and a tibble indicating the presence of each domain.
#' @export
getDomainsInEntryEvents <- function(cohortDefinition) {
  cohortEntryEvents <-
    getNumberOfCohortEntryEvents(cohortDefinition = cohortDefinition)

  domains <- c()
  for (i in (1:cohortEntryEvents)) {
    domains[i] <-
      names(cohortDefinition$PrimaryCriteria$CriteriaList[[i]])
  }

  uniqueDomains <- unique(domains) |> sort()

  output <- c()
  output$uniqueDomains <- uniqueDomains
  output$numberOfUniqueDomains <- length(uniqueDomains)
  output$domains <-
    dplyr::tibble(uniqueDomains) |>
    dplyr::mutate(value = 1) |>
    tidyr::pivot_wider(
      names_from = "uniqueDomains",
      names_prefix = "domain",
      values_from = "value",
      values_fill = 0
    )
  return(output)
}
