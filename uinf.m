function [vecUINF] = uinf(valALPHA)
% Uinf is defined as 1 as coefficient values are ouputs from this panel
% code
%
%   INPUTS
%   valALPHA - Angle of attack in deg
%
%   OUTPUTS
%   vecUINF - vector of inflow velocity direction (x,y)

uinf = 1;
% Calculate the coordinates of the inflow velocity based on AoA 
vecUINF = [uinf*cosd(valALPHA) uinf*sind(valALPHA)];

end
