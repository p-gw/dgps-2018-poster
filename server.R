library(data.table)
library(limer)
library(ggplot2)
library(scales)
library(shinyjs)
library(geosphere)
library(htmlwidgets)
library(leaflet)

source("credentials.R", local = TRUE)
source("functions/datenaufbereitung.R", local = TRUE)
source("functions/ts_datenaufbereitung.R", local = TRUE)

shinyServer(function(input, output, session) {
  shinyjs::useShinyjs(html = TRUE)

  # Einstiegsoptionen Limesurvey
  options(lime_api = api_url)
  options(lime_username = lime_user)
  options(lime_password = lime_pw)

  get_session_key()

  # Ractive Values initialisieren
  RV <- reactiveValues(data = NULL, ts_data = NULL, autoupdate_interval = NULL)

  t <- 0
  progress <- Progress$new(session, min = 0, max = 10)

  progress$set(message = "Automatisches Update")

  # Erstes laden der Daten
  responses <- tryCatch(
    get_responses(
      survey_id,
      sDocumentType = "csv",
      sLanguageCode = "de",
      sCompletionStatus = "all",
      sHeadingType = "code",
      sResponseType = "long"
    ),
    error = function(e) NULL
  )

  if (!is.null(responses)) {
    if (nrow(responses) == 0) {
      responses <- NULL
    }
  }
  RV$data <- datenaufbereitung(responses)
  RV$ts_data <- ts_datenaufbereitung(responses)

  # Dialog zur Abfrage der Rater am Beginn
  # source("init_modal.R", local = TRUE)

  ### OUTPUTS ###
  source("timeseries.R", local = TRUE)
  source("scatter.R", local = TRUE)
  source("map.R", local = TRUE)

  ### INPUTS ###
  # Fortschritt Tab
  source("input_fortschritt.R", local = TRUE)

  # Einstellungs Tab
  source("input_options.R", local = TRUE)

})
