function [vecR] = resultant(vecUINF, matNORM)
% This function calculated the resultant vector
% Normals dotted with freestream velocity
%
%   INPUTS
%   vecUINF - Velocity direction vector
%   matNORM - Normal vectors
%
%   OUTPUTS
%   vecR - Resultant vector

len = length(matNORM);
len = len(1);

% Make vecUINF the same size at matNORM
matUINF = repmat(vecUINF,[len,1]);

% Calculate resultant vector
% b = -1*norm*uinf
vecR = dot(matNORM,matUINF,2);

end

