#include <TMB.hpp>

template <class Type>
Type objective_function<Type>::operator()()
{
  DATA_VECTOR(x_obs);
  DATA_VECTOR(y_obs);
  int n = y_obs.size();

  PARAMETER(beta0);
  PARAMETER(beta1);
  PARAMETER(beta2);
  PARAMETER(beta3);
  PARAMETER(logSigma);

  vector<Type> y_pred(n);
  y_pred = beta0 * x_obs + beta1 * square(x_obs) - beta2 * cube(x_obs) + beta3;

  Type nll = 0.0;
  nll = -dnorm(y_obs, y_pred, exp(logSigma), true).sum();

  REPORT(nll);
  REPORT(beta0);
  REPORT(beta1);
  REPORT(beta2);
  REPORT(beta3);

  ADREPORT(beta0);
  ADREPORT(beta1);
  ADREPORT(beta2);
  ADREPORT(beta3);

  return nll;
}
