function [indvel] = infcoeff(vecEPS, matCP)
% This function calculated the influence coefficients
%
% Uses the zero velocity normal to airfoil as a boundary condition:
% (q+Q_inf) dot norm = 0

len = length(vecEPS);
% Calculate distance between control points of induced againts inducers
vecINDUCEDX = reshape(repmat(matCP(:,1)',[len,1]),[len^2,1]);
vecINDUCERX = repmat(matCP(:,1),[len,1]);

vecINDUCEDY = reshape(repmat(matCP(:,2)',[len,1]),[len^2,1]);
vecINDUCERY = repmat(matCP(:,2),[len,1]);

% Use a circulation of one
vecGAMMA = ones(len^2,1);

% Calculate induced velocities
[ indvel ] = ind_vel(vecEPS, vecGAMMA, vecINDUCEDX, vecINDUCEDY, vecINDUCERX, vecINDUCERY);

% Calculate influence matrix by doting the induced velocities by the
% normals


end

