function [ vecQ ] = source_strength(vecR, matINFCOEFF)
% This function solves for the source strength
%
%   INPUTS
%   vecR - Resulant Vector
%   matINFCOEFF - Influence coefficient matrix
%
%   OUTPUTS
%   vecQ - Source strength vector

% Resultant vector divided by influence coeff
vecQ = matINFCOEFF\vecR;
end

