%% ======================= Source Panel Code =========================== %%
% Version 1.0
% Authors: Scott Lindsay, Devin Barcelos
%
% Calcualtes the lift acting on a shape using source panel method.
% Imbedded in the code is a geometry generator for a cylinder of radius r 
% and a geometry generator for any NACA 4-digit series airfoil of chord
% length c
%
%
clc
clear
%% ===================== Intialize Cylinder Geometry =================== %%
% Comment out this block if the cylinder case is not being used

r = 1; % Cylinder radius
n = 100; % Number of panels

% Pass cylinder information to cylinder generation function
% Returns coordinates of each node
[node.x,  node.y] = cyn_panel(r, n); 

%% ========================= Airfoil Case ============================== %%
% Comment out this block if the airfoil case is not being used

naca = 2412; % 4-Digit airfoil
c = 10; % Approximate Chord length
n = 50; % Approximate number of panels

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
%[node.x,node.y,c,n] = airfoil_panel(naca, c, n);

%% ====================== Control Points =============================== %%

% Passes x and y node coordinate information to the control_point function
% which returns the x and y coordinates of the panel control point (x,y),
% the panel length (s), the tangent vector (tx, ty), and  the normal vector
% (nx, ny)s
[panel.x, panel.y, panel.s, panel.tx, panel.ty,...
    panel.nx, panel.ny, panel.e]...
    = control_point( node.x, node.y);


%% ============================ Plot Geometry ========================== %%

% Plots the nodes, panel control point, tangent vectors, and normal vectors
close all
figure
hold on
plot(node.x,node.y, '--o')
plot(panel.x, panel.y, 'rx')
axis equal 
grid on
for j = 1:1:length(panel.tx)
    % plot tangents
    quiver(panel.x(j),panel.y(j), panel.tx(j), panel.ty(j), 'r')
    
    % plot normals
    quiver(panel.x(j),panel.y(j), panel.nx(j), panel.ny(j), 'm')
end
hold off


