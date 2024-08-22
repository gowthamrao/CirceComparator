#' Extract Paths and Depths from a Nested List
#'
#' This function recursively traverses a nested list in R and returns the paths
#' and depths of each element. Optionally, you can filter the results to only
#' include elements with a specific name.
#'
#' @param lst A nested list object from which to extract paths and depths.
#' @param currentPath A character string representing the current path during recursion.
#'   Defaults to an empty string. This parameter is primarily used internally by the function.
#' @param depth An integer representing the current depth of the recursion.
#'   Defaults to 1. This parameter is primarily used internally by the function.
#' @param item An optional character string specifying the name of the item to look for.
#'   If provided, the function will return only the paths and depths for elements
#'   matching this name. If `NULL`, all elements are included. Defaults to `NULL`.
#'
#' @return A named list where each name represents the path to an element,
#'   and each value represents the depth of that element within the nested structure.
#' @export
extractPathsAndDepths <- function(lst,
                                  currentPath = "",
                                  depth = 1,
                                  item = NULL) {
  results <- list()
  
  for (name in names(lst)) {
    newPath <- if (currentPath == "")
      name
    else
      paste0(currentPath, "$", name)
    
    if (is.list(lst[[name]])) {
      # Recurse into the nested list
      results <- c(results,
                   extractPathsAndDepths(lst[[name]], newPath, depth + 1, item))
    } else {
      # Store the path and depth only if the name matches the item, or if item is NULL
      if (is.null(item) || name == item) {
        results[[newPath]] <- depth
      }
    }
  }
  
  return(results)
}