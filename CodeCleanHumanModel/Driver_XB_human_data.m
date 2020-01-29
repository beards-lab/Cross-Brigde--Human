% This code is the main driver for the human crossbridge model
clear; close all; clc;
  
% Define the variables to be tuned and their corresponding numbers as
% following: 
% parameters_string = {'kstiff1' 'kstiff2' 'k_{passive}' 'alpha1' 'alpha2' 'alpha3' 's3' 'K_{Pi}' 'K_{T}' 'K_{D}' 'K_{coop}' 'k_{on}' 'k_{off}' 'k_{1}' 'k_{force}' 'k_{2}'};
% initial_population = [kstiff1(1)  kstiff2 (2) k_passive(3) alpha1(4) alpha2(5) alpha3(6) s3(7) K_Pi(8) K_T(9) K_D(10) K_coop(11) k_on(12) k_off(13) k1(14) kforce(15) k2(16)];
%   initial_population = ones(1,nvar);
Data.freq =[0.5 1 1.5 2 2.5 3 0.5 0.5];
filename = {'Ca_05.mat','Ca_1.mat','Ca_15.mat','Ca_2.mat','Ca_25.mat','Ca_3.mat','Ca_05.mat','Ca_05.mat'};
forcename = {'force_05F.mat','force_1F.mat','force_15F.mat','force_2F.mat','force_25F.mat','force_3F.mat','force_090L.mat','force_095L.mat'};
% Set temperature fot the experiment environment
Data.TmpC = 37.5; % centigrade 
tic
for i = 1:length(Data.freq)
 load(filename{i});
 load(forcename{i});

eval(['Data.Ca' num2str(i) '= Ca;']);
 
eval(['Data.T' num2str(i) '= T;']);

% Data.Ca.(num2str) = Ca
% Data.T
eval(['Data.F_exp' num2str(i) '= F_exp;']);
clear Ca T F_exp;
end

freq = Data.freq;
% filename = {'Ca_05.mat','Ca_1.mat','Ca_15.mat','Ca_2.mat','Ca_25.mat','Ca_3.mat'};

% Set metabolite concentrations,

MgATP = 8.0494; % mM
MgADP = 17.7e-3; % mM
Pi = 0.59287; % mM
% define one paramater variable as an input for the for the subroutine


%  SL0 = [1.98,2.09,2.2]; % Set sarcomere lengths, Units: um
SL0 = 2.2;

kstiff1 = 5.2561e+03; % unit (kPa/um) 
kstiff2 = 9.5477e+04; % unit (kPa/um)

dr = 0.01; % Power-stroke Size; Units: um

k_passive = 42.7173/2; % mN / mm^2 / micron

L0 = 0.95; % micron
Kse  = 1000; % kPa*micrometer^-1
% loading the Ca data file, the variable Freq should also change according to the freq Ca.
for i = 1:length(freq)
%         load(filename{i}); % unit (mM)
%  eval(['Ca'  '= parameters.Ca' num2str(i)]);
%  eval(['T'  '= parameters.T' num2str(i)]);
if i == 1 
    Ca = Data.Ca1;
    T = Data.T1;
elseif i == 2
    Ca = Data.Ca2;
    T = Data.T2;
elseif i == 3
    Ca = Data.Ca3;
    T = Data.T3;
elseif i == 4
    Ca = Data.Ca4;
    T = Data.T4;
elseif i == 5
    Ca = Data.Ca5;
    T = Data.T5;
elseif i == 6
    Ca = Data.Ca6;
    T = Data.T6;
elseif i == 7
    Ca = Data.Ca7;
    T = Data.T7;
    SL0 = 1.98;
elseif i == 8
    Ca = Data.Ca8;
    T = Data.T8;
    SL0 = 2.09;
end

stim_f = 1e3/freq(i);
tspan = 0:1:stim_f;

para = [Data.TmpC, MgATP, MgADP, Pi, freq(i), kstiff1, kstiff2, k_passive, SL0/2, L0, Kse];

  init = [zeros(1,10),SL0,0.2]; % Initial conditions for the model
  init(10) = 1;% setting the initial value for nonpermissible state equal to 1
  % Solving the system of diffrential equations
  
% run the simulation for one cycle to reach to the steady state
    options = odeset('RelTol',1e-3,'AbsTol',1e-6,'MaxStep',1000e-1);

    [~,ys] = ode15s(@Model_XB_Ca_activation,0:1:stim_f*3,init,options,para,Ca ,T);
    init = ys(end,:);
    [t, Y] = ode15s(@Model_XB_Ca_activation,tspan,init,options,para,Ca ,T);
  

   SL = Y(:,11);
   figure(4)
   hold on
   plot(t,SL)

Fse = Kse*( SL0/2 - SL/2);
% Following saves the data for each simulation for ploting
if i == 1 
            xlswrite('simfreq.xlsx',[t Fse],1,'A1')
elseif i == 2
            xlswrite('simfreq.xlsx',[t Fse],1,'C1')
elseif i == 3
            xlswrite('simfreq.xlsx',[t Fse],1,'E1')
elseif i == 4
            xlswrite('simfreq.xlsx',[t Fse],1,'G1')
elseif i == 5
            xlswrite('simfreq.xlsx',[t Fse],1,'I1')
elseif i == 6
            xlswrite('simfreq.xlsx',[t Fse],1,'K1')
elseif i == 7
            xlswrite('simlength.xlsx',[t Fse],1,'A1')
elseif i == 8
            xlswrite('simlength.xlsx',[t Fse],1,'C1')
end
    
clear Ca T

end

  
figurePlot

