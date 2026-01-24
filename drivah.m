% Contributors: Daniel Jeung
% Course Number: ASEN 3801
% File Name: drivah.m
% Created: 1/23/2026
%
% Inputs:
%   None
%
% Outputs:
%   A series of plots describing the dynamics of a sphere under varying
%   wind speeds, altitudes, and mass conditions.
%
% Methodology:
%   Uses numerical integration (ode45) with varying initial conditions
%   and environmental parameters. The equations of motion are defined
%   in objectEOM.m and are evaluated for multiple parametric sweeps.

%% Cleanup and Plot Formatting
clear; clc; close all

% Global figure and plot appearance settings for consistency
set(0, 'defaultFigureUnits', 'inches', 'defaultFigurePosition', [1 1 8 5]);
set(0,'defaultLineLineWidth',2.5)         % Default line width
set(0,'DefaultaxesLineWidth', 1.5)        % Axes line width
set(0,'DefaultaxesFontSize', 14)          % Axes font size
set(0,'DefaultTextFontSize', 14)          % Text font size
set(0,'DefaultaxesFontName', 'Times new Roman')
set(0,'DefaultlegendFontName', 'Times new Roman')
set(0,'defaultAxesXGrid','on')             % Enable gridlines
set(0,'defaultAxesYGrid','on')

%% State Vector Definition
% x = [P_N, P_E, P_D, V_N, V_E, V_D]
% Position is expressed in NED coordinates

%% Physical Constants and Object Properties
Cd = .6;                      % Drag coefficient
m = 50 * 10^(-3);             % Mass (kg)
diameter = 2 * 10^(-2);       % Diameter (m)
A = pi * (diameter/2)^2;      % Cross-sectional area (m^2)
g = 9.81;                     % Gravitational acceleration (m/s^2)
rho =  stdatmo(1655);         % Air density at reference altitude
wind_vel = [0 0 0];           % Initial wind velocity vector (m/s)

%% Initial Conditions
% Initial position at origin with prescribed velocity components
x_0 = [0 0 0 0 20 -20];

%% ODE Solver Setup
t_span = [0, 10];             % Time span for integration
options = odeset('RelTol', 10^(-8), 'AbsTol', 10^(-8));

% Numerical integration of equations of motion
[t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m,g,wind_vel), t_span, x_0, options);

%% Trajectory Visualization (No Wind Case)
plot3(x(:,1), x(:,2) , x(:,3))
set(gca, 'ZDir', 'reverse')   % Reverse Z-axis for NED convention
xlabel("North")
ylabel("East")
zlabel("Down")
title("Trajectory of ball: no wind")
print('1','-dpng','-r300')
grid on

%% Part D: Effect of Wind Speed on Displacement

% Northward wind velocity sweep
w_speed = 0 :2: 60;

for i = 1 : length(w_speed)
    wind_vel = [w_speed(i) 0 0];
    
    % Integrate trajectory for current wind speed
    [t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m,g,wind_vel), t_span, x_0, options);
    
    % Store final horizontal and total displacement
    x_disp(i) = x(end, 1);
    disp_total(i) = norm(x(end,1 : 3));
end

% Horizontal displacement vs wind speed
figure()
plot(w_speed, x_disp, 'LineWidth', 1.5);
xlabel("Northward Wind")
ylabel("Horizontal Displacement")
title("Effect of Wind on Eastward Displacement")
print('2','-dpng','-r300')

% Total displacement vs wind speed
figure()
plot(w_speed, disp_total, 'LineWidth', 1.5)
xlabel("Northward Wind (m/s)")
ylabel("Total Displacement (m)")
title("Effect of Wind on Total Displacement")
print('3','-dpng','-r300')

%% Part E: Effect of Altitude on Drag-Induced Displacement

altitude = 0 : 200 : 2000;

figure()
title("Effect of altitude on drag")
xlabel("Wind Speed (m/s)")
ylabel("Total Displacement (m)")
hold on

% Colormap setup for altitude visualization
Nalt = length(altitude);
cmap = turbo(Nalt);
colormap(cmap)

cb = colorbar;
cb.Label.String = 'Altitude (m)';
caxis([min(altitude) max(altitude)])

for j = 1 : length(altitude)
    for i = 1 : length(w_speed)
        rho =  stdatmo(altitude(j));
        wind_vel = [w_speed(i) 0 0];
        
        % Integrate equations of motion at current altitude and wind speed
        [t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m,g,wind_vel), t_span, x_0, options);
        disp_total(i) = norm(x(end,1 : 3));
    end
    
    % Plot total displacement vs wind speed for each altitude
    plot(w_speed, disp_total, 'LineWidth', 1.5, 'Color', cmap(j,:));
    
    % Store minimum displacement for each altitude
    min_disp(j) = min(disp_total)
end
print('4','-dpng','-r300')

% Minimum displacement vs altitude
figure()
plot(altitude, min_disp)
title("Effect of Geopotential Altitude on Minimum Total Displacement for Varying Winds")
xlabel("Altitude (m)")
ylabel("Minimum Displacement")
print('5','-dpng','-r300')

%% Part F: Constant Kinetic Energy Analysis

% Initial kinetic energy based on original velocity
KE = 0.5 * m * norm(x_0(4:6))^2;
disp_total = [0];

% Reset atmospheric density
rho =  stdatmo(1655);

% Mass sweep
m = linspace(0.005, 0.1, 100);

%% No-Wind Case
wind_vel = [0 0 0];
for i = 1 : length(m)
    V = sqrt(2 .* KE ./m(i));
    x_0 = [0 0 0 0 V/sqrt(2) -V/sqrt(2)];
    
    [t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m(i),g,wind_vel), t_span, x_0, options);
    disp_total(i) = norm(x(end,1 : 3));
end

figure()
plot(m, disp_total)
title("Effect of mass on displacement with constant Kinetic Energy (no wind)")
xlabel("Mass (kg)")
ylabel("Total Displacement (m)")
print('6','-dpng','-r300')

%% Maximum Wind Case (60 m/s)
wind_vel = [60 0 0];
for i = 1 : length(m)
    %recalculate initial conditions
    V = sqrt(2 .* KE ./m(i));
    x_0 = [0 0 0 0 V/sqrt(2) -V/sqrt(2)];
    
    %ode45 and objectEOM call
    [t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m(i),g,wind_vel), t_span, x_0, options);
    disp_total(i) = norm(x(end,1 : 3));
end

figure()
plot(m, disp_total)
title("Effect of mass on displacement with constant Kinetic Energy (60 m/s winds)")
xlabel("Mass (kg)")
ylabel("Total Displacement (m)")
print('7','-dpng','-r300')

%% Varying Wind Case (Constant Kinetic Energy)

wind_vel = 0 : 5 : 60;
figure()
hold on;

% Colormap setup for wind speed visualization
Nalt = length(wind_vel);
cmap = turbo(Nalt);
colormap(cmap)
cb = colorbar;
cb.Label.String = 'Wind (m/s)';
caxis([min(wind_vel) max(wind_vel)]);

title("Effect of mass on displacement with constant Kinetic Energy (varying wind)")
xlabel("Mass (kg)")
ylabel("Total Displacement (m)")

%iterate over all wind velocities
for j = 1 : length(wind_vel)
    for i = 1 : length(m)
        %recalculate initial conditions for every iteration
        V = sqrt(2 .* KE ./m(i));
        x_0 = [0 0 0 0 V/sqrt(2) -V/sqrt(2)];
        
        [t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m(i),g,[wind_vel(j) 0 0]), t_span, x_0, options);
        disp_total(i) = norm(x(end,1 : 3));
    end
    
    % Plot displacement vs mass for each wind speed
    plot(m, disp_total, 'LineWidth', 1.5, 'Color', cmap(j,:));
end
print('8','-dpng','-r300')
