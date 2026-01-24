
function xdot = objectEOM(t,x,rho,Cd,A,m,g,wind_vel)


% Inputs: t = time [s]
% x = state vector
% rho = air density
% Cd = Coefficient of Drag
% A = Area
% m = mass
% g =acceleration due to Gravity
% wind_vel = Wind Velocity
%ASEN 3801 Spring 2026 Lab 1 2
%
% Outputs: xdot = derivitive of state vector : xdot = [V_N, V_E, V_D, a_N, a_E, a_D]
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

%inertial velocity
V = x(4:6);

%relative wind
V_E = V - wind_vel';

F_drag = -(1/2)*rho*norm(V_E) * A * Cd * V_E;

%total force

%acceleration of object using acc = force/mass
a = F_drag/m + [0 0 g]';

%xdot = [V_N, V_E, V_D, a_N, a_E, a_D];



xdot = [x(4), x(5), x(6), a(1), a(2), a(3)]';

%if the object is below z = 0, stop movement
if (x(3) > 0)
    xdot = [0 0 0 0 0 0]';
end



