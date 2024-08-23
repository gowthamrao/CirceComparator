#' Parse OHDSI Circe Cohort Definition Specifications
#'
#' This function parses various specifications from an OHDSI Circe cohort definition, including censor window,
#' collapse settings, cohort exit strategy, and several other cohort entry event criteria.
#'
#' @param cohortDefinition A list representing the OHDSI Circe cohort definition.
#' @return A tibble containing the parsed cohort definition specifications.
#' @export
parseCohortDefinitionSpecifications <- function(cohortDefinition) {
  censorWindow <-
    readCensorWindow(cohortDefinition = cohortDefinition)

  collapseSettings <-
    readCollapseSettings(cohortDefinition = cohortDefinition)

  cohortExit <- readCohortExit(cohortDefinition = cohortDefinition)

  numberOfInclusionRules <-
    getNumberOfInclusionRules(cohortDefinition = cohortDefinition)

  initialEventLimit <-
    getInitialEventLimit(cohortDefinition = cohortDefinition)

  initialEventRestrictionAdditionalCriteria <-
    hasInitialEventRestrictionAdditionalCriteria(cohortDefinition = cohortDefinition)

  # qualifying limit is part of entry event criteria. Its the second limit if initialEventRestrictionAdditionalCriteria Exits
  # this is the restrict initial events part of entry event criteria
  initialEventRestrictionAdditionalCriteriaLimit <-
    getInitialEventRestrictionAdditionalCriteriaLimit(cohortDefinition = cohortDefinition)

  numberOfCohortEntryEvents <-
    getNumberOfCohortEntryEvents(cohortDefinition = cohortDefinition)
  domainsInEntryEventCriteria <-
    getDomainsInEntryEvents(cohortDefinition = cohortDefinition)
  continousObservationRequirement <-
    getContinuousPriorObservationPeriodRequirement(cohortDefinition = cohortDefinition)
  numberOfConceptSets <-
    getNumberOfConceptSets(cohortDefinition = cohortDefinition)

  demographicCriteria <-
    checkIfObjectExistsInNestedList(nestedList = cohortDefinition, object = "DemographicCriteriaList") |> as.integer()
  demographicCriteriaAge <-
    checkIfObjectExistsInNestedList(nestedList = cohortDefinition, object = "Age") |> as.integer()
  demographicCriteriaGender <-
    checkIfObjectExistsInNestedList(nestedList = cohortDefinition, object = "Gender") |> as.integer()
  domainsInEntryEvents <-
    paste0(domainsInEntryEventCriteria$uniqueDomains, collapse = ", ")

  useOfObservationPeriodInclusionRule <-
    checkIfObjectExistsInNestedList(
      nestedList = cohortDefinition,
      object = "ObservationPeriod"
    ) |> as.integer()

  restrictedByVisit <-
    areCohortEventsRestrictedByVisit(cohortDefinition = cohortDefinition) |> as.integer()

  hasWashoutInText <-
    stringPresentInCohortDefinitionText(
      cohortDefinition = cohortDefinition,
      textToSearch = "washout"
    ) |> as.integer()

  hasConditionStatusInPrimaryCriteria <-
    stringPresentInCohortDefinitionText(
      cohortDefinition = cohortDefinition$PrimaryCriteria,
      textToSearch = "ConditionStatus"
    ) |> as.integer()

  hasConditionTypeInPrimaryCriteria <-
    stringPresentInCohortDefinitionText(
      cohortDefinition = cohortDefinition$PrimaryCriteria,
      textToSearch = "ConditionType"
    ) |> as.integer()

  hasProcedureTypeInPrimaryCriteria <-
    stringPresentInCohortDefinitionText(
      cohortDefinition = cohortDefinition$PrimaryCriteria,
      textToSearch = "ProcedureType"
    ) |> as.integer()

  hasObservationTypeInPrimaryCriteria <-
    stringPresentInCohortDefinitionText(
      cohortDefinition = cohortDefinition$PrimaryCriteria,
      textToSearch = "ObservationType"
    ) |> as.integer()

  hasDrugTypeInPrimaryCriteria <-
    stringPresentInCohortDefinitionText(
      cohortDefinition = cohortDefinition$PrimaryCriteria,
      textToSearch = "DrugType"
    ) |> as.integer()

  hasConditionStatus <-
    stringPresentInCohortDefinitionText(
      cohortDefinition = cohortDefinition,
      textToSearch = "ConditionStatus"
    ) |> as.integer()

  hasConditionType <-
    stringPresentInCohortDefinitionText(
      cohortDefinition = cohortDefinition,
      textToSearch = "ConditionType"
    ) |> as.integer()

  hasProcedureType <-
    stringPresentInCohortDefinitionText(
      cohortDefinition = cohortDefinition,
      textToSearch = "ProcedureType"
    ) |> as.integer()

  hasObservationType <-
    stringPresentInCohortDefinitionText(
      cohortDefinition = cohortDefinition,
      textToSearch = "ObservationType"
    ) |> as.integer()

  hasDrugType <-
    stringPresentInCohortDefinitionText(
      cohortDefinition = cohortDefinition,
      textToSearch = "DrugType"
    ) |> as.integer()


  inclusionRuleQualifyingEventLimit <-
    getInclusionRuleQualifyingEventLimit(cohortDefinition = cohortDefinition)

  report <- dplyr::tibble(
    censorWindowStartDate =
      (if (length(censorWindow$censorWindowStartDate) > 0) {
        censorWindow$censorWindowStartDate
      } else {
        NA
      }),
    censorWindowEndDate =
      (if (length(censorWindow$censorWindowEndDateDate) > 0) {
        censorWindow$censorWindowEndDateDate
      } else {
        NA
      }),
    collapseSettingsType = collapseSettings$collapseType,
    collapseEraPad = collapseSettings$eraPad,
    exitStrategy = cohortExit$exitStrategy,
    exitDateOffSetField = cohortExit$dateOffSetField,
    exitDateOffSet = cohortExit$dateOffSet,
    exitDrugCodeSetId = cohortExit$drugCodeSetId,
    exitPersistenceWindow = cohortExit$persistenceWindow,
    exitSurveillanceWindow = cohortExit$surveillanceWindow,
    numberOfInclusionRules = numberOfInclusionRules,
    initialEventLimit = initialEventLimit,
    initialEventRestrictionAdditionalCriteria = initialEventRestrictionAdditionalCriteria,
    initialEventRestrictionAdditionalCriteriaLimit = initialEventRestrictionAdditionalCriteriaLimit,
    # this is the restrict initial events part of entry event criteria
    inclusionRuleQualifyingEventLimit = inclusionRuleQualifyingEventLimit,
    numberOfCohortEntryEvents = numberOfCohortEntryEvents,
    numberOfDomainsInEntryEvents = domainsInEntryEventCriteria$numberOfUniqueDomains,
    domainsInEntryEvents = domainsInEntryEvents,
    continousObservationWindowPrior = continousObservationRequirement$priorDays,
    continousObservationWindowPost = continousObservationRequirement$postDays,
    numberOfConceptSets = numberOfConceptSets,
    demographicCriteria = demographicCriteria,
    demographicCriteriaAge = demographicCriteriaAge,
    demographicCriteriaGender = demographicCriteriaGender,
    useOfObservationPeriodInclusionRule = useOfObservationPeriodInclusionRule,
    restrictedByVisit = restrictedByVisit,
    hasWashoutInText = hasWashoutInText,
    cohortNameFromWebApi = cohortDefinition$name,
    cohortIdFromWebApi = cohortDefinition$id,
    hasConditionStatusInPrimaryCriteria = hasConditionStatusInPrimaryCriteria,
    hasConditionTypeInPrimaryCriteria = hasConditionTypeInPrimaryCriteria,
    hasProcedureTypeInPrimaryCriteria = hasProcedureTypeInPrimaryCriteria,
    hasObservationTypeInPrimaryCriteria = hasObservationTypeInPrimaryCriteria,
    hasDrugTypeInPrimaryCriteria = hasDrugTypeInPrimaryCriteria,
    hasConditionStatus = hasConditionStatus,
    hasConditionType = hasConditionType,
    hasProcedureType = hasProcedureType,
    hasObservationType = hasObservationType,
    hasDrugType = hasDrugType
  )

  if (nrow(domainsInEntryEventCriteria$domains) > 0) {
    report <- report |>
      tidyr::crossing(domainsInEntryEventCriteria$domains)
  }

  sourceDomains <-
    c(
      "ProcedureSourceConcept",
      "ConditionSourceConcept",
      "ObservationSourceConcept",
      "VisitSourceConcept",
      "DrugSourceConcept",
      "DeviceSourceConcept",
      "DeathSourceConcept",
      "MeasurementSourceConcept"
    )

  demographics <- c(
    "Age",
    "Gender"
  )
  typeConcepts <- c("VisitType")
  # measurement <-
  #   c(
  #     "ValueAsConcept",
  #     "Operator",
  #     "ValueAsNumber",
  #     "Op",
  #     "RangeLow",
  #     "RangeHigh",
  #     "RangeLowRatio",
  #     "RangeHighRatio"
  #   )
  other <- c("PlaceOfServiceCS", "ProviderSpecialty", "First")

  combined <-
    c(sourceDomains, demographics, typeConcepts, other) |> unique()
  for (i in (1:length(combined))) {
    whereExists <-
      extractPathsDepthsAndValues(nestedList = cohortDefinition, item = combined[[i]])

    if (nrow(whereExists) > 0) {
      browser()
      report <- report |>
        tidyr::crossing(whereExists)
    }
  }

  report <- report |>
    dplyr::mutate(
      eventCohort =
        dplyr::if_else(
          condition = (
            initialEventLimit == "All" &
              initialEventRestrictionAdditionalCriteriaLimit == "All" &
              inclusionRuleQualifyingEventLimit == "All"
          ),
          true = 1,
          false = 0
        )
    )

  return(report)
}
