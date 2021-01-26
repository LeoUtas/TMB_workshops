#include <TMB.hpp>

template <class Type>
Type objective_function<Type>::operator()()
{
    DATA_VECTOR(cat);
    DATA_VECTOR(pos);
    DATA_VECTOR(day);
    DATA_SCALAR(N00);
    DATA_SCALAR(W);

    PARAMETER(alpha);
    PARAMETER(logsigma);
    PARAMETER(q);

    Type sigma = exp(logsigma);
    int nobs = cat.size();
    vector<Type> Nbar(nobs), Cbar(nobs);

    for (int i = 0; i < nobs; ++i)
    {
        Nbar(i) = pnorm((pos(i) + W / 2.0 - alpha * day(i)) / sigma / sqrt(day(i))) -
                  pnorm((pos(i) - W / 2.0 - alpha * day(i)) / sigma / sqrt(day(i)));
    }
    Nbar *= N00;
    Cbar = q * Nbar;
    Type nll = -sum(dpois(cat, Cbar, true));
    ADREPORT(sigma);
    return nll;
}
