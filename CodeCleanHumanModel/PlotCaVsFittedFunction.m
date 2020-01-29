% Plot all Ca human data with fitted functions

clear; close all; clc;
  
% Define the variables to be tuned and their corresponding numbers as
% following: 
% parameters_string = {'kstiff1' 'kstiff2' 'k_{passive}' 'alpha1' 'alpha2' 'alpha3' 's3' 'K_{Pi}' 'K_{T}' 'K_{D}' 'K_{coop}' 'k_{on}' 'k_{off}' 'k_{1}' 'k_{force}' 'k_{2}'};
% initial_population = [kstiff1(1)  kstiff2 (2) k_passive(3) alpha1(4) alpha2(5) alpha3(6) s3(7) K_Pi(8) K_T(9) K_D(10) K_coop(11) k_on(12) k_off(13) k1(14) kforce(15) k2(16)];
%   initial_population = ones(1,nvar);
freq =[0.5 1 1.5 2 2.5 3];
filename = {'Ca_05.mat','Ca_1.mat','Ca_15.mat','Ca_2.mat','Ca_25.mat','Ca_3.mat'};
% Set temperature fot the experiment environment
tic


figure(1)
hold on;
a = 9e-2;
b = 6.102;
% plotting the function for 0.5 Hz
load(filename{1});
t = [0: max(T)/200: max(T)-1]/1000;

% plotting the function for 1 Hz
load(filename{2});
plot(T/max(T), Ca* 1e3,'b','linewidth',2)
t = [0: max(T)/200: max(T)-1]/1000;

stim_period_1 = 1/ freq(2);
phi_1 = mod(t,stim_period_1)/stim_period_1;
Ca_1 = 0.132*b*((20.*phi_1).^0.3).*exp(-(9.*phi_1 )) + a ;

% plotting the function for 1.5 Hz
load(filename{3});
plot(T/max(T), Ca* 1e3,'r','linewidth',2)
t = [0: max(T)/200: max(T)-1]/1000;

stim_period_15 = 1/ freq(3);
phi_15 = mod(t,stim_period_15)/stim_period_15;
Ca_15 = 0.155*b*((20.*phi_15).^0.42).*exp(-(7.*phi_15 )) + a ;

% plotting the function for 2 Hz
load(filename{4});
plot(T/max(T), Ca* 1e3,'g','linewidth',2)
t = [0: max(T)/200: max(T)-1]/1000;

stim_period_2 = 1/ freq(4);
phi_2 = mod(t,stim_period_2)/stim_period_2;
Ca_2 = 0.168*b*((20.*phi_2).^0.5).*exp(-(7.*phi_2)) + a ;

% plotting the function for 2.5 Hz
load(filename{5});
plot(T/max(T), Ca* 1e3,'y','linewidth',2)
t = [0: max(T)/200: max(T)-1]/1000;

stim_period_25 = 1/ freq(5);
phi_25 = mod(t,stim_period_25)/stim_period_25;
Ca_25 = 0.15*b*((20.*phi_25).^0.5).*exp(-(6.*phi_25 )) + a ;

% plotting the function for 3 Hz
load(filename{6});
plot(T/max(T), Ca* 1e3,'k','linewidth',2)
t = [0: max(T)/200: max(T)-1]/1000;

stim_period_3 = 1/ freq(6);
phi_3 = mod(t,stim_period_3)/stim_period_3;
Ca_3 = 0.114*b*((20.*phi_3).^0.55).*exp(-(5.*phi_3 )) + a ;



plot(phi_1, Ca_1,'--b','linewidth',2)
plot(phi_15, Ca_15,'--r','linewidth',2)
plot(phi_2, Ca_2,'--g','linewidth',2)
plot(phi_25, Ca_25,'--y','linewidth',2)
plot(phi_3, Ca_3,'--k','linewidth',2)

% T_norm = T/max(T);

clear Ca T t


