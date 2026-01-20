
function xdot = objectEOM(t,x,rho,Cd,A,m,g,wind_vel)


% Inputs: t = time [s]
% x = 
% rho = 
% Cd = 
% A = 
% m = 
% g =
% wind_vel =
%ASEN 3801 Spring 2026 Lab 1 2
%
% Outputs: xdot = [speed beta alpha]d
% speed = aircraft airspeed
% beta = side slip angle
% alpha = angle of attack
%
% Methodology: Use definitions to calculate wind angles and speed from velocity
% vector

%In this problem, let%s model the object with a mass of 50 g, a diameter of
%2.0 cm, and coefficient of drag of 0.6. Assume the object is here in Boulder to determine the air
%𝜌𝜌.



%x = [P_N, P_E, P_D, V_N, V_E, V_D];

%% Solve 6 ODES
% the x-dot state vector uses the velocity inputs from x, and uses
% drag/mass to get acceleration components.
%using NED coordinates, we use the input state vector in the same system

a = (0.5 * rho * wind_vel .^2 * A * Cd)./m + [0 0 g];

%xdot = [V_N, V_E, V_D, a_N, a_E, a_D];


xdot = [x(4), x(5), -x(6), a(1), a(2), -a(3)]';

if (x(3) < 0)
    xdot = [0 0 0 0 0 0]';
end



