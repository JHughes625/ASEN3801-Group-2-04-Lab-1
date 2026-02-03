clc;clear;close all;

filename = "3801_Sec002_Test1.csv";

[t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(filename);

%Goal: get position vector of target relative to drone, in the body coords
%of the drone


target_rel_inert = tar_pos_inert - av_pos_inert;
target_rel_inert_t = (target_rel_inert)';

r_rel_body = zeros(3, length(av_att));

len = length(av_att);
for i = 1:len
DCM = RotationMatrix321(av_att(i,:));
r_rel_body(:,i) = DCM * target_rel_inert_t(:,i);
%r_rel_body(:,i) = (RotationMatrix321(av_att(:,i))) * target_rel_inert(:,i);

   
end

figure()


subplot(3, 1, 1)
plot(t_vec, r_rel_body(1,:))
grid on
xlabel("time(s)")
ylabel("x-position (cm)")

subplot(3, 1, 2)
plot(t_vec, r_rel_body(2,:))
grid on
xlabel("time(s)")
ylabel("y-position (cm)")

subplot(3, 1, 3)
plot(t_vec, r_rel_body(3,:))
grid on
xlabel("time(s)")
ylabel("z-position (cm)")


