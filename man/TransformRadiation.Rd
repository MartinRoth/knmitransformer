% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/knmitransformer.R
\name{TransformRadiation}
\alias{TransformRadiation}
\title{Transformation of radiation}
\usage{
TransformRadiation(input, scenario = "GL", horizon = 2030, ofile = NA,
  rounding = TRUE)
}
\arguments{
\item{input}{knmiTF object or name of the input file (ASCII) that contains
reference data (all numerics) in which the columns provide time series for
specific stations. The first column should provide either 00000000 or a
datestring YYYYMMDD: \cr
Rows starting with 00000000 are considered station info (station number,
lat, lon etc.) and are ignored. \cr
Rows starting with a datestring refer to a specific day in the time series. \cr
Rows starting with "#" are completely ignored and returned
unchanged.}

\item{scenario}{scenario ("GL"=DEFAULT, "GH", "WL", "WH")}

\item{horizon}{time horizon (2030=DEFAULT, 2050, 2085)}

\item{ofile}{Name of the output file to write the transformed data to.
Format is similar to input file mentioned in input. By default no output
file is written.}

\item{rounding}{Logical (default = TRUE) if results should be rounded}
}
\description{
Function reads 'reference data' with time series of daily global
radiation sums \code{[kJ/m2]} and 'change factors' from input files and applies
them to function 'rsds_trans_KNMI14' to obtain 'future time series' that
match a certain climate
}
\note{
The 5th row of the ifile indicated by 00000000 must be given as it is
interpreted to contain LATITUDES of station.
}
