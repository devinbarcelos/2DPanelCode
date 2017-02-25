function [ ] = plot_stream( vecQ, vecEPS, vecS, matCP, vecUINF, matNODES )
% This function plots the streamlines of the system
%
%   INPUTS
%   vecQ - The solved source strengths
%   vecEPS - Panel incidence angles (rad)
%   vecS - Panel lengths
%   matCP - Control point locations (x,y)
%   vecUINF - inflow velocity direction
%   matNODES - Node locations
%
%   OUTPUTS
%   Streamline plot


% Calculate the induced velocity from each panel

% Define grid for streamlines
valXMIN = -0.5;
valXMAX = 1.5;
valYMIN = -.5;
valYMAX = 0.5;

meshX = linspace(valXMIN, valXMAX, 100);
meshY = linspace(valYMIN, valYMAX, 100);
[matX, matY] = meshgrid(meshX', meshY');

% Pre-allocate U and V arrays
matU = [];
matV = [];

% Pass each column of mesh grid into induced velocity function at a time
for a = 1:1:length(matX)
    % Get vecX and Y from grid
    vecX = matX(:,a);
    vecY = matY(:,a);
      
    len_POI = length(vecX); % Length of the point of interest array
    len_panel = length(matCP(:,1)); % Length of the panel array

    vecINDUCERX = repmat(matCP(:,1), [len_POI 1]); % Inducers
    vecINDUCERY = repmat(matCP(:,2), [len_POI 1]);
    
    % Create Induced arrya
    vecINDUCEDX = [];
    vecINDUCEDY = [];
    for j = 1:1:len_POI
        for k = 1:1:len_panel
            vecINDUCEDX = [vecINDUCEDX; vecX(j)];
            vecINDUCEDY = [vecINDUCEDY; vecY(j)];
        end
    end
    
    % Get induced velocites matrix
    [ matINDVEL ] = ind_vel(vecQ, vecEPS, vecS, vecINDUCEDX, vecINDUCEDY, vecINDUCERX, vecINDUCERY);

    % Pre-allocate U and V vectors
    vecU = zeros(len_POI, 1 );
    vecV = zeros(len_POI, 1 );

    % Sum up all velcoity influences
    for j = 1:1:(size(vecU, 1))
        for k = (1+(j-1)*len_panel):1:j*len_panel
            vecU(j) = vecU(j) - matINDVEL(k,1);
            vecV(j) = vecV(j) - matINDVEL(k,2);
        end
    end
    matU = [matU, vecU];
    matV = [matV, vecV];
end
matU = matU + vecUINF(1);
matV = matV + vecUINF(2);

% Plot Streamlines
close all
hold on
figure
starty = linspace(valYMIN, valYMAX, 40);
startx = ones(1, size(starty, 2)).*valXMIN;

plot(matNODES(:,1), matNODES(:,2), 'r')
axis equal
streamline(matX,matY,matU,matV, startx, starty)
axis([valXMIN,valXMAX,valYMIN,valYMAX])
hold off
end

