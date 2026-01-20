% Contributors: Joshua Savage, Jackson Hughes
% Course number: ASEN 3801
% File name: Lab1_Problem1
% Created: 1/13/2026

clc;
clear;
close all;

%% Problem 1, Part 1 
% Inputs
t_span = [ 0  20 ]; % [t_0 T_f]
InitCond = [ 1 ;  1 ;  1 ;  1]; % [w_0; x_0; y_0; z_0]

% ODE options input for absolute and relative tolerancing
options1 = odeset('RelTol',1e-8,'AbsTol',1e-8);
% Inputs: tolerance values for absolute and relative tolerancing
%
% Output: Options array for ODE45

% ODE function
answer1 = ode45(@odefun, t_span, InitCond , options1);
% Inputs: @odefun = function with the differential system of equations of
%                   w_dot, x_dot, y_dot, z_dot
%         t_span = time span for integration
%         InitCond = Initial Conditions for w, x, y, z
%         Options1 = Options for ODE45 for part 1 of question 1
% Outputs: anwser1 = structure with the returns from ODE45

t1 = answer1.x;
w1 = answer1.y(1,:);
x1 = answer1.y(2,:);
y1 = answer1.y(3,:);
z1 = answer1.y(4,:);

figure(1)
hold on
plot(t1,w1,t1,x1,t1,y1,t1,z1)
hold off

figure(2)

subplot(4, 1, 1)
plot(t1,w1)
title('w v. t')
xlabel('t [n.d.]')
ylabel('w [n.d.]')

subplot(4, 1, 2)
plot(t1,x1)
xlabel('t [n.d.]')
ylabel('x [n.d.]')
title('x v. t')

subplot(4, 1, 3)
plot(t1,y1)
xlabel('t [n.d.]')
ylabel('y [n.d.]')
title('y v. t')

subplot(4, 1, 4)
plot(t1,z1)
xlabel('t [n.d.]')
ylabel('z [n.d.]')
title('z v. t')

clear options1

%% Problem 1, Part 2

for i = 1:6
% Variable ODE options input for absolute and relative tolerancing
options = odeset('RelTol',10^(-2*i),'AbsTol',10^(-2*i));
index = "e_neg_" + num2str(2*i);
answer.(index) = ode45(@odefun, t_span, InitCond , options);
t.(index) = answer.(index).x;
w.(index) = answer.(index).y(1,:);
x.(index) = answer.(index).y(2,:);
y.(index) = answer.(index).y(3,:);
z.(index) = answer.(index).y(4,:);
end

for i = 1:5
    index = "e_neg_" + num2str(2*i);
    max_t = max(t_span);
    % Finding difference between the set tollerancing with 1e-12 at t = 20
    wDiff.(index) = w.(index)(t.(index) == max_t) - w.e_neg_12(t.e_neg_12 == max_t);
    xDiff.(index) = x.(index)(t.(index) == max_t) - x.e_neg_12(t.e_neg_12 == max_t);
    yDiff.(index) = y.(index)(t.(index) == max_t) - y.e_neg_12(t.e_neg_12 == max_t);
    zDiff.(index) = z.(index)(t.(index) == max_t) - z.e_neg_12(t.e_neg_12 == max_t);
end

clear index options max_t

%% Differential System of Equations Function
function dvardt = odefun(t, var)
    % Variables
    % w = var(1)
    % x = var(2)
    % y = var(3)
    % z = var(4)
    
    dvardt = zeros(4,1);
    dvardt(1) = -9*var(1) + var(3); % w_dot = -9w + y
    dvardt(2) = 4*var(1)*var(2)*var(3) - var(2)^2; % x_dot = 4wxy - x^2
    dvardt(3) = 2*var(1) - var(2) - 2*var(4); % y_dot = 2w - x - 2z
    dvardt(4) = var(2)*var(3) - var(3)^2 -3*var(4)^3; % z_dot = xy - y^2 - 3z^3
end