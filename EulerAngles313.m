% Contributors: Keegan Garncarz
% Course number: ASEN 3801
% File name: function5
% Created: 1/27/2026
function attitude313 = EulerAngles313(DCM)
% EulerAngles313
% Extracts 3-1-3 Euler angles from a direction cosine matrix (DCM)
%
% Inputs:
%   DCM = 3x3 direction cosine matrix
%
% Outputs:
%   attitude313 = [alpha; beta; gamma] (radians)

% Beta from R33 = cos(beta)
beta = acos(DCM(3,3));

% Handle singularity when sin(beta) ~ 0 (beta ~ 0 or pi)
if abs(sin(beta)) < 1e-10
    % In the singular case, alpha and gamma are not uniquely defined.
    % Choose alpha = 0 and compute the combined rotation about axis-3.
    alpha = 0;

    % If beta ~ 0, DCM behaves like R3(alpha+gamma)
    % Use the top-left 2x2 block to get the net yaw angle
    gamma = atan2(DCM(1,2), DCM(1,1));

    % Force beta to exactly 0 or pi based on DCM(3,3)
    if DCM(3,3) > 0
        beta = 0;
    else
        beta = pi;
    end
else
    % General case for 3-1-3 (consistent with DCM = R3(alpha)*R1(beta)*R3(gamma))
    alpha = atan2(DCM(1,3), DCM(2,3));
    gamma = atan2(DCM(3,1), -DCM(3,2));
end

attitude313 = [alpha; beta; gamma];

end