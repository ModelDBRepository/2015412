% The script was written by Natalia Maksymchuk for the article 
% Maksymchuk N, Sakurai A, Cox DN, Cymbalyuk GS. 
% Cold-Temperature Coding with Bursting and Spiking 
% Based on TRP Channel Dynamics in Drosophila Larva Sensory Neurons. 
% International Journal of Molecular Sciences. 2023; 24(19):14638. 
% https://doi.org/10.3390/ijms241914638

% Trapezoid temperature protocol

close all
clear all


kramp=2.;%temperature ramp 2deg/s
T0=273.15+24.;
T1=273.15+10.;

GleakTest=1.2;
A = 1;
N=2;
w = 0.;
Th = 273.15+17.;
Cain_half = 700.;
tau_hLT=10.;
tau_mLT=0.002; 


ECa=120.;
EK=-75;
ENa=65;

PCa=0.4;
PK=1.;
PNa=-(PK*EK+PCa*ECa)/ENa;

kPCa=PCa/(PCa+PNa+PK);
kPNa=PNa/(PCa+PNa+PK);
kPK=PK/(PCa+PNa+PK);

thresh=-20.;
  
Vol = 0.2; 
Cap=0.01;
Camin=50.; 

Z = 2.; 
k = 403.;
R = 8.31e-9;
F = 96485.35e-9; 
Caout = 2.e6; 
 

nSK=3;
GSK=0.31;
tau_aSK=0.04;
K05=800.;


nBK=3;
GBK=6.;
vmBK=28.3;
  VmBK=46.;
kmBK=30.;
  KmBK=22.7;
tmBK=0.1806;
CaBK=1700.;
Caeq=90.;


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

GL =0.25;
EL=-75.;


%% initial cond
 yy0=1.0e+03*[-0.037713747848844
   0.000021540813571
   0.000233895036414
   0.000028498368377
   0.000453644663935
   0.000114722897030
   0.000206824821028
   1.072076054899095
   0.000771923110066
   0.000436871562925
   0.00001];
   
Ncycle=0;
         
         timeInt2=(T0-T1)/kramp;
                     Ncycle=Ncycle+1
                     
timeInt1=30.; 
timeInt3=30.;
timeInt4=timeInt2;
timeInt5=30;
timeStart1=0.;
timeEnd1=timeStart1+timeInt1;
timeStart2=timeEnd1;
timeEnd2=timeStart2+timeInt2;
timeStart3=timeEnd2;
timeEnd3=timeStart3+timeInt3;
timeStart4=timeEnd3;
timeEnd4=timeStart4+timeInt4;
timeStart5=timeEnd4;
timeEnd5=timeStart5+timeInt5;
%% integration 1
kk=0.;
bb=T0;

options=odeset('AbsTol',1.e-9,'relTol',1.e-8,'BDF','on',...
'InitialStep',0.00001,'MaxStep',0.01); 
Pol=0.0;
TT=T0;
 tic;  
    tspan=[timeStart1 timeEnd1];
    [t0,ymp0]=ode15s(@dyTrap,tspan,yy0,options,tauNaF,GNaF,GK,GL,...
    ENa,EK,EL,vmNaF,vhNaF,vmK,KmNaF,KhNaF,...
    KmK,Cap,Vol,GBK,CaBK,KmBK,kmBK,VmBK,vmBK,tmBK,nBK,nSK,GSK,tau_aSK,...
   Z, K05, R, F,k,Camin, Caout,GleakTest,kPCa,kPNa,kPK,GCa,vmCa,KmCa,...
    vhCa, KhCa, tmCa, thCa,A,N,w,Th,Cain_half,tau_hLT,tau_mLT,kk,bb);
 toc

  
%% integration 2 
kk=-kramp;
bb=T0+kramp*timeStart2;
yy1=ymp0(end,:);


tic          
    tspan=timeStart2:0.0001:timeEnd2;
    [t1,ymp1]=ode15s(@dyTrap,tspan,yy1,options,tauNaF,GNaF,GK,GL,...
    ENa,EK,EL,vmNaF,vhNaF,vmK,KmNaF,KhNaF,...
    KmK,Cap,Vol,GBK,CaBK,KmBK,kmBK,VmBK,vmBK,tmBK,nBK,nSK,GSK,tau_aSK,...
   Z, K05, R, F,k,Camin, Caout,GleakTest,kPCa,kPNa,kPK,GCa,vmCa,KmCa,...
    vhCa, KhCa, tmCa, thCa,A,N,w,Th,Cain_half,tau_hLT,tau_mLT,kk,bb);


%% integration 3
kk=0;
bb=T1;
yy2=ymp1(end,:);

          
    tspan=[timeStart3 timeEnd3];
    [t2,ymp2]=ode15s(@dyTrap,tspan,yy2,options,tauNaF,GNaF,GK,GL,...
    ENa,EK,EL,vmNaF,vhNaF,vmK,KmNaF,KhNaF,...
    KmK,Cap,Vol,GBK,CaBK,KmBK,kmBK,VmBK,vmBK,tmBK,nBK,nSK,GSK,tau_aSK,...
   Z, K05, R, F,k,Camin, Caout,GleakTest,kPCa,kPNa,kPK,GCa,vmCa,KmCa,...
    vhCa, KhCa, tmCa, thCa,A,N,w,Th,Cain_half,tau_hLT,tau_mLT,kk,bb);


%% integration 4
kk=kramp;
bb=T1-kramp*timeStart4;
yy3=ymp2(end,:);

tspan=timeStart4:0.0001:timeEnd4;
    [t3,ymp3]=ode15s(@dyTrap,tspan,yy3,options,tauNaF,GNaF,GK,GL,...
    ENa,EK,EL,vmNaF,vhNaF,vmK,KmNaF,KhNaF,...
    KmK,Cap,Vol,GBK,CaBK,KmBK,kmBK,VmBK,vmBK,tmBK,nBK,nSK,GSK,tau_aSK,...
   Z, K05, R, F,k,Camin, Caout,GleakTest,kPCa,kPNa,kPK,GCa,vmCa,KmCa,...
    vhCa, KhCa, tmCa, thCa,A,N,w,Th,Cain_half,tau_hLT,tau_mLT,kk,bb);

%% integration 5
kk=0;
bb=T0;
yy4=ymp3(end,:);

tspan=[timeStart5 timeEnd5];
    [t4,ymp4]=ode15s(@dyTrap,tspan,yy4,options,tauNaF,GNaF,GK,GL,...
    ENa,EK,EL,vmNaF,vhNaF,vmK,KmNaF,KhNaF,...
    KmK,Cap,Vol,GBK,CaBK,KmBK,kmBK,VmBK,vmBK,tmBK,nBK,nSK,GSK,tau_aSK,...
   Z, K05, R, F,k,Camin, Caout,GleakTest,kPCa,kPNa,kPK,GCa,vmCa,KmCa,...
    vhCa, KhCa, tmCa, thCa,A,N,w,Th,Cain_half,tau_hLT,tau_mLT,kk,bb);

toc
ttoc=toc;
initial=ymp4(end,:);
fprintf('t=%7.3f min\n',ttoc/60.); % How much time it takes in minutes 

Graphs
