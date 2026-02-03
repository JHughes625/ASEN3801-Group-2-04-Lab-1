% Created by Daniil Baskakov
% ASEN 3801
% RotationMatrix313
% Created: 1/27/26
%Inputs:  attitude313: 3 x 1 vector with the 3-1-3 Euler angles in the form attitude313 = [𝛼𝛼, 𝛽𝛽, 𝛾𝛾]T
%Outputs: DCM: the rotation matrix calculated from the Euler angles.

function DCM = RotationMatrix313(attitude313)


    cos_a = cos(attitude313(1)); %cosine alpha
    sin_a = sin(attitude313(1)); % sine alpha
    cos_b = cos(attitude313(2)); %cosine beta
    sin_b = sin(attitude313(2)); %sine beta
    cos_g = cos(attitude313(3)); %cosine gamma
    sin_g = sin(attitude313(1)); %sine gamma

    % 3-1-3 DCM from class
    DCM = [ (cos_g*cos_a - sin_g*cos_b*sin_a), (cos_g*sin_a + sin_g*cos_b*cos_a), (sin_g*sin_b);
         (-sin_g*cos_a - cos_g*cos_b*sin_a), (-sin_g*sin_a + cos_g*cos_b*cos_a), (cos_g*sin_b);
         (sin_b*sin_a),                     (-sin_b*cos_a),                      (cos_b)     ];

end

