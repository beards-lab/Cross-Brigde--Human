% This code is the main driver for the human crossbridge model
clear; close all; clc;
  
% Define the variables to be tuned and their corresponding numbers as
% following: 
% parameters_string = {'kstiff1' 'kstiff2' 'k_{passive}' 'alpha1' 'alpha2' 'alpha3' 's3' 'K_{Pi}' 'K_{T}' 'K_{D}' 'K_{coop}' 'k_{on}' 'k_{off}' 'k_{1}' 'k_{force}' 'k_{2}'};
% initial_population = [kstiff1(1)  kstiff2 (2) k_passive(3) alpha1(4) alpha2(5) alpha3(6) s3(7) K_Pi(8) K_T(9) K_D(10) K_coop(11) k_on(12) k_off(13) k1(14) kforce(15) k2(16)];
%   initial_population = ones(1,nvar);
Data.freq =[0.5 1 1.5 2 2.5 3 0.5 0.5];
filename = {'Ca_05.mat','Ca_1.mat','Ca_15.mat','Ca_2.mat','Ca_25.mat','Ca_3.mat','Ca_05.mat','Ca_05.mat'};
tic
for i = 1:length(Data.freq)-2
load(filename{i});
 
figure(1)
hold on
plot(T,Ca)
clear Ca T F_exp;
end
