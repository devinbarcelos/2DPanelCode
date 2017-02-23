function [ x,y ] = cyn_panel( r, n )
% cyn_panel( r, n )
% Divides a cylinder of radius r into n number of panels (n+1 nodes)
% Retruns x and y coordinates of each node

% Test Values COMMENT OUT BEFORE MOVING ON
% r = 1;
% n = 10;

% Array of angles sweeping out the circle
th = linspace(0, 2*pi, n+1); 

% Transform in to cartesian coordinates
x = r.*cos(th);
y = r.*sin(th);

% Test plot, comment out before moving on
% figure

end


