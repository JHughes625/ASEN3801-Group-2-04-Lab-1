% Contributors: Keegan Garncarz
% Course number: ASEN 3801
% File name: function2
% Created: 1/27/2026

function DCM = RotationMatrix321(attitude321)
% RotationMatrix321
% Computes the direction cosine matrix (DCM) for a 3-2-1 Euler angle sequence
%
% Inputs:
%   attitude321 = [alpha; beta; gamma]
%                 alpha = rotation about 1-axis (phi)
%                 beta  = rotation about 2-axis (theta)
%                 gamma = rotation about 3-axis (psi)
%
% Outputs:
%   DCM = 3x3 direction cosine matrix

% Extract Euler angles
alpha = attitude321(1);
beta  = attitude321(2);
gamma = attitude321(3);

% Rotation about 1-axis (x)
R1 = [ 1,      0,           0;
       0, cos(alpha),  sin(alpha);
       0, -sin(alpha), cos(alpha)];

% Rotation about 2-axis (y)
R2 = [ cos(beta),  0, -sin(beta);
            0,     1,      0;
       sin(beta),  0,  cos(beta)];

% Rotation about 3-axis (z)
R3 = [ cos(gamma),  sin(gamma), 0;
      -sin(gamma),  cos(gamma), 0;
            0,           0,     1];

% 3-2-1 rotation sequence
DCM = R1 * R2 * R3;

end

