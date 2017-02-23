function [x,y] = airfoil( naca, c, n)
% Generates x and y coordinates of a NACA 4-digit airfoil. Coordinates are
% outputed counter clockwise starting from the trailing edge
%
%   [x,y] = airfoil(naca, c, n)
%   naca = NACA 4 digit airfoil designation
%   c = chord length
%   n = length of x and y output arrays

% Intermidate variables
% m = maximum camber (100 m is the first digit)
% p = location of maximum camber (10 p is the second digit)
% t = maximum airfoil thickness (100 t is the third and fouth digits)

%% ============ Test Values, comment out when finished ================= %%
% clear
% clc
% naca = 0012;
% c = 1;
% n = 50;
%% ===================================================================== %%
%  If n is odd, make it even
if mod(n,2) == 1
    n = n+1 ;
end

% Read airfoil parameters from 4digit
naca_string = num2str(naca); % Convert naca to a string variable

% Terminate if airfoil is invalid
if size(naca_string, 2) == 3 || size(naca_string, 2) > 4
    error('Invalid Airfoil')
end 

% If airfoil is symmetrical
if size(naca_string, 2) < 4  
    m = 0;
    p = 0;
    t = naca/100;
    type = 0; % Marker indicating airfoil is symmetrical
% Else airfoil is cambered    
else 
    m = str2num(naca_string(1)) /100; % Camber digit to num
    p = str2num(naca_string(2)) / 10; % Location digit to num
    t = str2num(strcat(naca_string(3),naca_string(4))) /100; % Thickness to num
    type = 1; % Marker indicating airfoil is cambered
end

% Calculation of the camber line
if type == 1 % If airfoil is cambered
    x_1 = linspace(0, p*c, ceil(n/4));
    x_2 = linspace(p*c, c, floor(n/4));
    yc_1 = m/p^2.*(2.*p.*(x_1./c) - (x_1./c).^2 );
    yc_2 = m/(1-p)^2 .* ((1-2*p) + 2*p.*(x_2./c) - (x_2./c).^2);
    yc = [yc_1, yc_2].*c;
    xc = [x_1, x_2];
else
   % if airfoil is symmetrical, then the camber line y-coordinates are
   % equal to zero
   % Place half the points at the leading edge
   x_1 = linspace(0, c/4, n/4) ;
   x_2 = linspace (c/4, c, n/4);  
   xc = [x_1, x_2];
   yc = zeros(1, length(xc));
end

% Calculation of thickness
yt = 5.*t.*(0.2969.*(xc./c).^.5 - 0.1260.*(xc./c) - 0.3516.*(xc./c).^2 + 0.2843.*(xc./c).^3 - 0.1015.*(xc./c).^4);
yt = yt.*c;

% Slope of the camber line
if type == 1
    dyc_1 = 2.*m/p^2 .*(p - x_1./c);
    dyc_2 = 2.*m/(1-p)^2.* (p - x_2./c);
    theta_1 = atan(dyc_1);
    theta_2 = atan(dyc_2);
    theta = [theta_1, theta_2];
else
    % Camber line of symmetrical airfoil is zero
    % therefore theta = 0
    theta = zeros(1,length(xc)) ;
end

% Calculation of upper and lower coordinates
x_u = flip(xc - yt.*sin(theta));
y_u = flip(yc + yt.*cos(theta));

% if n is odd, remove one coordinate
if mod(n,2) == 1
    foo = size(xc,2);
    xc(foo) =  [] ;
    yc(foo) = [];
    yt(foo) = [];
    theta(foo) = [];
end

x_l = xc + yt.*sin(theta);
y_l = yc - yt.*cos(theta);

x = [x_u, x_l];
y = [y_u, y_l];

%% =================== Plot, comment out when finished ================= %%
% close all
% hold on
% plot(x,y, '--o')
% grid on
% axis equal
% hold off

end

