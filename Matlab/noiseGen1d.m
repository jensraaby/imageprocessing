% Jens Raaby 
% Version 0.1 September 2012
% TODO document the parameters fully
function sample = noiseGen1D( size, type, a, b, Pa, Pb )
%NOISEGEN1D Generates a vector of samples with a variety of types
%   Possible types:
%    'gaussian'   - takes a mean and variance
%    'gamma'      - takes a and b parameters
%    'uniform'    - takes a and b parameters
%    'salt&pepper - takes probabilities for 2 positions
%   The parameters A and B are used to specify the noise distribution.

switch(type)
    case('gaussian')
        % Use normrnd to generate the gaussian noise
        sample = normrnd(a,b,[size 1]);
    case('gamma')
        % Use gamrnd to generate gamma noise
        if (a<0)
            error('a must be positive');
        elseif (b ~= round(b))
            error('b must be an integer')
        end
        sample = gamrnd(1/a,b,[size 1]);
    case('uniform')
        % Use unifrnd to generate uniform noise
        sample = unifrnd(a,b,size,1);
    case('salt&pepper')
        
        if (Pa+Pb) > 1
            error('Probabilities cannot exceed 1');
        end
        % generate uniform random noise to sample from
        uniform = rand(1,size);
        
        % identify pepper samples with value under Pa
        pepper = find(uniform<=Pa);
        
        % identify salt samples with 
        %  Pa < uniform < Pa+Pb
        salt = find(Pa < uniform & uniform <= Pa+Pb);
        
        % Generate a plain initial vector
        sample = 0.5 * ones(size,1);
        % assign the salt and pepper intensities (a and b)
        sample(pepper) = a;
        sample(salt) = b;
    otherwise
        error('We don`t make that kind of noise here!');
    end
end
