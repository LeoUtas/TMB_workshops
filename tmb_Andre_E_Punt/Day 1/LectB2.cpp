#include <TMB.hpp>

template <class Type>
Type objective_function<Type>::operator()()
{
  DATA_VECTOR(x_obs);
  DATA_VECTOR(y_obs);
  int n = y_obs.size();

  PARAMETER(b0);
  PARAMETER(b1);
  PARAMETER(logSigma);
  vector<Type> y_pred(n);

  Type nll = 0.0;

  y_obs = b0 + b1 * x_obs;
  nll -= dnorm(y_obs, y_pred, exp(logSigma), true).sum();

  REPORT(b0);
  REPORT(b1);
  REPORT(nll);
  return nll;
}
