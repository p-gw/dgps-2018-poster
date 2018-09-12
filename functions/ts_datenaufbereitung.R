ts_datenaufbereitung <- function(data, startdate = as.POSIXct("2018-09-11 00:00:00", format = "%Y-%m-%d %H:%M:%S")) {
  if (!is.null(data)) {
    data <- as.data.table(data)
    data[, "datestamp" := as.POSIXct(datestamp, format = "%Y-%m-%d %H:%M:%S")]
    data[, "complete" := ifelse(submitdate == "", "unvollständig", "vollständig")]
    data <- data[, .N, by = .(datestamp, complete)]
    data[, "cumsum" := cumsum(N), by = complete]
    # Fuege Maximum hinzu
    max <- data[, .("datestamp" = Sys.time(), "N" = 0, "cumsum" = max(cumsum)), by = complete]
    setcolorder(max, names(data))
    data <- rbindlist(list(data, max))
  } else {
    data <- data.table(datastamp = character(), complete = character(), N = integer(), cumsum = integer())
  }
  # add startdates
  data <- rbindlist(list(
    list(startdate, "unvollständig", 0, 0),
    list(startdate, "vollständig", 0, 0),
    data
  ))
  return(data)
}
