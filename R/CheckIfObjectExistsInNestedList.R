#' @export
checkIfObjectExistsInNestedList <- function(nestedList,
                                            object) {
  if (is.list(nestedList)) {
    if (object %in% names(nestedList)) {
      return(TRUE)
    } else {
      for (subList in nestedList) {
        if (checkIfObjectExistsInNestedList(nestedList = subList, object = object)) {
          return(TRUE)
        }
      }
    }
  }
  return(FALSE)
}
