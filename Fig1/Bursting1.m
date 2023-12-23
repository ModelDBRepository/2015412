% The script was written by Natalia Maksymchuk for the article 
% Maksymchuk N, Sakurai A, Cox DN, Cymbalyuk GS. 
% Cold-Temperature Coding with Bursting and Spiking 
% Based on TRP Channel Dynamics in Drosophila Larva Sensory Neurons. 
% International Journal of Molecular Sciences. 2023; 24(19):14638. 
% https://doi.org/10.3390/ijms241914638

close all
clear all

TT=9;%Temperature in oC
GleakTest=0.1;% GLTRP
T=273.15+TT; %Temperature in K

%Bursting1
j=6.;%GLTest 
i=31.;%Temperature
IC=load(['IC_GleakTest' num2str(j) 'T' num2str(i) '.dat']);

ECa=120.;%
EK=-75;%
ENa=65;

PCa=0.4;
PK=1.;
PNa=-(PK*EK+PCa*ECa)/ENa;

kPCa=PCa/(PCa+PNa+PK);
kPNa=PNa/(PCa+PNa+PK);
kPK=PK/(PCa+PNa+PK);

GL = 0.25;
EL=-75.;

nSK=3;
GSK=0.31;
tau_aSK=0.04;
K05=800.;

Cap=0.01;
k = 403.;
Camin=50.; 

nBK=3.;
GBK=6.;
vmBK=28.3;
  VmBK=46.;
kmBK=30.;
  KmBK=22.7;
tmBK=0.1806;
CaBK=1700.;
Caeq=90.;

GNaP=0.;

GNaF=80.;
tauNaF=0.0001;
vmNaF = 24.7;
vhNaF=41.2;
KmNaF =3.4;
KhNaF=4.2;

GK=140;
vmK=12.;
KmK =7.;
tauK=0.0025;

GCa=3.5;
vmCa=23.;
KmCa=6.5;
vhCa=59.;
KhCa=12.;
tmCa=0.0035; 
thCa=0.095;

Vol = 0.2; 
Cap=0.01;
Camin=50.; 

Z = 2.; 
k = 403.;
R = 8.31e-9;
F = 96485.35e-9; 
Caout = 2.e6; 


yy0=IC'; % initial conditions

tint=100.;
timeStart=0.;
timeEnd=60.;

options=odeset('AbsTol',1.e-9,'relTol',1.e-8,'BDF','on',...
'InitialStep',0.00001,'MaxStep',0.01); 
Pol=0.0;

tic;  
    tspan=timeStart:0.001:timeEnd;
    [tt,ympp]=ode15s(@dy,tspan,yy0,options,tauNaF,GNaF,GK,GL,...
    ENa,EK,EL,vmNaF,vhNaF,vmK,KmNaF,KhNaF,...
    KmK,Pol,Cap,Vol,GBK,CaBK,KmBK,kmBK,VmBK,vmBK,tmBK,nBK,nSK,GSK,tau_aSK,...
    Z, K05, R, F,k,Camin,Caout,GleakTest,T,kPCa,kPNa,kPK,GCa,vmCa,KmCa,...
    vhCa, KhCa, tmCa, thCa);
toc

yy1=ympp(end,:); 

tic
          
    tspan=0:0.0001:tint;
    [t1,ymp1]=ode15s(@dy,tspan,yy1,options,tauNaF,GNaF,GK,GL,...
    ENa,EK,EL,vmNaF,vhNaF,vmK,KmNaF,KhNaF,...
    KmK,Pol,Cap,Vol,GBK,CaBK,KmBK,kmBK,VmBK,vmBK,tmBK,nBK,nSK,GSK,tau_aSK,...
    Z, K05, R, F,k,Camin,Caout,GleakTest,T,kPCa,kPNa,kPK,GCa,vmCa,KmCa,...
    vhCa, KhCa, tmCa, thCa);
toc

ttoc=toc
fprintf('t=%7.3f min\n',ttoc/60.); % display time in minutes 
       
    
t=t1;
V=ymp1(:,1);
TK = T;
Cai=ymp1(:,8);
CaMean=mean(Cai);

colorWT=[0./255. 127./255. 255./255.];
colorTem=[255./255. 0./255. 43./255.];
FontSz=16.;
FontName='Arial';
    
figure; 
hp2=plot(t-1.2,V); % 3 spikes
set(hp2, 'color', colorWT, 'linewidth', 1.5);
box off
ylim([-60. 60.]);% 
xlim([0. 0.8]);
ylabel('V (mV)')
xlabel('Time (s)')
set(gca,'linewidth', 2, 'FontWeight','bold','fontsize',FontSz);
title(['T= ' num2str(T-273.15) ' {}^oC' ', ' 'GLTRP=' num2str(GleakTest) ' nS'])




