function [energy] = cal_energy(J,N,sample)
%CAL_ENERGY 此处显示有关此函数的摘要
%   此处显示详细说明

energy=0;
for en=1:N-1
    temp_en=sample(en)*sample(en+1);
    energy=energy+temp_en;
end
energy=J*-1*energy;
end

