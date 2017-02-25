function [matINFCOEFF] = infcoeff(vecS, vecEPS, matCP, matNORM)
% This function calculates the influence coefficients
% Uses the zero velocity normal to airfoil as the kinimatic boundary
% condition
%
%   INPUTS
%   vecS - Panel length vector
%   vecEPS - Panel epsilon vector
%   matCP - Control points location (x,y)
%   matNORM - Normal vectors (x,y)
%
%   OUTPUTS
%   matINFCOEFF - Influence matrix

len = length(vecEPS);
% Calculate distance between control points of induced againts inducers
vecINDUCEDX = reshape(repmat(matCP(:,1)',[len,1]),[len^2,1]);
vecINDUCERX = repmat(matCP(:,1),[len,1]);

vecINDUCEDY = reshape(repmat(matCP(:,2)',[len,1]),[len^2,1]);
vecINDUCERY = repmat(matCP(:,2),[len,1]);

vecQ = ones(len,1);
% Calculate induced velocities
[ matINDVEL ] = ind_vel(vecQ, vecEPS, vecS, vecINDUCEDX, vecINDUCEDY, vecINDUCERX, vecINDUCERY);

% Calculate influence matrix by doting the induced velocities by the
% normals
% matINFCOEFF = zeros(len);
% d = 0;
% for i = 1:len
%     for j = 1:len
%     d = d+1;
%     matINFCOEFF(i,j) = dot(matINDVEL(d,:),matNORM(i,:));
%     end
% end

% Calculate influence matrix by doting the induced velocities by the
% normals (vectorized)
matNORM = reshape(repmat(reshape(matNORM,[1,len*2]),[len,1]),[len^2,2]);
matINFCOEFF = dot(matINDVEL,matNORM,2);
matINFCOEFF = reshape(matINFCOEFF,[len,len])';
end