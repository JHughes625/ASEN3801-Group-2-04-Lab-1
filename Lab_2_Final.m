% Contributors: Joshua Savage, Daniil Baskakov,
%               Keegan Garncarz, Daniel Jeung,
%               Jackson Hughes
% Course number: ASEN 3801
% File name: Lab_2_Final
% Created: 2/2/2026

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

h = figure();
hold on
plot3(data.TX, data.TY, data.TZ, 'lineWidth', 1.5 ,color='r', lineStyle='--')
view(3)

plot3(data.TX_1, data.TY_1, data.TZ_1, 'lineWidth', 1.5, color='b')
xlabel("x (mm)")
zlabel("z (mm)")
ylabel("y (mm)")
grid on
legend("Aircraft position", "Target Position","Location","best")

exportgraphics(h, "Part3.png","Resolution",960)

%% Part 4
[t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(filename);

%t_vec = table2array(t_vec);

figure();
h1 = tiledlayout(3,1);
nexttile
hold on
plot(t_vec, av_pos_inert(:,1), color='b')
plot(t_vec, tar_pos_inert(:,1), color='r')
ylabel("N position (mm)")
nexttile
hold on
plot(t_vec, av_pos_inert(:,2), color='b')
plot(t_vec, tar_pos_inert(:,2), color='r')
ylabel("E position (mm)")
nexttile
hold on
plot(t_vec, av_pos_inert(:,3), color='b')
plot(t_vec, tar_pos_inert(:,3), color='r')
ylabel("D position (mm)")

xlabel("time (s)")
lg1  = legend("Aircraft position", "Target Position",'Orientation','Horizontal'); 
lg1.Layout.Tile = 'South';

exportgraphics(h1, "Part4_1.png","Resolution",960)

figure();
h2 = tiledlayout(3,1);
nexttile
hold on
plot(t_vec, av_att(:,1)*180/pi(), color='b')
plot(t_vec, tar_att(:,1)*180/pi(), color='r')
ylabel("\phi (3-1-3) [deg]")
nexttile
hold on
plot(t_vec, av_att(:,2)*180/pi(), color='b')
plot(t_vec, tar_att(:,2)*180/pi(), color='r')
ylabel("\theta (3-1-3) [deg]")
nexttile
hold on
plot(t_vec, av_att(:,3)*180/pi(), color='b')
plot(t_vec, tar_att(:,3)*180/pi(), color='r')
ylabel("\psi (3-1-3) [deg]")

xlabel("time (s)")
lg2  = legend("Aircraft attitude", "Target attitude",'Orientation','Horizontal'); 
lg2.Layout.Tile = 'South';

exportgraphics(h2, "Part4_2.png","Resolution",960)

%% Part 5
av_DCM = zeros(3,3,length(t_vec));
tar_DCM = zeros(3,3,length(t_vec));
av_att_313 = zeros(size(av_att));
tar_att_313 = zeros(size(tar_att));

for i = 1:length(t_vec)
    % Find DCM from 3-2-1 Euler angles
    av_DCM(:,:,i) = RotationMatrix321(av_att(i,:));
    tar_DCM(:,:,i) = RotationMatrix321(tar_att(i,:));
    % Find 3-1-3 Euler angles from DCM
    av_att_313(i,:) = EulerAngles313(av_DCM(:,:,i))';
    tar_att_313(i,:) = EulerAngles313(tar_DCM(:,:,i))';
end

% Plotting
figure()
h3 = tiledlayout(3,1);
nexttile
hold on
plot(t_vec, av_att_313(:,1)*(180/pi()),"b")
plot(t_vec,tar_att_313(:,1)*(180/pi()),"r")
ylabel("\phi (3-1-3) [deg]")
xlabel("Time [s]")
nexttile
hold on
plot(t_vec, av_att_313(:,2)*(180/pi()),"b")
plot(t_vec,tar_att_313(:,2)*(180/pi()),"r")
ylabel("\theta (3-1-3) [deg]")
xlabel("Time [s]")
nexttile
hold on
plot(t_vec, av_att_313(:,3)*(180/pi()),"b")
plot(t_vec,tar_att_313(:,3)*(180/pi()),"r")
ylabel("\psi (3-1-3) [deg]")
xlabel("Time [s]")

lg3  = legend("Aerospace Vehicle","Target",'Orientation','Horizontal'); 
lg3.Layout.Tile = 'South';

exportgraphics(h3, "Part5.png","Resolution",960)

%% Part 6 & 7
target_rel_inert = tar_pos_inert - av_pos_inert;
target_rel_inert_t = (target_rel_inert)';
% Part 6 plot
figure()
h4 = tiledlayout(3,1);
nexttile
plot(t_vec, target_rel_inert(:,1))
grid on
xlabel("time(s)")
ylabel("x-position (cm)")
nexttile
plot(t_vec, target_rel_inert(:,2))
grid on
xlabel("time(s)")
ylabel("y-position (cm)")
nexttile
plot(t_vec, target_rel_inert(:,3))
grid on
xlabel("time(s)")
ylabel("z-position (cm)")

exportgraphics(h4, "Part6.png","Resolution",960)

% part 7 plot
r_rel_body = zeros(3, length(av_att));

len = length(av_att);
for i = 1:len
DCM = RotationMatrix321(av_att(i,:));
r_rel_body(:,i) = DCM * target_rel_inert_t(:,i);
%r_rel_body(:,i) = (RotationMatrix321(av_att(:,i))) * target_rel_inert(:,i);

end

figure()
h5 = tiledlayout(3,1);
nexttile
plot(t_vec, r_rel_body(1,:))
grid on
xlabel("time(s)")
ylabel("x-position (cm)")
nexttile
plot(t_vec, r_rel_body(2,:))
grid on
xlabel("time(s)")
ylabel("y-position (cm)")
nexttile
plot(t_vec, r_rel_body(3,:))
grid on
xlabel("time(s)")
ylabel("z-position (cm)")

exportgraphics(h5, "Part7.png","Resolution",960)