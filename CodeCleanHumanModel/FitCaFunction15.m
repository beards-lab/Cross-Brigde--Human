% This code is for the human crossbridge model
clear; close all; clc;
  

%  filename = {'Ca_1.mat','Ca_15.mat','Ca_2.mat','Ca_25.mat','Ca_3.mat'};
 filename = {'Ca_15.mat','Ca_2.mat','Ca_25.mat'};

%  freq = [1 1.5 2 2.5 3];
freq = [1.5]

for i = 1:1
load(filename{i});
figure(1)

hold on;
t = [0: max(T)/200: max(T)]/1000;

stim_period = 1/ freq(i);
Ca = Ca *1e3;
phi = mod(t,stim_period)/stim_period;
% Ca_i = 0.142 *((20.*(phi+0.05)).^4).*exp(-(20.*(phi+0.05)))+0.09
% a = 9e-5
% b = 0.006102 
% 
% % Ca_i = 0.142*b*((20.*phi).^0.18).*exp(-(6.*phi ))+a 
% 
a = 9e-2;
b = 6.102;

% Ca_i = 0.142*b*((20.*phi).^0.18).*exp(-(6.*phi )) + a ;

Ca_i = 0.155*b*((20.*phi).^0.42).*exp(-(7.*phi )) + a ;

% Ca_i = circshift(Ca_i,3)


plot(T/max(T), Ca)
plot(phi, Ca_i)
T_norm = T/max(T);

clear Ca T t

% pause
end