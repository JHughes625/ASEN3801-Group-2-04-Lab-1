clc;clear;close all;

filename = "3801_Sec002_Test2.csv";

[t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(filename)

%Goal: get position of target relative to the aerospace vehicle in frame E

%position of the target relative to the vehicle in frame E is the position
%of the target in inertial - position of the vehicle(A-B = BA) which is
%target - vehicle = target relative to vehicle

target_rel = tar_pos_inert - av_pos_inert;

figure()


subplot(3, 1, 1)
plot(t_vec, target_rel(:,1))
grid on
xlabel("time(s)")
ylabel("x-position (cm)")

subplot(3, 1, 2)
plot(t_vec, target_rel(:,2))
grid on
xlabel("time(s)")
ylabel("y-position (cm)")

subplot(3, 1, 3)
plot(t_vec, target_rel(:,3))
grid on
xlabel("time(s)")
ylabel("z-position (cm)")
