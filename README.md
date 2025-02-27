
<!-- README.md is generated from README.Rmd. Please edit that file -->
knmitransformer
===============

[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip) [![Travis-CI Build Status](https://travis-ci.org/KNMI/knmitransformer.svg?branch=master)](https://travis-ci.org/KNMI/knmitransformer) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/KNMI/knmitransformer?branch=master&svg=true)](https://ci.appveyor.com/project/KNMI/knmitransformer) [![Coverage Status](https://img.shields.io/codecov/c/github/KNMI/knmitransformer/master.svg)](https://codecov.io/github/KNMI/knmitransformer?branch=master)

Please, if there is an issue of any kind, file it [here](https://github.com/MartinRoth/knmitransformer/issues)

The 'transformation program' of the KNMI 2014 climate change scenarios for the Netherlands. With this program current climate time series are transformed to represent the climate of the KNMI 2014 scenarios for 2030, 2050, and 2085.

To install the package use:

``` r
library(devtools)
install_github("KNMI/knmitransformer")
```

or

``` r
devtools::install_github("KNMI/knmitransformer")
```

Note that the installation (i.e. the download) can take quite some time, owing to the large test folder.

### Content

The following R-functions for the transformation of daily meteorological variables are provided:

-   'TransformPrecip' precipitation (sum) \[mm\]
-   'TransformTemp' temperature (mean, min and max) \[degrees Celsius\]
-   'TransformRadiation' global radiation (sum) \[kJ/m2\]
-   'TransformEvap' Makkink Evaporation (sum) \[mm\]

The routines and the used change factors are developed for the use within the Netherlands.

One can inspect the official KNMI14 change factors / deltas in the 'inst/extData' folder.

For examples of usage have a look at the vignette:

``` r
vignette("examples", "knmitransformer")
```

### Note

-   Transformation of different time series/stations at once is possible.
-   TEMPERATURE distinguishes between minimum temperature (tn), mean temperature (tg) and maximum temperature (tx); this should be specified in the function call.
-   TEMPERATURE and EVAPORATION need the region as input. The station table makes the link between station number and region within the Netherlands. For the reference data sets the stationtable is used to make a link between the station number and the region, see
    `ShowStationTable()`. *Always check* if the station that you want to transform is listed there, if not you have to include the region as argument.
-   For PRECIPITATION there are three different subscenarios for each scenario available, based on resp. the 'lower', 'centr' (=central) and 'upper' estimate of the change in extreme daily precipitation. This should be specified in the function call, the default is set to 'centr'.

### Reference

Bakker, A. (2015), Time series transformation tool: description of the program to generate time series consistent with the KNMI’14 climate scenarios, Technical Report TR-349, De Bilt, the Netherlands.
