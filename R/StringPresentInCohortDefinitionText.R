#' Check if a string is present in a cohort definition text
#'
#' This function checks if a given string is present within the text of a cohort definition.
#'
#' @param cohortDefinition A list representing the cohort definition, which will be converted to JSON.
#' @param textToSearch A character string to search for within the cohort definition text.
#' @return A logical value indicating whether the textToSearch is present in the cohort definition text.
#' @export
stringPresentInCohortDefinitionText <-
  function(cohortDefinition, textToSearch) {
    output <- cohortDefinition |>
      RJSONIO::toJSON(digits = 23) |>
      tolower() |>
      stringr::str_trim() |>
      stringr::str_squish() |>
      stringr::str_detect(pattern = textToSearch |>
        tolower() |>
        stringr::str_trim() |>
        stringr::str_squish())

    return(output)
  }
