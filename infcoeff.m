function [ ] = infcoeff(valN, vecEPS, matCP)
% This function calculated the influence coefficients
%
% Uses the zero velocity normal to airfoil as a boundary condition:
% (q+Q_inf) dot norm = 0

% Global to local
tcos = cos(vecEPS);
tsin = sin(vecEPS);

% Calculate distance between control points of induced againts inducers
vecXINFPTS = reshape(repmat(matCP(:,1)',[valN,1]),[valN^2,1]) - repmat(matCP(:,1),[valN,1]);
vecYINFPTS = reshape(repmat(matCP(:,2)',[valN,1]),[valN^2,1]) - repmat(matCP(:,2),[valN,1]);

% Calculate induced velocities
vecU = [tcos tsin; -tsin cos];

end

