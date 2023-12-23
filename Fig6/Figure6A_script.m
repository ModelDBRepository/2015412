% The script was written by Natalia Maksymchuk for the article 
% Maksymchuk N, Sakurai A, Cox DN, Cymbalyuk GS. 
% Cold-Temperature Coding with Bursting and Spiking 
% Based on TRP Channel Dynamics in Drosophila Larva Sensory Neurons. 
% International Journal of Molecular Sciences. 2023; 24(19):14638. 
% https://doi.org/10.3390/ijms241914638
% Experimental temperature protocol


close all
clear all

ExpTetmpDataLoad
TimeS1=Tempdata(:,1);   
TempS1=Tempdata(:,2);
T0=TempS1(1);
tint=TimeS1(end);
tonset=9.5; 

 
FileName='Fig6A';
GleakTest=2.;
A = 0.5;
N=5;
w = 0.;
Th = 273.15+10.;
Cain_half = 500;
tau_hLT=5;
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
 yy0=1.0e+02*[
  -0.654781615710308
   0.000000061837658
   0.009969223748375
   0.000004807235437
   0.002245627209697
   0.000014494772440
   0.006317767782304
   0.571287611306699
   0.000075200175518
   0.007696363199294
   0.0000001
];

timeStart0=0.;
timeEnd0=100.;

options=odeset('AbsTol',1.e-9,'relTol',1.e-8,'BDF','on',...
'InitialStep',0.00001,'MaxStep',0.01); 
Pol=0.0;

 tic;  
    tspan=[timeStart0 timeEnd0];
    [t0,ymp0]=ode15s(@dy0,tspan,yy0,options,tauNaF,GNaF,GK,GL,...
    ENa,EK,EL,vmNaF,vhNaF,vmK,KmNaF,KhNaF,...
    KmK,Cap,Vol,GBK,CaBK,KmBK,kmBK,VmBK,vmBK,tmBK,nBK,nSK,GSK,tau_aSK,...
   Z, K05, R, F,k,Camin, Caout,GleakTest,kPCa,kPNa,kPK,GCa,vmCa,KmCa,...
    vhCa, KhCa, tmCa, thCa,A,N,w,Th,Cain_half,tau_hLT,T0,tau_mLT);
 toc

 yy1=ymp0(end,:);  

tic          
    tspan=0:0.0001:tint;
    [t1,ymp1]=ode15s(@dy1,tspan,yy1,options,tauNaF,GNaF,GK,GL,...
    ENa,EK,EL,vmNaF,vhNaF,vmK,KmNaF,KhNaF,...
    KmK,Cap,Vol,GBK,CaBK,KmBK,kmBK,VmBK,vmBK,tmBK,nBK,nSK,GSK,tau_aSK,...
   Z, K05, R, F,k,Camin, Caout,GleakTest,kPCa,kPNa,kPK,GCa,vmCa,KmCa,...
    vhCa, KhCa, tmCa, thCa,A,N,w,Th,Cain_half,tau_hLT,TimeS1,TempS1,tau_mLT);
toc

ttoc=toc
fprintf('t=%7.3f min\n',ttoc/60.); % How much time it takes in minutes 


% Saving trajectory    
savefile = [FileName '.mat']; 
            save(savefile,'t1','ymp1','TimeS1','TempS1','GleakTest',...
                'kPCa','kPNa','kPK','w','A','Th','N','Cain_half','tau_mLT',...
                'tau_hLT','Caout','ENa','EK','thresh','tonset','Cap','KhCa', 'GL','KhCa');
Fig6A_graphs            
