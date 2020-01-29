function [ dYdT, dSL, F_XB, F_passive ] = Model_XB_Ca_activation( t,y,para,Ca,T )

TmpC = para(1);
MgATP = para(2);
Pi = para(4);
MgADP = para(3);
Freq = para (5);
kstiff1 = para (6);
kstiff2 = para (7);
k_passive = para (8);
SLset = para (9);
L0 = para(10);% micron
Kse = para(11);
% fiting the calcium data file
stim_f = 1e3/Freq;
% using Spline for the Ca at each time point
Ca_i = spline(T'/max(T),Ca',mod(t,stim_f)/stim_f)*1e3;

%% Constants and parameters for the cross bridge model

% All the parameters here are from table 1 of  Tewari et al, 2015(Dynamic cross bridge...) 
% for the rat

alpha1 = 11.6512;  % unit (1/um)
alpha2 =  9.5185;% unit (1/um)
alpha3 = 58.1470; % unit (1/um)

s3 = 0.0112; % unit (um)
K_Pi = 4.00 ; % unit (mM) K_Pi [Pi] dissociation constant in the paper 
K_T = 0.4897;  % unit (mM) %K_MgATP [MgATP] dissociation constant in the paper 
K_D = 0.194 ; % unit (mM) MgADP dissociation constant from Yamashita etal (Circ Res. 1994; 74:1027-33).

% Defining the metabolite dependent coeficient, rapid equilibrium of the
% cross bridge sub-states
g1 = (MgADP/K_D)/(1 + MgADP/K_D + MgATP/K_T);
g2 = (MgATP/K_T)/(1 + MgATP/K_T + MgADP/K_D);
f1 = (Pi/K_Pi)/(1 + Pi/K_Pi);
f2 = 1/(1 + Pi/K_Pi);

% Temperature dependence of parameters was determined by estimating Q10 values
% The following variables are calculated by multiplying the Q10s



ka = 106.8833;  % unit (1/s)
kd = 15.5282 * f1;% unit (1/s)
k1 = 4.5931 * f2;% % unit (1/s)
k_1 =  0.5139 ;% % unit (1/s)
k2 =  1.2905;  % unit (1/s)
k_2 = 0.0105 * g1; % unit (1/s)
k3 =  15.7942 * g2; % % unit (1/s)


 
%% State Variables,
% Moment of state variables
p1_0 = y(1);
p1_1 = y(2);
p1_2 = y(3);
p2_0 = y(4);
p2_1 = y(5);
p2_2 = y(6);
p3_0 = y(7);
p3_1 = y(8);
p3_2 = y(9);
% N represents the Non permissible state in cross bridge model
N = y(10);
% P represents the permssible state in cross bridge model
P = 1 - N - p1_0 - p2_0 - p3_0;
% sarcomere length
SL = y(11);
% U_NR represents the Non relaxed state
U_NR = y(12);
% U_SR is the super relaxed state
U_SR = 1 - U_NR;
% % Limit Maximum Strain for Numerical Accuracy: See JMCC article for details
p1_1 = max(-0.02,p1_1);
p2_1 = max(-0.02,p2_1);
p3_1 = max(-0.02,p3_1);
%% Stretch-sensitive rates
f_alpha1o = (p1_0 - alpha1 * p1_1 + 0.5 *  alpha1^2 * p1_2);
f_alpha1i = (p1_1 - alpha1 * p1_2);
alpha0 = 1 * alpha1;

f_alpha0o = (p2_0 + alpha0 * p2_1 + 0.5 * alpha0^2 * p2_2);
f_alpha0i = (p2_1 + alpha0 * p2_2);
f_alpha2o = (p2_0 - alpha2 * p2_1 + 0.5 * alpha2^2 * p2_2);
f_alpha2i = (p2_1 - alpha2 * p2_2);

% alpha2b = 0;
f_alphao = (p3_0 + alpha2 * p3_1 + 0.5 * alpha2^2 * p3_2);
f_alphai = (p3_1 + alpha2 * p3_2);

f_alpha3o = (p3_0 + alpha3 *( s3^2 * p3_0 + 2 * s3 * p3_1 )+ p3_2);
f_alpha3i = (p3_1 + alpha3 *( s3^2 * p3_1 + 2 * s3 * p3_2 ));

%% Overlap function (Tewari et al.)
Lthin = 1200; % nm
Lthick = 1670; % nm
Lbare = 100; % nm Thick filament bare zone
OV_Zaxis = min(Lthick/2,1000*SL/2);
OV_Mline = max(1000*SL/2-(1000*SL-Lthin),Lbare/2);
LOV = OV_Zaxis - OV_Mline;
% Overlap fraction for thick filament
N_overlap = LOV*2/(Lthick - Lbare);

%% Compute Active & Passive Force

% Active Force
dr = 0.01; % Power-stroke Size; Units: um
B_process = kstiff2 * dr * p3_0;   % Force due to XB ratcheting
C_process = kstiff1 * ( p2_1 + p3_1 );% Force due to stretching of XBs
F_XB = N_overlap * ( B_process + C_process ); % Active Force

% (linear) passive force model

% k_passive = 28.7; % mN / mm^2 / micron

F_passive = k_passive*(SL/2-L0);
visc = 1; % kPa*msec*micrometer^-1

Ftotal = F_XB + F_passive;%

intf = (- Ftotal +  Kse*( SLset - SL/2 ));
% pause
% Get XB ODEs
dSL = intf/visc;
%  dSL = 0;

% This equation modified so that only the fraction in the P and NR state
% can transition to crossbridge bound.

dp1_0 = ka * P * U_NR * N_overlap - kd*p1_0 - k1*f_alpha1o + k_1*f_alpha0o;
dp1_1 = 1*dSL*p1_0 - kd*p1_1 - k1*f_alpha1i + k_1*f_alpha0i;
dp1_2 = 2*dSL*p1_1 - kd*p1_2 - k1*p1_2 + k_1*p2_2;
dp2_0 =         - k_1*f_alpha0o - k2*f_alpha2o + k_2*f_alphao + k1*f_alpha1o;
dp2_1 = 1*dSL*p2_0 - k_1*f_alpha0i - k2*f_alpha2i + k_2*f_alphai + k1*f_alpha1i;
dp2_2 = 2*dSL*p2_1 - k_1*p2_2       - k2*p2_2 + k_2*p3_2 + k1*p1_2;
dp3_0 =         + k2*f_alpha2o - k_2*f_alphao - k3*f_alpha3o;
dp3_1 = 1*dSL*p3_0 + k2*f_alpha2i - k_2*f_alphai - k3*f_alpha3i;
dp3_2 = 2*dSL*p3_1 + k2*p2_2       - k_2*p3_2 - k3*p3_2;

 
% Overlap fraction for thin filament
%  N_overlap = LOV/Lthin; 
%% Adding Campbell Ca activatin model (Campbell et al, Biophysical Journal 2018,)
N_on = 1 - N; % N_on represents all the bound and permissible states (fraction calcium bound)

K_coop = 4.8302;  %  
% k_coop is a made up number
k_on_Ca = 0.0088; % Campbell et al, Biophysical Journal 2018,
k_off_Ca = 0.1671; % manually tuned parameter!

% Calculating the forward and backward flux for the transition between the
% permissible and the non permissible state (Ca activation).
% (These transition rates DO NOT depend on SR versus NR state.)

Jon = k_on_Ca * Ca_i* N * (1 + K_coop * N_on);
Joff = k_off_Ca* P *(1 + K_coop * N);
dNp = - Jon + Joff;   
 
%% transitions between super relaxed state and non relaxed state

kforce = 1.1552;
k1_SR = 12.4817;
k2_SR = 14.7933; % made-up number
F0 = 10.94;

dU_NR = k1_SR*( 1 + kforce* Ftotal./(Ftotal + F0) ) * U_SR - k2_SR * U_NR;

 
dYdT = [dp1_0; dp1_1; dp1_2; dp2_0; dp2_1; dp2_2; dp3_0; dp3_1; dp3_2; dNp; dSL; dU_NR];

end
