% Created by Daniil Baskakov
% ASEN 3801
% RotationMatrix313
% Created: 1/27/26
%Inputs:  attitude313: 3 x 1 vector with the 3-1-3 Euler angles in the form attitude313 = [𝛼𝛼, 𝛽𝛽, 𝛾𝛾]T
%Outputs: DCM: the rotation matrix calculated from the Euler angles.

clear; clc; close all;

function DCM = RotationMatrix313(attitude313)

    a = attitude313(1); % alpha
    b = attitude313(2); % beta
    g = attitude313(3); % gamma

    cos_a = cos(attitude313(1));
    sin_a = sin(attitude313(1));
    cos_b = cos(attitude313(2));
    sin_b = sin(attitude313(2));
    cos_g = cos(attitude313(3));
    sin_g = sin(attitude313(1));

    % 3-1-3 DCM from class
    C = [ (cos_g*cos_a - sin_g*cos_b*sin_a), (cos_g*sin_a + sg*cb*ca), (sg*sb);
         (-sg*ca - cg*cb*sa), (-sg*sa + cg*cb*ca), (cg*sb);
         (sb*sa),            (-sb*ca),            (cb)     ];
