function [vecPRESSURE] = pressure(vecQ, matINFCOEFFT, matTANG)
% This function calculates the pressure distribution
%
%   INPUTS
%   vecQ - Source strength vector
%   matINFCOEFFT - influence matrix due to tangents
%   matTANG - Tangents to each control point

vecPRESSURE = 1 - (matINFCOEFFT*vecQ+(matTANG(:,1))).^2;


