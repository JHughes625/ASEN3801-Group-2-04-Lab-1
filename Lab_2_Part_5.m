clc
clear
close all

filename = "3801_Sec001_Test1.csv";
[t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(filename);

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
tiledlayout(3,1)
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

lg  = legend("Aerospace Vehicle","Target",'Orientation','Horizontal'); 
lg.Layout.Tile = 'South';




