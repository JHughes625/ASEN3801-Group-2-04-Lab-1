%Created by Daniel Min-kuk Jeung
%Inputs: DCM matrix
%Outputs: 3 x 1 vector with the 3-2-1 Euler angles in the form attitude321 = [𝛼𝛼, 𝛽𝛽, 𝛾𝛾]T (In ASEN 3728 notation, this would be equivalent to [𝜙𝜙,𝜃𝜃,𝜓𝜓]T , but this is in degrees).


function attitude321 = EulerAngles321(DCM)

    theta = -asind(DCM(3,1));
    phi = asind(DCM(3.2)/cosd(theta));
    psi = asind(DCM(2,1)/cosd(theta));

    attitude321 = [theta phi psi]';
end



