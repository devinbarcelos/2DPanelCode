function [ matNODES, c, n] = airfoil_panel( naca, c, n )
% [ x,y, c] = airfoil_panel( naca, c, n )
% Generates a paneled 4 digit naca airfoil of chord length c and n panels
% and n+1 nodes
%
% Creates 
% Coordinates go from leading edge as point 0,0,0 clockwise around the
% airfoil
%
% The process of placing a sharp trailing edge on the airfoil adds extra
% chord length onto the airfoil, and potentially changes the number of
% panels and nodes. The adjusted chord length (c) and adjusted number of 
% panels (n) is returned along with the x and y coordinates
% 

% ============================ Test Values ============================= %
% Comment out before moving on
% c = 1; % Chord length
% n = 15; % Number of points
% naca = 2412; % 4-digit airfoil series
% ======================================================================= %

% Gather coordinate information
[x,y] = airfoil(naca, c, n); % x and y coordinates


%% =============== Find duplicate points =============================== %%
a = 1;
for j = 1:1:length(x)
    for k = 1:1:length(x)
        if x(j) == x(k) && y(j) == y(k) && j ~= k
            dup(a) = [j]; % Write duplicate indexs to array
            a = a + 1;
        end
    end
end

% Remove odd instances from duplicate array
dup_update = [];
for j = 1:2:length(dup)
    dup_update = [dup_update, dup(j)];
end
dup = dup_update;

% Remove duplicate points
x_new = [];
y_new = []; 
for j = 1:1:length(x)
    test = ismember(j, dup); % Test if instance needs to be removed
    if test ~= 1
        x_new = [x_new, x(j)];
        y_new = [y_new, y(j)];
    end
end
x = x_new;
y = y_new;


%% =============== Define z-coordinates (all zeros)===================== %%
z = zeros(1, length(x)); % z-coordinates

%% ======================= Define sharp tip ============================ %%

% Calcualte tangent slope at trailing edge
upper = polyfit([x(1), x(2)],[y(1), y(2)], 1);
mu = upper(1); % Slope 
bu = upper(2); % y-intercept

lower = polyfit([x(end-1), x(end)],[y(end-1), y(end)], 1);
ml = lower(1); % Slope
bl = lower(2); % y-intercept

xu = x(1);
yu = y(1);
xl = x(end);
yl = y(end);

% Calculate intersection point
x_s = (bl - bu)/(mu - ml);
y_s = mu*x_s + bu;

% Merge sharp point with existing x and y arrays
x = [x_s, x, x_s];
y = [y_s, y, y_s];

% Calculate number of panels
nodes = length(x);
n = nodes - 1; %<-- Number of panels

% Calcualte new chord length
c = max(x);

% Place x and y coordinates in their output matrix
matNODES = [x', y'];

%% ============================= Plot ================================== %%
% Comment out before moving on
% close all
% figure
% hold on
% plot(x,y, 'o--')
% grid on
% axis equal
% hold off




end

