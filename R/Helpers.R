#' Reads knmi standard file
#'
#' @param var type `[rr, evmk, rsds, tg, tn, tx]`
#' @param ifile filename
#' @return list with comments, header and observations
#' @export
ReadInput <- function(var, ifile) {

  if (! file.exists(ifile)) {
    err <- "Input file does not exist."
    flog.error(err)
    stop(err)
  }

  types <- c("rr", "evmk", "rsds", "tg", "tn", "tx")
  if (!(var %in% types)) {
    err <- "variable not defined."
    flog.error(err)
    stop(err)
  }

  flog.info("Reading reference data, file={%s}", ifile)
  # select lines with "#" from reference file
  H.comments <- scan(ifile, character(0), sep = "\n", quiet = TRUE)
  flog.debug("Scanning of the reference data returned n={%i} lines.", length(H.comments))
  H.comments <- H.comments[grep("#", H.comments)] # (only necessary for output file)

  obs         <- read.table(ifile, header = F)     # read reference data
  header      <- obs[which(obs[, 1] == 0), ]       # header met stations meta-data etc.
  header[, 1] <- paste0(rep(0, 8), collapse = "")  # "00000000"

  names(obs) <- c("date", as.integer(obs[1, -1])) # station names are read from first line
  obs        <- obs[which(obs[, 1] != 0), ]       # actual data
  flog.debug("obs colnames={%s}", paste(names(obs), collapse = ", "))

  input <- list(comments = H.comments, header = header, obs = obs)
  if (var == "rsds") {
    lon    <- as.numeric(header[4, -1])
    lat    <- as.numeric(header[5, -1])
    coords <- cbind(lat, lon)
    if (length(which(is.na(lat) == TRUE)) > 0) {
      err <- "Check input file: Latitude NOT (or not properly) provided."
      flog.error(err)
      stop(err)
    } else {
      input$coords <- coords
    }
  }
  structure(input, class = "knmiTF")
}

CheckPeriod <- function(p) {
  if (!p %in% c(2030, 2050, 2085)) {
    flog.error("p={%s} has to be a valid period", paste(p))
    stop("Period must be valid, i.e. 2030, 2050, or 2085")
  }
}

ReturnPackageVersion <- function(var) {
  switch(var,
         "tg"   =  flog.info("Running temperature transformation"),
         "tn"   =  flog.info("Running temperature transformation"),
         "tx"   =  flog.info("Running temperature transformation"),
         "rr"   =  flog.info("Running precipitation transformation"),
         "rsds" =  flog.info("Running radiation transformation"),
         "evmk" =  flog.info("Running evaporation transformation")
  )
  version <- paste0(packageVersion("knmitransformer"))
  flog.debug("Version={%s}", version)
  version
}

str.ext <- function(var, ch, n) {
  paste(var, substr(paste(rep(ch, n), collapse = ""), 1,
                    n - nchar(var)), sep = "")
}

ReadChangeFactors <- function(var, scenario, period, subscenario = NULL) {
  if (period == "2030") {
    if (var == "rsds") {
      tmpPath <- "deltas-KNMI14__rsds_____2030.txt"
    } else {
      tmpPath <- paste("deltas-KNMI14__", var, "_______2030.txt", sep = "")
    }
  } else {
    if (var == "rsds") {
      tmpPath <- "deltas-KNMI14__rsds_"
    } else {
      tmpPath <- paste0("deltas-KNMI14__", var, "___")
    }
    tmpPath <- paste(tmpPath,
                     str.ext(scenario, "_", 3), "_",
                     str.ext(period, "_", 4), ".txt", sep = "")
  }

  flog.info("Reading deltas, file={%s}", tmpPath)
  tmpPath <- system.file("extdata", tmpPath, package = "knmitransformer")
  deltas  <- read.table(tmpPath, header = T)

  if (var == "rr") {
    flog.info("Subscenario={%s}", subscenario)
    # choose subscenario ("lower", "centr" or "upper")
    deltas$P99 <- deltas[, paste("p99", subscenario, sep = ".")]
  }
  deltas
}

PrepareOutput <- function(df, var, header, rounding) {
  V1 <- NULL
  if (rounding) {
    switch(var,
           "rsds" = df[, -1] <- round(df[, -1]),
           "evmk" = df[, -1] <- round(df[, -1], 2),
           df[, -1] <- round(df[, -1], 1))
  }
  df <- as.data.table(df) # nolint
  result <- rbind(header, df, use.names = FALSE)
  result[, V1 := as.integer(V1)]
  result
}

WriteOutput <- function(var, ofile, version, sc, p, H.comments, dat,
                        subscenario = NULL, userProvided = TRUE) {
  flog.info("Write output")
  sink(ofile)

  # comments
  if (var == "rsds") {
    writeLines("# Transformed daily mean global radiation [kJ/m2]")
  } else if (var %in% c("tg", "tn", "tx")) {
    writeLines("# Transformed daily temperature [deg.C]")
  } else if (var == "rr") {
    writeLines("# Transformed daily precipitation sums [mm]")
  } else if (var == "evmk") {
    writeLines("# Transformed daily Makkink evaporation [mm]")
  }
  writeLines("# according to KNMI'14 climate change scenarios.")
  if (userProvided) {
    writeLines("# File created from user provided data.")
  } else {
    if (var == "rr") {
      writeLines("# File created from daily (homogenised) observations of")
    } else {
      writeLines("# File created from daily observations of")
    }
    writeLines("# Royal Netherlands Meteorological Institute (KNMI).")
  }

  writeLines("#")
  writeLines(paste0("# Time horizon: ", p))
  if (p != 2030) {
    writeLines(paste0("# Scenario: ", sc))
  }
  if (var == "rr") {
    writeLines(paste0("# Subscenario: ", subscenario))
  }
  writeLines(paste0("# Version: ", version))
  writeLines(timestamp(stamp = format(Sys.time(), "%B %d, %Y"),
                       prefix = "# Created: ", suffix = "", quiet = TRUE))
  writeLines("#")

  header <- as.data.frame(dat[1:5, ])
  header[, 1] <- paste0(rep(0, 8), collapse = "")

  write.table(format(header[1,      ], width = 8),             file = "",
              row.names = F, col.names = F, quote = F)
  write.table(format(header[2:5,    ], width = 8, nsmall = 3), file = "",
              row.names = F, col.names = F, quote = F)
  date <- dat[-c(1:5), 1]
  tmp  <- dat[-c(1:5), -1]
  if (var == "rsds") {
    write.table(format(cbind(date, round(tmp)), width = 8, nsmall = 0),
                file = "", row.names = F, col.names = F, quote = F)
  } else if (var == "evmk") {
    write.table(format(cbind(date, round(tmp, 2)), width = 8, nsmall = 2),
                file = "", row.names = F, col.names = F, quote = F)
  } else {
    write.table(format(cbind(date, round(tmp, 1)), width = 8, nsmall = 1),
                file = "", row.names = F, col.names = F, quote = F)
  }

  sink()
}

#' Create valid input from user specified data
#'
#' @description can be used if one does not have the KNMI standard format
#'
#' @note Currently for single stations only
#'
#' @param data a data.frame of two columns
#' \describe{
#'   \item{date}{integer vector date format yyyymmdd }
#'   \item{values}{numeric values of observation}
#' }
#'
#' @param stationID numeric (either official station number or self-chosen /
#'   recommendations?)
#'
#' @param lat numeric latitude
#' @param lon numeric longitude
#'
#' @param comment user specified comment (should start with '#') default is the
#'   current timestamp
#' @export
CreateKnmiTFInput <- function(data, stationID, lat, lon, comment = NULL) {
  # include test on structure of data
  if (!all(c("date", "values") %in% colnames(data)) | ncol(data) != 2) {
    err <- "Data should contain only column date and column values"
    flog.error(err)
    stop(err)
  }
  if (class(data$date) != "integer") {
    err <- "Date col should contain date in integer format 'yyyymmdd'"
    flog.error(err)
    stop(err)
  }
  if (class(data$values) != "numeric") {
    err <- "Values should be of class numeric"
    flog.error(err)
    stop(err)
  }
  necessaryDates <- as.integer(format(seq.Date(as.Date("1981-01-01"),
                               as.Date("2010-12-31"), by = 1), "%Y%m%d"))
  if (! all(necessaryDates %in% data[, date])) {
    err <- "The date column should contain the full period from 19810101 to 20101231"
    flog.error(err)
    stop(err)
  }
  if (! all(data[, date] %in%  necessaryDates)) {
    err <- "Currently the period is limited to the official thirty year period 1981-2010"
    flog.error(err)
    stop(err)
  }
  if (is.null(comment)) comment <- timestamp(quiet = TRUE)
  if (length(lat) != 1 | length(lon) != 1) {
    stop("lat and lon should be of length 1")
  }
  obs <- as.data.frame(data, stringsAsFactors = FALSE)
  knmiRdCoords <- spTransform(SpatialPoints(cbind(lon, lat),
                                            CRS("+proj=longlat +datum=WGS84")),
                              CRS("+init=epsg:28992"))@coords / 1000
  header <- data.frame(V1 = rep("00000000", 5),
                       V2 = c(stationID, knmiRdCoords[1], knmiRdCoords[2],
                              lon, lat),
                       stringsAsFactors = FALSE)
  # Check that comments are inline with rest
  structure(list(obs = obs, coords = cbind(lat, lon), comment = comment,
                 header = header), class = "knmiTF")
}

#' Show station table
#' @export
ShowStationTable <- function() {
  tmp <- system.file("extdata", "stationstabel",
                     package = "knmitransformer")
  system(paste0("less ", tmp))
}

CheckIfUserProvided <- function(x) {
  admissibleNames <- c("tx", "tn", "tg", "rsds", "rrcentr", "evmk")
  admissibleNames <- paste0("KNMI14____ref_", admissibleNames,
                            "___19810101-20101231_v3.2.txt")
  ifelse(class(x) != "character", TRUE,
         !( (grepl("knmitransformer/refdata/", x) |
              grepl("knmitransformer/inst/refdata/", x)) &
           basename(x) %in% admissibleNames))
}

#' Match regions on station id
#'
#' @param stationId Station id
#' @return vector with regions
#' @export
MatchRegionsOnStationId <- function(stationId) {
  tmpPath <- system.file("extdata", "stationstabel",
                         package = "knmitransformer")
  stationstabel <- read.table(tmpPath)
  index <- match(stationId, stationstabel[, 1])
  as.vector(stationstabel[index, 2])
}

CheckRegions <- function(regions, nStations) {
  admissibleRegions <- c("NLD", "NWN", "ZWN", "NON", "MON", "ZON")
  if (any(!regions %in% admissibleRegions)) {
    err <- "Regions have to match the KNMI defined regions"
    flog.error(err)
    stop(err)
  }
  if (nStations != length(regions)) {
    if (length(regions) == 1 & all(regions == "NLD")) {
      regions <- rep("NLD", nStations)
    } else {
      err <- "regions should be `NLD` or vector of length equal to number of stations"
      flog.error(err)
      stop(err)
    }
  }
  regions
}

#' Obtains corresponding month
#' @inheritParams ObtainDayNumber
#' @keywords internal
ObtainMonth <- function(date) {
  month(anydate(date))
}

#' Obtains yday
#' @param date datestring format yyyymmdd
#' @keywords internal
ObtainDayNumber <- function(date) {
  yday(anydate(date))
}

#' KNMI reference files
#' @param baseName base name of file
#' @export
KnmiRefFile <- function(baseName) {
  system.file("refdata", baseName, package = "knmitransformer")
}
