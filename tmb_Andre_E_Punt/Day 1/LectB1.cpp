#include <TMB.hpp>

template <class Type>
Type objective_function<Type>::operator()()
{
  DATA_VECTOR(x);
  PARAMETER(mu);

  PARAMETER(logSigma);

  Type nll = 0;
  nll -= dnorm(x, mu, exp(logSigma), true).sum();
  return nll;
}
