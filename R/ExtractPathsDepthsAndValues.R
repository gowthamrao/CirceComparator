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
#' @return A data frame with three columns: "path", "depth", and "value",
#'   where each row represents an element in the nested list.
#'
#' @export
extractPathsDepthsAndValues <- function(nestedList,
                                        currentPath = "",
                                        depth = 1,
                                        item = NULL) {
  results <- extractPathsDepthsAndValuesPrivate(
    nestedList = nestedList,
    currentPath = currentPath,
    depth = depth,
    item = item
  )

  results <- results |>
    tibble::rownames_to_column(var = "rowName") |>
    dplyr::tibble()

  return(results)
}



extractPathsDepthsAndValuesPrivate <- function(nestedList, currentPath, depth, item) {
  results <- list()  # Initialize an empty list to store results
  
  for (i in seq_along(nestedList)) {
    
    name <- names(nestedList)[i]
    if (is.null(name) || name == "") {
      name <- "_" # Use "_" for unnamed elements
    }
    newPath <- if (currentPath == "") {
      name
    } else {
      paste0(currentPath, "$", name)
    }
    
    if (is.list(nestedList[[i]])) {
      # Recurse into the nested list
      nestedResults <- extractPathsDepthsAndValuesPrivate(nestedList[[i]], newPath, depth + 1, item)
      results <- append(results, list(nestedResults))
    } else {
      # Store the path, depth, and value only if the name matches the item, or if item is NULL
      if (is.null(item) || name == item) {
        results <- append(results, list(
          data.frame(
            path = newPath,
            depth = depth,
            value = if (length(nestedList[[i]]) == 0) {
              ""  # Return an empty string if nestedList[[i]] is character(0)
            } else {
              dplyr::coalesce(as.character(nestedList[[i]]), "")
            },
            stringsAsFactors = FALSE
          )
        ))
      }
    }
  }
  
  # Combine all list elements into a single data frame
  if (length(results) > 0) {
    return(do.call(rbind, results))
  } else {
    return(
      data.frame(
        path = character(0),
        depth = integer(0),
        value = character(0),
        stringsAsFactors = FALSE
      )
    )
  }
}

