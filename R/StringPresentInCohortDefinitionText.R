#' Check if a string is present in a cohort definition text
#'
#' This function checks if a given string is present within the text of a cohort definition.
#'
#' @param cohortDefinition A list representing the cohort definition, which will be converted to JSON.
#' @param textToSearch A character string to search for within the cohort definition text.
#' @param negate 	If TRUE, checks for the absence of text.
#' @param caseInsensitve If TRUE, looks for textToSearch in case insensitive manner.
#' @return A logical value indicating whether the textToSearch is present in the cohort definition text.
#' @export
stringPresentInCohortDefinitionText <-
  function(cohortDefinition,
           textToSearch,
           negate = FALSE,
           caseInsensitve = TRUE) {
    pathDepthsAndValues <- extractPathsDepthsAndValues(nestedList = cohortDefinition)
    
    if (caseInsensitve) {
      pathDepthsAndValues <- pathDepthsAndValues |>
        dplyr::mutate(value = tolower(value))
      
      textToSearch = tolower(textToSearch)
    }
    
    output <- pathDepthsAndValues |>
      dplyr::filter(stringr::str_detect(
        string = value,
        pattern = textToSearch,
        negate = negate
      ))
    
    return(nrow(output) > 0)
  }
