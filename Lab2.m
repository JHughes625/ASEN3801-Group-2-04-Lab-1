% Contributors: Joshua Savage
% Course number: ASEN 3801
% File name: Lab2
% Created: 1/13/2026

clc;
clear;
close all;

%% Data Input and Conversion
filename = "3801_Sec001_Test1.csv";
data = readtable(filename,'HeaderLines',3,'ReadVariableNames',true);
data = data(2:(max(size(data))),:);

pos_av_aspen = table2array(data(:,12:14)).';
att_av_aspen = table2array(data(:,9:11)).';
pos_tar_aspen = table2array(data(:,6:8)).';
att_tar_aspen = table2array(data(:,3:5)).';

[pos_av_class, att_av_class, pos_tar_class, att_tar_class] ...
    = ConvertASPENData(pos_av_aspen, att_av_aspen,  pos_tar_aspen, att_tar_aspen);

ConData.Frame = data(:,1);
ConData.pos_av_class = pos_av_class.';
ConData.att_av_class = att_av_class.';
ConData.pos_tar_class = pos_tar_class.';
ConData.att_tar_class = att_tar_class.';

clear pos_av_aspen att_av_aspen  pos_tar_aspen att_tar_aspen pos_av_class att_av_class pos_tar_class att_tar_class

