% The creator: Daniel J

clc;clear;close all
filename = "3801_Sec002_Test1.csv";

%% Part 3
data = readtable(filename,'HeaderLines',3,'ReadVariableNames',true);
data = rmmissing(data);
data = data(2:(max(size(data))),:);

%remove all nans
% checkmatrix = isnan(rawdata)
% checkmatrix = sum(checkmatrix, 2)
% checkmatrix = (checkmatrix>0)
% data = rawdata(~checkmatrix,:)

figure()
hold on
plot3(data.TX, data.TY, data.TZ, 'lineWidth', 1.5 ,color='r', lineStyle='--')
view(3)

plot3(data.TX_1, data.TY_1, data.TZ_1, 'lineWidth', 1.5, color='b')
xlabel("x (mm)")
zlabel("z (mm)")
ylabel("y (mm)")
grid on

%% Part 4
[t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(filename);

%t_vec = table2array(t_vec);

figure();
subplot(3,1,1);
hold on
plot(t_vec, av_pos_inert(:,1), color='b')
plot(t_vec, tar_pos_inert(:,1), color='r')
ylabel("N position (mm)")

subplot(3,1,2)
hold on
plot(t_vec, av_pos_inert(:,2), color='b')
plot(t_vec, tar_pos_inert(:,2), color='r')
ylabel("E position (mm)")

subplot(3,1,3)
hold on
plot(t_vec, av_pos_inert(:,3), color='b')
plot(t_vec, tar_pos_inert(:,3), color='r')
ylabel("D position (mm)")

xlabel("time (s)")
legend("Aircraft position", "Target Position")