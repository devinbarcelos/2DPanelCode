function [matCP, vecS, matTANG, matNORM, vecEPS] = control_point( matNODES)
% [xc, yc, tc, normc ] = control_point( x, y)
% Inputs node x and y coordinates
% Outputs the x and y coordinates of the control points (matCP), 
% the length of the panel (vecS),  and 
% the unit vector for the panel tangent (matTANG) and normal (matNORM)

%TEST CASE COMMENT OUT BEFORE MOVING ON
% naca = 2412;
% r = 1;
% n = 10;
% [x,y] = cyn_panel(r, n);

% Extract x and y coordinates from matNODES
x = matNODES(:,1);
y = matNODES(:,2);

% Pre-allocate output arrays and matricies
vecS = zeros(1, length(x)-1);
nx = vecS;
ny = vecS;
tx = vecS;
ty = vecS;
xc = vecS;
yc = vecS;
vecEPS = vecS;

for j = 2:1:length(x)       
    % Calculate the panel length
    vecS(j-1) = sqrt( (x(j) - x(j-1))^2 + (y(j) - y(j-1))^2  ); 
    
    % Compute the tangents of the panel
     tx(j-1) = (x(j) - x(j-1))/vecS(j-1);
     ty(j-1) = (y(j) - y(j-1))/vecS(j-1);
     
     % Compute the normals of the panel by multiplying by a rotation matrix
     % https://en.wikipedia.org/wiki/Rotation_matrix
     t = [ tx(j-1), ty(j-1)];
     normals = t*[0 -1; 1 0];
     nx(j-1) = normals(1);
     ny(j-1) = normals(2);
     
     % Compute the x and y control points
     xc(j-1) = (x(j) + x(j-1))/2;
     yc(j-1) = (y(j) + y(j-1))/2;
     
     % Compute the panel orientation angle (in radians)
     
     vecEPS(j-1) = atan(ty(j-1)/tx(j-1));     
end

% Convert all values into their outputted matricies in coloumn form
matCP = [xc', yc'];
vecS = vecS';
matTANG = [tx' , ty'];
matNORM = [nx', ny'];
vecEPS = vecEPS';


% Test plot, comment out when complete

% hold on
% plot(x,y, '--o')
% plot(xc, yc, 'rx')
% axis equal 
% grid on
% for j = 1:1:length(tx)
%     % plot tangents
%     quiver(xc(j),yc(j), tx(j), ty(j), 'r')
%     
%     % plot normals
%     quiver(xc(j),yc(j), nx(j), ny(j), 'r')
% end
% hold off
end 



