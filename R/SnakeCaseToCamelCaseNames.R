snakeCaseToCamelCaseNames <- function (object) {
  names(object) <- snakeCaseToCamelCase(names(object))
  return(object)
}


snakeCaseToCamelCase <- function (string) {
  string <- tolower(string)
  for (letter in letters) {
    string <- gsub(paste("_", letter, sep = ""), toupper(letter), string)
  }
  string <- gsub("_([0-9])", "\\1", string)
  return(string)
}