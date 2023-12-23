% The script was written by Natalia Maksymchuk for the article 
% Maksymchuk N, Sakurai A, Cox DN, Cymbalyuk GS. 
% Cold-Temperature Coding with Bursting and Spiking 
% Based on TRP Channel Dynamics in Drosophila Larva Sensory Neurons. 
% International Journal of Molecular Sciences. 2023; 24(19):14638. 
% https://doi.org/10.3390/ijms241914638

clear all
close all

FileName='Fig6B';

xlimit=70;
FRlim=21.5;
Calim=4000.;
IFlim=95.;

xstart=-10.;
load(FileName); 

R = 8.3100e-09;
Z=2;
F=9.6485e-05;
GCa=3.5;
      
%% ***************** GRAPHS ****************************
colorWT=[0./255. 127./255. 255./255.];
colorTem=[255./255. 0./255. 43./255.];
FontSz=16.;

t=t1;
V=ymp1(:,1);


Cai=ymp1(:,8);
CaMean=mean(Cai);
Ca=ymp1(:,8);
m_Ca=ymp1(:,6);
h_Ca=ymp1(:,7);
h_GLTest=ymp1(:,10);%hTRP
mTRP=ymp1(:,11);
TK = interp1(TimeS1,TempS1+273.15,t1);% Temperature K which corresponds every voltage point
TC=TK-273.15; %Temperature oC which corresponds every voltage point
ro=1.3.^((TK-25.)/10.);


L=log(Caout./Ca);
ECa=1000.*R*TK/(Z*F).*L;
        Ca_LT=kPCa*(V-ECa);
        Na_LT=kPNa*(V-ENa);
        K_LT=kPK*(V-EK);
       
G_LTest=mTRP.*h_GLTest*GleakTest;        
I_Test=mTRP.*h_GLTest*GleakTest.*(Ca_LT+Na_LT+K_LT);
G_Ca=m_Ca.*h_Ca*GCa;


figure; 
hp2=plot(t-tonset,V);
set(hp2, 'color', colorWT, 'linewidth', 1)
xlim([1.9 4.9]);
ylim([-80, 50]);
ylabel('V_m, mV')
     

%********* %for finding instantaneous spike requency ***********************
    spikeNN=FunkNNmax(t,V,thresh);
    if spikeNN>0
    spikeTime=t(spikeNN);
    ISI=t(spikeNN(2:end))-t(spikeNN(1:end-1));    
    Frequency=1./ISI;
    MF=mean(Frequency);
    else
        MF=0;
    end  
    
     
%% Firing rate ***************
if spikeNN>0
tlim=t(end);        
                    
                   

%% Inst Frequency with GCa and GTRP (not completed)********************************************
            f = figure;
            f.Position = [100 100 550 500];%[left bottom width height]
            axes('Position',[0.13 0.72 .85 0.28],'Visible','off'); %% x1, y1, width, hight
                        plot(t-tonset,V,'color',colorWT,'linewidth',0.3);
                        xlim([xstart xlimit]);
                        axis off
                        set(gca,'Ycolor',[0 0 0],'linewidth', 1, 'FontWeight','bold','fontsize',15,'FontName', 'Aparajita')
                        set(gca,'box','off')
                        set(gca,'xticklabel',[])
                        ylabel('V_m (mV)');
            axes('Position',[0.13 0.47 .85 0.242],'Visible','off'); %% x1, y1, width, hight
            hp1=plot(t-tonset,TC, 'linewidth',2);
                set(hp1, 'color', [0 0 0], 'linewidth', 2)
                ylim([4. 25.]);
                xlim([xstart xlimit]);
            ylabel('Temp ({}^oC)')
            set(gca,'Box', 'off');
            set(gca,'LineWidth',2,'Color',[1 1 1]); 
            set(gca,'YColor',[0 0 0]','fontsize',16,'FontWeight','bold','FontName', 'Aparajita');%'FontWeight','bold' for poster
            set(gca,'XColor',[0 0 0]','fontsize',16,'FontWeight','bold','FontName', 'Aparajita');
            set(gca,'xticklabel',[])
            axes('Position',[0.13 0.14 .85 0.25],'Visible','off'); %% x1, y1, width, hight
                h=plot(spikeTime(2:end)-tonset, Frequency,'.','MarkerSize',16,'Color',colorWT);
                ylabel('Frequency (Hz)');
                xlabel('Time (s)')
                xlim([xstart xlimit]);
                set(gca,'box','off')
                set(gca,'LineWidth',2,'Color',[1 1 1]); %% zhirni chorni osi :)
                set(gca,'YColor',[0 0 0]','fontsize',16,'FontWeight','bold','FontName', 'Aparajita');
                set(gca,'XColor',[0 0 0]','fontsize',16,'FontWeight','bold','FontName', 'Aparajita');


else 
    disp('There is no spiking activity');   
end
 
%% this will be used for heatmaps
G_LTestInt=interp1(t,G_LTest,spikeTime);  
TCint=interp1(t,TC,spikeTime);% Interpolation of Temperature(t)


%% ISI histogram
f = figure;
f.Position = [100 100 540 250];%[left bottom width height]
            hh=histogram(ISI,'BinWidth',0.05, 'BinLimits', [0. 1.]);
            set(gca,'Ycolor',[0 0 0],'linewidth', 2, 'FontWeight','bold','fontsize',15,'FontName', 'Aparajita')
            set(hh,'FaceColor',colorWT);
            box off
            xlabel('ISI (s)');
            ylabel('Counts');
            
            
%% GTRP and CGa
f = figure;
f.Position = [100 100 540 250];%[left bottom width height] 
yyaxis left 
plot(t-tonset,G_Ca,'color',[193/250, 27/250, 215/250],'linewidth',2);
set(gca,'Ycolor',[193/250, 27/250, 215/250],'linewidth',2, 'FontWeight','bold','fontsize',15);
xlabel('Time (s)');
ylabel('GCa (nS)');
ylim([0 1]);
xlim([xstart xlimit]);
hold on
yyaxis right
h1=plot(t-tonset,G_LTest,'color',[0/225, 0/225, 0/225],'linewidth',2);
set(gca,'Ycolor',[0 0 0],'linewidth', 2, 'FontWeight','bold','fontsize',15);
ylabel('G_{TRP} (nS)');
ylim([0 1]);
xlim([xstart xlimit]);
box off

            
HeatMaps





    


