if (grepl("testthat", getwd())) {
  cohortPath <- "cohorts"
} else {
  cohortPath <- file.path("tests", "testthat", "cohorts")
}

cohort14907 <- readChar(
  file.path(cohortPath, "14907.json"),
  file.info(file.path(cohortPath, "14907.json"))$size
) |> RJSONIO::fromJSON(digits = 23)
cohort14906 <- readChar(
  file.path(cohortPath, "14906.json"),
  file.info(file.path(cohortPath, "14906.json"))$size
) |> RJSONIO::fromJSON(digits = 23)
