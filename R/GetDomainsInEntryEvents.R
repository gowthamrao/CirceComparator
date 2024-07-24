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
