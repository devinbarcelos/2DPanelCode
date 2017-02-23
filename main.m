%% ======================= Source Panel Code =========================== %%
% Authors: Scott Lindsay, Devin Barcelos
%
% Calcualtes the lift acting on a shape using source panel method.
% Imbedded in the code is a geometry generator for a cylinder of radius r 
% and a geometry generator for any NACA 4-digit series airfoil of chord
% length c
clc
clear
%% ===================== Intialize Cylinder Geometry =================== %%
% Comment out this block if the cylinder case is not being used

valR = 1; % Cylinder radius
valN = 100; % Number of panels

% Pass cylinder information to cylinder generation function
% Returns coordinates of each node
[matNODES] = cyn_panel(valR, valN); 

%% ========================= Airfoil Case ============================== %%
% Comment out this block if the airfoil case is not being used

valNACA = 2412; % 4-Digit airfoil
valC = 1; % Approximate Chord length
valN = 50; % Approximate number of panels

% Pass airfoil information to airfoil generation function

% The airfoil generation function uses a the equaton of the NACA 4-digit
% airfoil (https://en.wikipedia.org/wiki/NACA_airfoil).

% This equation generates an airfoil with a blunt trailing edge, which will
% complicate the source code. Therefore, a sharp trailing edge is added by 
% the function. Because of this, the chord length and the number of panels 
% will not be exactly the same as entered into the function. The function
% returns the true number of panels, and the true chord length
%
% Returns coordinates of each node and stores them in node stucture
[matNODES, valC, valN] = airfoil_panel(valNACA, valC, valN);

%% ====================== Control Points =============================== %%

% Passes x and y node coordinate information to the control_point function
% which returns the x and y coordinates of the panel control point (x,y),
% the panel length (s), the tangent vector (tx, ty), and  the normal vector
% (nx, ny)s
[matCP, vecS, matTANG, matNORM, vecEPS] = control_point( matNODES);


%% ============================ Plot Geometry ========================== %%

% Plots the nodes, panel control point, tangent vectors, and normal vectors

valSCALE = 0.05; % Scales size of vectors for ease of viewing in plot

close all
figure
hold on
plot(matNODES(:, 1), matNODES(:, 2), '--o')
plot(matCP(:, 1), matCP(:, 2), 'rx')
axis equal 
grid on
for j = 1:1:size(matCP, 1)
    % plot tangents
    quiver(matCP(j, 1),matCP(j, 2), valSCALE.*matTANG(j, 1), ...
        valSCALE.*matTANG(j, 2), 'r')
    
    % plot normals
    quiver(matCP(j, 1),matCP(j, 2), valSCALE.*matNORM(j, 1),...
        valSCALE.*matNORM(j, 2), 'm')
end
hold off


