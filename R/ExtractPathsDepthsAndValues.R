#' Extract Paths, Depths, and Values from a Nested List
#'
#' This function recursively traverses a nested list in R and returns the paths,
#' depths, and values of each element. Optionally, you can filter the results to only
#' include elements with a specific name. Unnamed elements are represented by
#' a special character "_".
#'
#' @param nestedList A nested list object from which to extract paths, depths, and values.
#' @param currentPath A character string representing the current path during recursion.
#'   Defaults to an empty string. This parameter is primarily used internally by the function.
#' @param depth An integer representing the current depth of the recursion.
#'   Defaults to 1. This parameter is primarily used internally by the function.
#' @param item An optional character string specifying the name of the item to look for.
#'   If provided, the function will return only the paths, depths, and values for elements
#'   matching this name. If `NULL`, all elements are included. Defaults to `NULL`.
#'
#' @return A data frame with three columns: "Path", "Depth", and "Value",
#'   where each row represents an element in the nested list.
#'
#' @export
extractPathsDepthsAndValues <- function(nestedList,
                                        currentPath = "",
                                        depth = 1,
                                        item = NULL) {
  results <- data.frame(
    path = character(0),
    depth = integer(0),
    value = character(0),
    stringsAsFactors = FALSE
  )
  
  for (i in seq_along(nestedList)) {
    name <- names(nestedList)[i]
    if (is.null(name) || name == "") {
      name <- "_"  # Use "_" for unnamed elements
    }
    newPath <- if (currentPath == "")
      name
    else
      paste0(currentPath, "$", name)
    
    if (is.list(nestedList[[i]])) {
      # Recurse into the nested list
      results <- rbind(results,
                       extractPathsDepthsAndValues(nestedList[[i]], newPath, depth + 1, item))
    } else {
      # Store the path, depth, and value only if the name matches the item, or if item is NULL
      if (is.null(item) || name == item) {
        results <- rbind(
          results,
          data.frame(
            path = newPath,
            depth = depth,
            value = nestedList[[i]],
            stringsAsFactors = FALSE
          )
        )
      }
    }
  }
  
  return(results)
}
