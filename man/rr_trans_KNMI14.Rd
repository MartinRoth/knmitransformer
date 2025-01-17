% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PrecipitationTransformation.R
\name{rr_trans_KNMI14}
\alias{rr_trans_KNMI14}
\title{rr_trans_KNMI14.R}
\usage{
rr_trans_KNMI14(obs, deltas)
}
\arguments{
\item{obs}{data.frame or matrix: \cr
first column provides datestring YYYYMMDD \cr
other columns provide precipitation (mm) time series
(each column represents specific station)}

\item{deltas}{data.frame or matrix that contains deltas (=change factors
for the transformation) should contain following columns
indicated by following headers
HEADER\cr
"wdf"       relative change (\%) in wet-day frequency
(wet day is defined as day with 0.1 mm or more
precipitation) \cr
"ave"       relative change (\%) in mean precipitation \cr
"P99"       relative change (\%) in the 99th percentile of
wet-day amounts}
}
\description{
Function 'transforms' a specific reference-dataset with daily
precipitation sums (mm) to a dataset representative for a future climate
scenario.
}
\keyword{internal}
