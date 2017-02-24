function [ indvel ] = ind_vel(vecEPS, vecGAMMA, vecINDUCEDX, vecINDUCEDY, vecINDUCERX, vecINDUCERY)
% Calculate induced velocities
%
%   INPUTS
%   vecGAMMA - vector of circulation
%   vecINDUCEDX - induced x points
%   vecINDUCEDY - induced y points
%   vecINDUCERX - inducer x points
%   vecINDUCERY - indecer y points
%
%   OUTPUTS
%   indvel - induced velocities (x,y)

% Difference between induced and inducers
delx = vecINDUCEDX - vecINDUCERX;
dely = vecINDUCEDY - vecINDUCERY;
del = [delx,dely];
r = delx.^2+dely.^2;

len = size(vecEPS);
len = len(1);

% Global to local reference frame transformation
tcos = cos(vecEPS);
tsin = sin(vecEPS);

matTRANS = reshape(repmat(tcos,[len,1]),[1,1,len^2]);
matTRANS(1,2,:) = reshape(repmat(tsin,[len,1]),[1,1,len^2]);
matTRANS(2,1,:) = reshape(repmat(-tsin,[len,1]),[1,1,len^2]);
matTRANS(2,2,:) = reshape(repmat(tcos,[len,1]),[1,1,len^2]);

% Calculate induced velocity 
for i = 1:len^2
    indvel(i,:) = matTRANS(:,:,i)*(del(i,:)');
end

indvel = (vecGAMMA./(2*pi*r.^2)).*indvel;


end

