function [ matNODES] = flat_plate( valC, valN )
% Creates the nodes for an arbitrary flate plate of chord length valC, valN
% [ matNODES] = flat_plate( valC, valN )

y = zeros(valN, 1); %Flate plate therefore all ys are zero
x = linspace(0, valC, valN);
x = x';

matNODES = [x, y]; % Output matrix

end

