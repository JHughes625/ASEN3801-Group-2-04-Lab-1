
%% this function uses objectEOM to pass into a ODE45 call
clear; clc; close all
set(0, 'defaultFigureUnits', 'inches', 'defaultFigurePosition', [1 1 8 5]);
% figures are 8" wide and 5" tall, with the bottom left corner of the
%figure beginning 1" up, and 1" to the right from the bottom left corner
set(0,'defaultLineLineWidth',2.5) % sets all line widths of plotted lines
set(0,'DefaultaxesLineWidth', 1.5) % sets line widths of axes
set(0,'DefaultaxesFontSize', 14)
set(0,'DefaultTextFontSize', 14)
set(0,'DefaultaxesFontName', 'Times new Roman')
set(0,'DefaultlegendFontName', 'Times new Roman')
set(0,'defaultAxesXGrid','on')
set(0,'defaultAxesYGrid','on')


%sample state vector
%x = [P_N, P_E, P_D, V_N, V_E, V_D];

%constants
Cd = .6; %
m = 50 * 10^(-3); %kg
diameter = 2 * 10^(-2); %m
A = pi * (diameter/2)^2;    %m.^2
g = 9.81; %m/s
rho =  stdatmo(1655);
wind_vel = [0 0 0];


%initial conditions:
x_0 = [0 0 0 0 20 -20];

%ode45 call
t_span = [0, 10]; %Unknown for now
options = odeset('RelTol', 10^(-8), 'AbsTol', 10^(-8));
[t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m,g,wind_vel), t_span, x_0, options);

%Plot the stuff
plot3(x(:,1), x(:,2) , x(:,3))
set(gca, 'ZDir', 'reverse')
xlabel("North")
ylabel("East")
zlabel("Down")
title("Trajectory of ball: no wind")

grid on

%% Part D

%varying north wind velocity
w_speed = 0 :2: 60;

for i = 1 : length(w_speed)
    wind_vel = [w_speed(i) 0 0];
    [t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m,g,wind_vel), t_span, x_0, options);
    x_disp(i) = x(end, 1);
    disp_total(i) = norm(x(end,1 : 3));
end
 

figure()
plot(w_speed, x_disp, 'LineWidth', 1.5);
xlabel("Northward Wind")
ylabel("Horizontal Displacement")
title("Effect of Wind on Eastward Displacement")

figure()
plot(w_speed, disp_total, 'LineWidth', 1.5)
xlabel("Northward Wind (m/s)")
ylabel("Total Displacement (m)")
title("Effect of Wind on Total Displacement")


%% Part E

altitude = 0 : 200 : 2000;

figure()
title("Effect of altitude on drag")
xlabel("Wind Speed (m/s)")
ylabel("Total Displacement (m)")
hold on

Nalt = length(altitude);
cmap = turbo(Nalt);      % jet, turbo, parula all work well
colormap(cmap)

cb = colorbar;
cb.Label.String = 'Altitude (m)';
caxis([min(altitude) max(altitude)])

for j = 1 : length(altitude)
    for i = 1 : length(w_speed)
        rho =  stdatmo(altitude(j));
        wind_vel = [w_speed(i) 0 0];
        [t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m,g,wind_vel), t_span, x_0, options);
        disp_total(i) = norm(x(end,1 : 3));
        
    end
    %displays the distance between the origin and landing location as a function of the wind speed.
    plot(w_speed, disp_total, 'LineWidth', 1.5, 'Color', cmap(j,:));
    
    min_disp(j) = min(disp_total)
end

%minimum distance between the origin and landing location as a function of the geopotential altitude.
figure()
plot(altitude, min_disp)
title("Effect of Geopotential Altitude on Minimum Total Displacement for Varying Winds")
xlabel("Altitude (m)")
ylabel("Minimum Displacement")

%% Part F
KE = 0.5 * m * norm(x_0(4:6))^2;
disp_total = [0];
rho =  stdatmo(1655);
m = linspace(0.005, 0.1, 100) ;


%no wind part

wind_vel = [0 0 0]
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
%max wind part

wind_vel = [60 0 0]
for i = 1 : length(m)
    V = sqrt(2 .* KE ./m(i));
    x_0 = [0 0 0 0 V/sqrt(2) -V/sqrt(2)];
    [t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m(i),g,wind_vel), t_span, x_0, options);
    disp_total(i) = norm(x(end,1 : 3));
end
figure()
plot(m, disp_total)
title("Effect of mass on displacement with constant Kinetic Energy (60 m/s winds)")

xlabel("Mass (kg)")
ylabel("Total Displacement (m)")

%varying wind

wind_vel = 0 : 5 : 60;
figure()
hold on;

Nalt = length(wind_vel);
cmap = turbo(Nalt);      % jet, turbo, parula all work well
colormap(cmap)

cb = colorbar;
cb.Label.String = 'Wind (m/s)';
caxis([min(wind_vel) max(wind_vel)])

title("Effect of mass on displacement with constant Kinetic Energy (varying wind)")

for j = 1 : length(wind_vel)
    for i = 1 : length(m)
        V = sqrt(2 .* KE ./m(i));
        x_0 = [0 0 0 0 V/sqrt(2) -V/sqrt(2)];
        [t, x] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m(i),g,[wind_vel(j) 0 0]), t_span, x_0, options);
        disp_total(i) = norm(x(end,1 : 3));
    end
    plot(m, disp_total, 'LineWidth', 1.5, 'Color', cmap(j,:));
end
