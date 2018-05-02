function scaled = rescale_parameters(prior, params)

% scaled = rescale_parameters(prior, params)
%
% This function will convert from a unit hypercube to the true
% parameter values. For the Gaussian prior inverse transform
% sampling is used to convert from the unit hypercube to a Gaussian.

lp = length(params);

scaled = zeros(lp,1);

for i=1:lp
    priortype = prior{i,2};
    p3 = prior{i,3};
    p4 = prior{i,4};

    % currently only handles uniform or Gaussian priors
    if strcmp(priortype, 'uniform')
        scaled(i) = params(i)*(p4 - p3) + p3;
    elseif strcmp(priortype, 'gaussian')
        % use inverse transform sampling
        scaled(i) = p3 + p4*sqrt(2)*erfinv(2.*params(i) - 1.);
    elseif strcmp(priortype, 'jeffreys')
        scaled(i) = 10^(params(i)*(log10(p4) - log10(p3)) + log10(p3));
    end
end
