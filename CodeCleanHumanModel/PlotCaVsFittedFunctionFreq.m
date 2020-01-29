% Plot all Ca human data with fitted functions

clear; close all; clc;
  
freq =[0.5 1 1.5 2 2.5 3];
filename = {'Ca_05.mat','Ca_1.mat','Ca_15.mat','Ca_2.mat','Ca_25.mat','Ca_3.mat'};
% Set temperature fot the experiment environment
tic


figure(1)
hold on;
a = 7.521e-2;
b = 6.102;
% plotting the function for 0.5 Hz
load(filename{1});

% plotting the function for 1 Hz
load(filename{2});
plot(T/max(T), Ca* 1e3,'b','linewidth',2)
t = [0: max(T)/200: max(T)-1]/1000;
stim_period_1 = 1/ freq(2);
phi_1 = mod(t,stim_period_1)/stim_period_1;
Ca_1 = 0.132*b*((20.*phi_1).^0.35).*exp(-(8.*phi_1 )) + a + 0.0236*(freq(2) - 1)  ;
plot(phi_1, Ca_1,'--b','linewidth',2)
pause

% plotting the function for 1.5 Hz
load(filename{3});
plot(T/max(T), Ca* 1e3,'r','linewidth',2)
t = [0: max(T)/200: max(T)-1]/1000;
stim_period_15 = 1/ freq(3);
phi_15 = mod(t,stim_period_15)/stim_period_15;
Ca_15 = 0.154*b*((20.*phi_15).^0.42).*exp(-(7.*phi_15 )) + a + 0.0236*(freq(3) - 1);
plot(phi_15, Ca_15,'--r','linewidth',2)
pause

% plotting the function for 2 Hz
load(filename{4});
plot(T/max(T), Ca* 1e3,'g','linewidth',2)
t = [0: max(T)/200: max(T)-1]/1000;
stim_period_2 = 1/ freq(4);
phi_2 = mod(t,stim_period_2)/stim_period_2;
Ca_2 = 0.164*b*((20.*phi_2).^0.52).*exp(-(7.*phi_2)) + a + 0.0236*(freq(4) - 1);
plot(phi_2, Ca_2,'--g','linewidth',2)
pause

% plotting the function for 2.5 Hz
load(filename{5});
plot(T/max(T), Ca* 1e3,'C','linewidth',2)
t = [0: max(T)/200: max(T)-1]/1000;
stim_period_25 = 1/ freq(5);
phi_25 = mod(t,stim_period_25)/stim_period_25;
Ca_25 = 0.142*b*((20.*phi_25).^0.55).*exp(-(6.*phi_25 )) + a + 0.0236*(freq(5) - 1) ;
plot(phi_25, Ca_25,'--C','linewidth',2)
pause

% plotting the function for 3 Hz 
load(filename{6});
plot(T/max(T), Ca* 1e3,'k','linewidth',2)
t = [0: max(T)/200: max(T)-1]/1000;
stim_period_3 = 1/ freq(6);
phi_3 = mod(t,stim_period_3)/stim_period_3;
Ca_3 = 0.111*b*((20.*phi_3).^0.65).*exp(-(6.*phi_3 )) + a + 0.0236*(freq(6) - 1) ;
plot(phi_3, Ca_3,'--k','linewidth',2)

legend('1 Hz Data','1 Hz Fit','1.5 Hz Data','1.5 Hz Fit','2 Hz Data','2 Hz Fit','2.5 Hz Data','2.5 Hz Fit','3 Hz Data','3 Hz Fit','fontsize',15)


clear Ca T t


