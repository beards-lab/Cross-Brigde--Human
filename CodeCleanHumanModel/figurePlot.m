% clear all
% close all
% clc

data = xlsread('Human twtiches frequencies.xlsx','Sheet1','A2:S902');
dataSim = xlsread('simfreq.xlsx');
%% Normal frequency dependency
figure(1); clf; 
 
axes('position',[0.10,0.40,0.25,0.25]); box on; hold on;
plot(data(:,1),data(:,2),'r-','linewidth',3);
% plot(data(:,1),data(:,2),'r-','linewidth',3,'color',0.5*[1 1 1]);

plot(dataSim(:,1),dataSim(:,2),'k-','linewidth',1.5);
set(gca,'Fontsize',6,'xtick',0:200:600,'xticklabel',[]);
ylabel('Stress (mN/mm$^2$)','interpreter','latex','fontsize',8);
text(400,35,'0.5 Hz','interpreter','latex','fontsize',8);
axis([0 700 0 40]);

axes('position',[0.40,0.40,0.25,0.25]); box on; hold on;
plot(data(:,1),data(:,3),'r-','linewidth',3);
plot(dataSim(:,3),dataSim(:,4),'k-','linewidth',1.5);
set(gca,'Fontsize',6,'xtick',0:200:600,'xticklabel',[],'yticklabel',[]);
text(400,35,'1.0 Hz','interpreter','latex','fontsize',8);
axis([0 700 0 40]);

axes('position',[0.70,0.40,0.25,0.25]); box on; hold on;
plot(data(:,1),data(:,4),'r-','linewidth',3);
plot(dataSim(:,5),dataSim(:,6),'k-','linewidth',1.5);
set(gca,'Fontsize',6,'xtick',0:200:600,'xticklabel',[],'yticklabel',[]);
text(400,35,'1.5 Hz','interpreter','latex','fontsize',8);
axis([0 700 0 40]);

axes('position',[0.10,0.10,0.25,0.25]); box on; hold on;
plot(data(:,1),data(:,5),'r-','linewidth',3);
plot(dataSim(:,7),dataSim(:,8),'k-','linewidth',1.5);
set(gca,'Fontsize',6,'xtick',0:200:600);
ylabel('Stress (mN/mm$^2$)','interpreter','latex','fontsize',8);
xlabel('time (ms)','interpreter','latex','fontsize',8);
text(400,35,'2.0 Hz','interpreter','latex','fontsize',8);
axis([0 700 0 40]);

axes('position',[0.40,0.10,0.25,0.25]); box on; hold on;
plot(data(:,1),data(:,6),'r-','linewidth',3);
plot(dataSim(:,9),dataSim(:,10),'k-','linewidth',1.5);
set(gca,'Fontsize',6,'xtick',0:200:600,'yticklabel',[]);
xlabel('time (ms)','interpreter','latex','fontsize',8);
text(400,35,'2.5 Hz','interpreter','latex','fontsize',8);
axis([0 700 0 40]);

axes('position',[0.70,0.10,0.25,0.25]); box on; hold on;
plot(data(:,1),data(:,7),'r-','linewidth',3);
plot(dataSim(:,11),dataSim(:,12),'k-','linewidth',1.5);
set(gca,'Fontsize',6,'xtick',0:200:600,'yticklabel',[]);
xlabel('time (ms)','interpreter','latex','fontsize',8);
text(400,35,'3.0 Hz','interpreter','latex','fontsize',8);
axis([0 700 0 40]);

%% Normal length dependency

figure(2); clf; 
 
axes('position',[0.10,0.40,0.25,0.25]); box on; hold on;
plot(data(:,1),data(:,2),'r-','linewidth',3);
plot(dataSim(:,1),dataSim(:,2),'k-','linewidth',1.5);
set(gca,'Fontsize',6,'xtick',0:200:600);
xlabel('time (ms)','interpreter','latex','fontsize',8);
ylabel('Stress (mN/mm$^2$)','interpreter','latex','fontsize',8);
text(350,22,'2.20 $\mu$m','interpreter','latex','fontsize',8);
axis([0 600 0 25]);

data = xlsread('Human Twitches different Lenghts.xlsx','Sheet1','A2:M744');
dataSim = xlsread('simlength.xlsx');

axes('position',[0.40,0.40,0.25,0.25]); box on; hold on;
plot(data(:,1),data(:,4),'r-','linewidth',3);
plot(dataSim(:,3),dataSim(:,4),'k-','linewidth',1.5);
set(gca,'Fontsize',6,'xtick',0:200:600,'yticklabel',[]);
xlabel('time (ms)','interpreter','latex','fontsize',8);
text(350,22,'2.09 $\mu$m','interpreter','latex','fontsize',8);
axis([0 600 0 25]);

axes('position',[0.70,0.40,0.25,0.25]); box on; hold on;
plot(data(:,1),data(:,3),'r-','linewidth',3);
plot(dataSim(:,1),dataSim(:,2),'k-','linewidth',1.5);
set(gca,'Fontsize',6,'xtick',0:200:600,'yticklabel',[]);
xlabel('time (ms)','interpreter','latex','fontsize',8);
text(350,22,'1.98 $\mu$m','interpreter','latex','fontsize',8);
axis([0 600 0 25]);


