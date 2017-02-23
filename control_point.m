function [xc, yc, s, tx, ty, nx, ny, e] = control_point( x, y)
% [xc, yc, tc, normc ] = control_point( x, y)
% Inputs node x and y coordinates
% Outputs the x and y coordinates of the control points (xc,yc), 
% the length of the panel (s),  and 
% the unit vector for the panel tangent (tx,ty) and normal (nx,ny)

% TEST CASE COMMENT OUT BEFORE MOVING ON
% naca = 2412;
% r = 1;
% n = 10;
% [x,y] = cyn_panel(r, n);

% Pre-allocate output arrays
s = zeros(1, length(x)-1);
nx = s;
ny = s;
tx = s;
ty = s;
xc = s;
yc = s;
e = s;

for j = 2:1:length(x)       
    % Calculate the panel length
    s(j-1) = sqrt( (x(j) - x(j-1))^2 + (y(j) - y(j-1))^2  ); 
    
    % Compute the tangents of the panel
     tx(j-1) = (x(j) - x(j-1))/s(j-1);
     ty(j-1) = (y(j) - y(j-1))/s(j-1);
     
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
     
     e(j-1) = atan(ty(j-1)/tx(j-1));     
end

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



