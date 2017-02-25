function [ ] = plot_stream( vecQ, vecEPS, vecS, vecINDUCEDX, vecINDUCEDY, vecINDUCERX, vecINDUCERY, matCP )

% Calculate the induced velocity from each panel

vecX = linspace(0, 1, 10)
vecY = linspace(-1,1,10);
vecX = vecX';
vecY = vecY';

len_POI = length(vecX);
len_panel = length(matCP(:,1));

vecINDUCERX = repmat(matCP(:,1), [len_POI 1]);
vecINDUCERY = repmat(matCP(:,2), [len_POI 1]);

vecINDUCEDX = [];
vecINDUCEDY = [];
for j = 1:1:len_POI
    for k = 1:1:len_panel
        vecINDUCEDX = [vecINDUCEDX; vecX(j)];
        vecINDUCEDY = [vecINDUCEDY; vecY(j)];
    end
end

[ matINDVEL ] = ind_vel(vecQ, vecEPS, vecS, vecX, vecY, vecINDUCERX, vecINDUCERY);
% 
% vecX = matCP(:, 1);
% vecY = matCP(:, 2);
% valN = size(vecX, 1);
% 
% % Pre-allocate U and V vectors
% vecU = zeros(valN, 1 );
% vecV = zeros(valN, 1 );
% 
% % Sum up all velcoity influences
% for j = 1:1:valN
%     for k = ((j-1)*valN+1):1:j*valN
%         vecU(j) = vecU(j) +  matINDVEL(k, 1);
%         vecV(j) = vecV(j) +  matINDVEL(k, 2);
%     end
% end
% vecU
% % Plot Streamlines
% [x,y] = meshgrid(0:0.1:1,0:0.1:1);
% u = x;
% v = -y;
% 
% % figure
% % streamline(x,y,u,v)
end

