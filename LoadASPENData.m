% Contributors: Joshua Savage
% Course number: ASEN 3801
% File name: LoadASPENData.m
% Created: 1/13/2026

function [t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(filename)

% Data Input and Conversion
%filename = "3801_Sec001_Test1.csv";
data = readtable(filename,'HeaderLines',3,'ReadVariableNames',true);
data = rmmissing(data);
data = data(2:(max(size(data))),:);

% Time Vector Processing
t_vec = table2array(data(:,1)./100); % [Sec] Frame number divided by 100Hz

pos_av_aspen = table2array(data(:,12:14)).';
att_av_aspen = table2array(data(:,9:11)).';
pos_tar_aspen = table2array(data(:,6:8)).';
att_tar_aspen = table2array(data(:,3:5)).';

[pos_av_class, att_av_class, pos_tar_class, att_tar_class] ...
    = ConvertASPENData(pos_av_aspen, att_av_aspen,  pos_tar_aspen, att_tar_aspen);
% Inputs: ASPEN Position Vector in Motion Capture Frame and Helical Angles
%         pos_av_aspen, att_av_aspen,  pos_tar_aspen, att_tar_aspen
%
% Output: Position Vector in Frame E and 3-2-1 Euler angles 
%         pos_av_class, att_av_class, pos_tar_class, att_tar_class


av_pos_inert = pos_av_class.'; % [mm] Inertial position of Vehicle
av_att = att_av_class.'; % [Rad] Inertial euler angles of Vehicle
tar_pos_inert = pos_tar_class.'; % [mm] Inertial position of Target
tar_att = att_tar_class.'; % [Rad] Inertial euler angles of Target

end