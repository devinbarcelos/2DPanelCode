function [ matINDVEL ] = ind_vel(vecQ, vecEPS, vecS, vecINDUCEDX, vecINDUCEDY, vecINDUCERX, vecINDUCERY)
% Calculate induced velocities
%
%   INPUTS
%   vecQ - Source strength
%   vecEPS - Panel epsilon
%   vecS - Panel length
%   vecINDUCEDX - induced x points
%   vecINDUCEDY - induced y points
%   vecINDUCERX - inducer x points
%   vecINDUCERY - indecer y points
%
%   OUTPUTS
%   matINDVEL - induced velocities (x,y)

% Difference between induced and inducers
delx = vecINDUCEDX - vecINDUCERX;
dely = vecINDUCEDY - vecINDUCERY;
del = [delx,dely];

len = size(vecEPS);
len = len(1);

% Global to local reference frame transformation
tcos = cos(vecEPS);
tsin = sin(vecEPS);

matTRANS = reshape(repmat(tcos,[len,1]),[1,1,len^2]);
matTRANS(1,2,:) = reshape(repmat(tsin,[len,1]),[1,1,len^2]);
matTRANS(2,1,:) = reshape(repmat(-tsin,[len,1]),[1,1,len^2]);
matTRANS(2,2,:) = reshape(repmat(tcos,[len,1]),[1,1,len^2]);

% Calculate X_q and Y_q using matTRANS*(x_i-x_j)
% Note i is induced and j is unducer
for i = 1:len^2
    xy_iq(i,:) = matTRANS(:,:,i)*(del(i,:)');
end

% Repmat the S vector by the number of panels
vecS = repmat(vecS,[len,1]);

% Repmat the source strength vector by the number of panels
vecQ = repmat(vecQ,[len,1]);

% Calculate the induced velocities
vecVxq = 0.5*log(((xy_iq(:,1)+vecS/2).^2+xy_iq(:,2).^2)./((xy_iq(:,1)-vecS/2).^2+xy_iq(:,2).^2));
vecVyq = (atan((xy_iq(:,1)+vecS/2)./xy_iq(:,2))-atan((xy_iq(:,1)-vecS/2)./xy_iq(:,2)));

matINDVEL1 = [vecQ.*vecVxq,vecQ.*vecVyq];
matINDVEL1 = permute(matINDVEL1,[3,2,1]);

for i = 1:len^2
    matINDVEL(i,:) = (inv(matTRANS(:,:,i))*matINDVEL1(:,:,i)')';
end
end

