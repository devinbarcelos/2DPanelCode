function [ vecQ ] = source_strength(vecB, matINDVEL)
% This function solves for the source strength
%
%   OUTPUT:
%   vecQ - Source strength vector
vecQ = matINDVEL\vecB;
end

