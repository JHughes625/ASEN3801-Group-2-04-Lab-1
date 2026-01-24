
% Contributors: Daniel Jeung
% Course Number: ASEN 3801
% File Name: objectEOM.m
% Created: 1/23/2026

function xdot = objectEOM(t,x,rho,Cd,A,m,g,wind_vel)
% Inputs: t = time [s]
% x = state vector
% rho = air density
% Cd = Coefficient of Drag
% A = Area
% m = mass
% g =acceleration due to Gravity
% wind_vel = Wind Velocity

% Outputs: xdot = derivitive of state vector : xdot = [V_N, V_E, V_D, a_N, a_E, a_D]
% speed = aircraft airspeed
% beta = side slip angle
% alpha = angle of attack
%
% Methodology: Use first principles to get the accelerations of the state
% vector using the basic drag formula and Newton's First law. 


%inertial velocity
V = x(4:6);

%relative wind
V_E = V - wind_vel';

%Drag force
F_drag = -(1/2)*rho*norm(V_E) * A * Cd * V_E;

%acceleration of object using acc = force/mass
a = F_drag/m + [0 0 g]';

%reconstruct derivitive of state vector
xdot = [x(4), x(5), x(6), a(1), a(2), a(3)]';

%if the object is below z = 0, stop movement
if (x(3) > 0)
    xdot = [0 0 0 0 0 0]';
end
