# remotes::install_github("gowthamrao/CirceComparator", ref = "draft")
# remotes::install_github("OHDSI/ConceptSetDiagnostics", ref = "develop")

ROhdsiWebApi::authorizeWebApi(baseUrl = Sys.getenv("BaseUrl"), authMethod = "windows")

cohortDefinition <-
  ROhdsiWebApi::getCohortDefinition(cohortId = 17905, baseUrl = Sys.getenv("BaseUrl"))


# debug(CirceComparator::parseCohortDefinitionSpecifications)
parsed <-
  CirceComparator::parseCohortDefinitionSpecifications(cohortDefinition = cohortDefinition$expression)


d <-
  CirceComparator::getIndexConceptSetsInEntryEvents(cohortDefinition = cohortDefinition$expression)



