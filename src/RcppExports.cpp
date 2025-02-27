// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// DeterminePowerLawExponentCpp
double DeterminePowerLawExponentCpp(NumericVector Xm, double qfut, double qobs, double mfut);
RcppExport SEXP knmitransformer_DeterminePowerLawExponentCpp(SEXP XmSEXP, SEXP qfutSEXP, SEXP qobsSEXP, SEXP mfutSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type Xm(XmSEXP);
    Rcpp::traits::input_parameter< double >::type qfut(qfutSEXP);
    Rcpp::traits::input_parameter< double >::type qobs(qobsSEXP);
    Rcpp::traits::input_parameter< double >::type mfut(mfutSEXP);
    rcpp_result_gen = Rcpp::wrap(DeterminePowerLawExponentCpp(Xm, qfut, qobs, mfut));
    return rcpp_result_gen;
END_RCPP
}
