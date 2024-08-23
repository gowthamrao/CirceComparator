#' Check for Initial Event Restriction Additional Criteria
#'
#' This function checks if there are additional criteria for initial event restrictions in an OHDSI Circe cohort definition.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A logical value indicating whether additional criteria for initial event restrictions exist.
#' @export
hasInitialEventRestrictionAdditionalCriteria <-
  function(cohortDefinition) {
    pathDepthsAndValues <- extractPathsDepthsAndValues(nestedList = cohortDefinition)

    result <- pathDepthsAndValues |>
      dplyr::filter(stringr::str_detect(string = .data$path, pattern = "AdditionalCriteria")) |>
      nrow() > 1

    return(result)
  }
