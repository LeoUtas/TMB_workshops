#include <TMB.hpp>

template <class Type>
Type objective_function<Type>::operator()()
{
  DATA_VECTOR(x_obs);
  DATA_VECTOR(y_obs);
  int n = y_obs.size();

  PARAMETER(beta0);
  PARAMETER(beta1);
  PARAMETER(logSigma);
  vector<Type> y_pred(n);

  Type nll = 0.0;

  y_pred = beta0 * x_obs + beta1;
  nll -= dnorm(y_obs, y_pred, exp(logSigma), true).sum();

  REPORT(beta0);
  REPORT(beta1);
  REPORT(nll);
  return nll;
}
