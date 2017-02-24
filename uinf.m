function [vecUINF] = infcoeff(valALPHA)
% Uinf is defined as 1 as coefficient values are ouputs from this panel
% code
uinf = 1;
% Calculate the coordinates of the inflow velocity based on AoA 
vecUINF = [uinf*cos(valALPHA) uinf*sin(valALPHA)];
end
