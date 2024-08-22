#' Check if an Object Exists in a Nested List
#'
#' This function checks whether a specified object exists within a nested list.
#'
#' @param nestedList A nested list in which to search for the object.
#' @param object A character string specifying the name of the object to search for.
#' @return A logical value indicating whether the object exists within the nested list.
#' @export
checkIfObjectExistsInNestedList <- function(nestedList, object) {
  # Use extractPathsAndDepths to find all paths for the specified object
  pathsAndDepths <- extractPathsAndDepths(nestedList, item = object)
  
  # If the length of the result is greater than 0, the object exists
  return(length(pathsAndDepths) > 0)
}
