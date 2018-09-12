datenaufbereitung <- function(data) {
  if (!is.null(data)) {
    data <- as.data.table(data)
    setnames(data, "Map", "map")
    data[, c("lat", "long") := tstrsplit(map, ";")]
    data[, c("lat", "long") := .(as.numeric(lat), as.numeric(long))]
    loc <- c(50.127, 8.667)
    for (i in 1:nrow(data)) {
      set(data, i, "dist", distHaversine(data[i, c(lat, long),], loc)/1000)
    }
    data[, "label" := paste0("Distanz: ", round(dist, 0), "km")]
  } else {
    data <- data.table(
      "id" = integer(),
      "submitdate" = character(),
      "lastpage" = integer(),
      "startlanguage" = character(),
      "seed" = integer(),
      "startdate" = character(),
      "datestamp" = character(),
      "Gesellschaftsabend" = character(),
      "SozialesUmfeld" = integer(),
      "map" = character(),
      "lat" = numeric(),
      "long" = numeric(),
      "dist" = numeric(),
      "label" = character()
    )
  }
  return(data)
}
