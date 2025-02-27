% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TemperatureTransformation.R
\name{tm_trans_KNMI14}
\alias{tm_trans_KNMI14}
\title{tm_trans_KNMI14}
\usage{
tm_trans_KNMI14(obs, deltas, regio.tabel = NA)
}
\arguments{
\item{obs}{data.frame or matrix: \cr
first column provides datestring YYYYMMDD \cr
other columns provide precipitation (mm) time series (each column represents
specific station)}

\item{deltas}{data.frame or matrix that contains deltas (=change factors for the transformation)
should contain following columns indicated by following headers: \cr
"maand"     month for which deltas are valid (1,2,...,12) \cr
"P01"       1st  percentile daily temperature  \cr
"P05"       5th  percentile daily temperature \cr
"P50"       50th percentile daily temperature \cr
"P95"       95th percentile daily temperature \cr
"P99"       99th percentile daily temperature \cr\preformatted{          following column is optional in case deltas vary with region
          (is needed in case <regio.tabel> is provided)
          "regio"     region for which deltas are valid
                      KNMI14 distinguishes ("NWN", "ZWN", "NON", "MON", "ZON", "NLD")
}}

\item{regio.tabel}{this (optional) argument provides a vector that relates the stations to
a particular region.
KNMI14 distinguishes following regions:\cr
<NLD> Nederland  (DEFAULT) \cr
<NWN> Noordwest Nederland \cr
<ZWN> Zuidwest Nederland\cr
<NON> Noordoost Nederland\cr
<MON> Middenoost Nederland\cr
<ZON> Zuidoost Nederland}
}
\description{
Function 'transforms' a specific reference-dataset with time
series of daily of mean, minimum or maximum temperature (degrees Celsius) to
a dataset representative for a future climate scenario.
}
\keyword{internal}
