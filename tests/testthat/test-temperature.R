context("Temperature transformation")

library(futile.logger)
flog.threshold(DEBUG)
flog.appender(appender.file("knmitransformer_temperature.log"))
library(data.table)

context("tg transformation - Entire station set")

var        <- "tg"
input      <- KnmiRefFile("KNMI14____ref_tg___19810101-20101231_v3.2.txt")
ofile      <- NA
regions    <- MatchRegionsOnStationId(ReadInput(var, input)$header[1, -1])
rounding   <- FALSE

test_that("2030 decadal prediction", {
  scenario <- "GL"
  horizon  <- 2030
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
                       )
  expect_equal_to_reference(tmp, "regressionOutput/temperature/KNMI14___2030_tg.rds")

  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = TRUE)
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14___2030_tg_rounded.rds")
})

test_that("Scenario WL", {
  scenario <- "WL"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WL_2050_tg.rds")

  # Regression test based only on the smaller subset used also for the other
  # scenarios - on the web there is an extended version
  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WL_2085_tg.rds")
})

test_that("Scenario WH", {
  scenario <- "WH"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WH_2050_tg.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WH_2085_tg.rds")
})

test_that("Scenario GH", {
  scenario <- "GH"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GH_2050_tg.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GH_2085_tg.rds")
})

test_that("Scenario GL", {
  scenario <- "GL"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GL_2050_tg.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GL_2085_tg.rds")
})

# ------------------------------------------------------------------------------
context("tx transformation - Entire station set")

var        <- "tx"
input      <- KnmiRefFile("KNMI14____ref_tx___19810101-20101231_v3.2.txt")
ofile      <- NA # output file - used only temporary

test_that("2030 decadal prediction", {
  scenario <- "GL"
  horizon  <- 2030
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14___2030_tx.rds")
})

test_that("Scenario WL", {
  scenario <- "WL"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WL_2050_tx.rds")

  # Regression test based only on the smaller subset used also for the other
  # scenarios - on the web there is an extended version
  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WL_2085_tx.rds")
})

test_that("Scenario WH", {
  scenario <- "WH"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WH_2050_tx.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WH_2085_tx.rds")
})

test_that("Scenario GH", {
  scenario <- "GH"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GH_2050_tx.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GH_2085_tx.rds")
})

test_that("Scenario GL", {
  scenario <- "GL"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GL_2050_tx.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GL_2085_tx.rds")
})

context("tn transformation - Entire station set")

var        <- "tn"
input      <- KnmiRefFile("KNMI14____ref_tn___19810101-20101231_v3.2.txt")
ofile      <- NA # output file - used only temporary

test_that("2030 decadal prediction", {
  scenario <- "GL"
  horizon  <- 2030
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14___2030_tn.rds")
})

test_that("Scenario WL", {
  scenario <- "WL"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WL_2050_tn.rds")

  # Regression test based only on the smaller subset used also for the other
  # scenarios - on the web there is an extended version
  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WL_2085_tn.rds")
})

test_that("Scenario WH", {
  scenario <- "WH"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WH_2050_tn.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WH_2085_tn.rds")
})

test_that("Scenario GH", {
  scenario <- "GH"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GH_2050_tn.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GH_2085_tn.rds")
})

test_that("Scenario GL", {
  scenario <- "GL"
  horizon  <- 2050
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GL_2050_tn.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                       ofile = ofile,
                       scenario = scenario,
                       horizon = horizon,
                       var = var,
                       regions = regions,
                       rounding = rounding
  )
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GL_2085_tn.rds")
})



context("Temperature transformation - Single station exercises")
input   <- "regressionInput/KNMI14____ref_tg___19810101-20101231_v3.2_260.txt"
regions <- MatchRegionsOnStationId(260)

ofile    <- "tmp.txt"
scenario <- "GL"
horizon  <- 2030
var      <- "tg"

test_that("Test wrong user input", {

  expect_error(TransformTemp(input = input,
                             ofile = ofile,
                             scenario = scenario,
                             horizon = NA,
                             var = var,
                             rounding = rounding
                             ),
               "Period must be valid, i.e. 2030, 2050, or 2085")

  expect_error(TransformTemp(input = input,
                             ofile = ofile,
                             scenario = scenario,
                             horizon = horizon,
                             var = "blub",
                             rounding = rounding
                             ),
               "variable not defined.")

})


test_that("Procedure works for one station as well", {

  tmp <- TransformTemp(input = input,
                                          ofile = ofile,
                                          scenario = scenario,
                                          horizon = horizon,
                                          var = var,
                                          regions = regions,
                       rounding = rounding)
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14___2030_tg___DeBilt.rds")
})

test_that("Temperature regression test (with actual data) WH", {

  scenario <- "WH"
  horizon  <- 2050

  tmp <- TransformTemp(input = input,
                                          ofile = ofile,
                                          scenario = scenario,
                                          horizon = horizon,
                                          var = var,
                                          regions = regions,
                       rounding = rounding)
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WH_2050_tg___DeBilt.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                                          ofile = ofile,
                                          scenario = scenario,
                                          horizon = horizon,
                                          var = var,
                                          regions = regions,
                       rounding = rounding)
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WH_2085_tg___DeBilt.rds")
})

test_that("Temperature regression test (with actual data) GL", {
  scenario <- "GL"
  horizon  <- 2050

  tmp <- TransformTemp(input = input,
                                          ofile = ofile,
                                          scenario = scenario,
                                          horizon = horizon,
                                          var = var,
                                          regions = regions,
                       rounding = rounding)
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GL_2050_tg___DeBilt.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                                          ofile = ofile,
                                          scenario = scenario,
                                          horizon = horizon,
                                          var = var,
                                          regions = regions,
                       rounding = rounding)
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GL_2085_tg___DeBilt.rds")
})

test_that("Temperature regression test (with actual data) GH", {
  scenario <- "GH"
  horizon  <- 2050

  tmp <- TransformTemp(input = input,
                                          ofile = ofile,
                                          scenario = scenario,
                                          horizon = horizon,
                                          var = var,
                                          regions = regions,
                       rounding = rounding)
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GH_2050_tg___DeBilt.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                                          ofile = ofile,
                                          scenario = scenario,
                                          horizon = horizon,
                                          var = var,
                                          regions = regions,
                       rounding = rounding)
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_GH_2085_tg___DeBilt.rds")
})

test_that("Temperature regression test (with actual data) WL", {
  scenario <- "WL"
  horizon  <- 2050

  tmp <- TransformTemp(input = input,
                                          ofile = ofile,
                                          scenario = scenario,
                                          horizon = horizon,
                                          var = var,
                                          regions = regions,
                       rounding = rounding)
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WL_2050_tg___DeBilt.rds")

  horizon <- 2085
  tmp <- TransformTemp(input = input,
                                          ofile = ofile,
                                          scenario = scenario,
                                          horizon = horizon,
                                          var = var,
                                          regions = regions,
                       rounding = rounding)
  expect_equal_to_reference(tmp,
      "regressionOutput/temperature/KNMI14_WL_2085_tg___DeBilt.rds")
})
