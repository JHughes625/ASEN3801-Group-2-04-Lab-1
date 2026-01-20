clear; clc; close all
%% this function uses objectEOM to pass into a ODE45 call


%Given constants:
t_span = [0, 10]; %Unknown for now

%x = [P_N, P_E, P_D, V_N, V_E, V_D];

Cd = .6; %
m = 50 * 10^(-3); %kg
diameter = 2 * 10^(-2); %m
A = pi * (diameter/2)^2;    %m.^2
g = -9.81; %m/s

rho =  stdatmo(1655,0,m);

%initial conditions:
x_0 = [0 0 0 0 20 -20];
wind_vel = [0 0 0];

options = odeset('RelTol', 10^(-8), 'AbsTol', 10^(-8));


%xdot = objectEOM(t,x,rho,Cd,A,m,g,wind_vel)

[t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m,g,wind_vel), t_span, x_0, options)

plot3(x(:,1), x(:,2) , x(:,3))
xlabel("x")
ylabel("y")
zlabel("z")

daspect ([1 1 1])
axis equal
grid on

axis square



