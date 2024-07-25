#' Identify Locations of an Object in a Nested List
#'
#' This function identifies the locations of a specified object within a nested list.
#'
#' @param nestedList A nested named list in which to search for the object.
#' @param object A character string specifying the name of the object to search for.
#' @return A tibble indicating the locations where the object exists within the nested list.
#' @export
getWhereAnObjectExistsInNestedList <- function(nestedList,
                                               object) {
  namedItems <- c()
  for (i in (1:length(nestedList))) {
    if (checkIfObjectExistsInNestedList(nestedList = nestedList[[i]], object = object)) {
      namedItems <- c(namedItems, names(nestedList)[[i]])
    }
  }
  
  namedItemsDf <- dplyr::tibble()
  
  if (length(namedItems) > 0) {
    namedItemsDf <-
      dplyr::tibble(namedItems = namedItems |> unique() |> sort()) |>
      dplyr::mutate(value = 1) |>
      dplyr::mutate(newName = paste0("criteriaLocation",
                                     object,
                                     namedItems)) |>
      dplyr::select(.data$newName,
                    .data$value) |>
      tidyr::pivot_wider(
        names_from  = "newName",
        values_from = "value",
        values_fill = 0
      )
  }
  return(namedItemsDf)
}
