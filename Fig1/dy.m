% The script was written by Natalia Maksymchuk for the article 
% Maksymchuk N, Sakurai A, Cox DN, Cymbalyuk GS. 
% Cold-Temperature Coding with Bursting and Spiking 
% Based on TRP Channel Dynamics in Drosophila Larva Sensory Neurons. 
% International Journal of Molecular Sciences. 2023; 24(19):14638. 
% https://doi.org/10.3390/ijms241914638

function dy=dy(t,y,tauNaF,GNaF,GK,GL,...
    ENa,EK,EL,vmNaF,vhNaF,vmK,KmNaF,KhNaF,...
    KmK,Pol,Cap,Vol,GBK,CaBK,KmBK,kmBK,VmBK,vmBK,tmBK,nBK,nSK,GSK,tau_aSK,...
   Z, K05, R, F,k,Camin, Caout,GleakTest,T,kPCa,kPNa,kPK,GCa,vmCa,KmCa,...
    vhCa, KhCa, tmCa, thCa)


%        y(1)=V,
%        y(2)=mNaF, 
%        y(3)=hNaF,
%        y(4)=mK,
%        y(5)=mBK,
%        y(6)=mCa;
%        y(7)=hCa;
%        y(8)=Cain;
%        y(9)=mSK

% SK current is gated by a dynamic gating variable

%% Temperature-dependend scaling factors
ro=1.3^((T-273.15-25.)/10.);
fi=3.0^((T-273.15-25.)/10.);

ECa = 1000.*R*T/(Z*F)*log(Caout/y(8));
I_Ca=ro*GCa*y(6)*y(7)*(y(1)-ECa);
fCaBK=1/(1+(CaBK/y(8))^nBK); 
I_BK=ro*GBK*fCaBK*y(5)*y(5)*y(5)*y(5)*(y(1)-EK);
mSKinf=1/((K05/y(8))^nSK+1);
I_SK=ro*GSK*y(9)*(y(1)-EK); 
I_NaF=ro*GNaF*y(2)*y(2)*y(2)*y(3)*(y(1)-ENa); 
I_K=ro*GK*y(4)*y(4)*y(4)*y(4)*(y(1)-EK);
Ca_LT=kPCa*(y(1)-ECa);
Na_LT=kPNa*(y(1)-ENa);
K_LT=kPK*(y(1)-EK);
I_Test=GleakTest*(Ca_LT+Na_LT+K_LT);
ILTestCa=GleakTest*(Ca_LT);
I_L=ro*GL*(y(1)-EL);

mBKinf=1/(1+exp(-(y(1)+vmBK)/kmBK));
t_mBK=-0.1502/(1+exp(-(y(1)+VmBK)/KmBK))+tmBK;


%%
dy(1,1)=-(I_NaF+I_K+I_BK+I_SK+I_L+I_Test+I_Ca-Pol)/Cap;

%mNaF
dy(2,1)=fi*(minfHB5(KmNaF,vmNaF,y(1))-y(2))/tauNaF;

%hNaF
a1=4.5;
tau_hNa=(a1./cosh((y(1) + vhNaF)./(3.*KhNaF))+0.75)/1000.;% fitted from experimental data Wang 2013
dy(3,1)=fi*(hinfHB5(KhNaF,vhNaF,y(1))-y(3))/tau_hNa;

%mK
a1 = 5.;
b1 = 2.;  
taumKFit = (a1./cosh((y(1) + vmK)./(b1*KmK))+0.75)/1000;
dy(4,1)=fi*(minfHB5(KmK,vmK,y(1))-y(4))/taumKFit;
 
%mBK
dy(5,1)=fi*(mBKinf-y(5))./t_mBK;

%mCa
dy(6,1)=fi*(minfHB5(KmCa,vmCa,y(1))-y(6))/tmCa;

%hCa
dy(7,1)=fi*(hinfHB5(KhCa,vhCa,y(1))-y(7))/thCa;

%Cain
dy(8,1)=-(ILTestCa+I_Ca)/(F*Z*Vol)-k*(y(8)-Camin);

%mSK 
dy(9,1)=fi*(mSKinf-y(9))/tau_aSK;
  
  
 
 

