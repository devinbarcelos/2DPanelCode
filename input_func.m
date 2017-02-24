function [ matNODES ] = input_func( strFILE )
% [ matNODES ] = input_func( file_name )
% Returns a matrix of x and y nodes from a text file
% file_name is the name of the input file as a strin
% File name MUST be in the following format:
% x1   y1
% x2   y2
% x3   y3
% .    .
% .    .
% xn   yn

fileID =  fopen(strFILE, 'r');
data = fscanf(fileID, '%f');

% Divide up data into x and y components
% If marker j is an even number, than the data point is a y-coordinate
x = [];
y = [];

for j = 1:1:length(data)
    if mod(j,2)== 0
        y = [y; data(j)];
    else
        x = [x; data(j)];
    end
end

matNODES = [x, y];

end

