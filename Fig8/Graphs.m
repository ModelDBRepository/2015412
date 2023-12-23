% The script was written by Natalia Maksymchuk for the article 
% Maksymchuk N, Sakurai A, Cox DN, Cymbalyuk GS. 
% Cold-Temperature Coding with Bursting and Spiking 
% Based on TRP Channel Dynamics in Drosophila Larva Sensory Neurons. 
% International Journal of Molecular Sciences. 2023; 24(19):14638. 
% https://doi.org/10.3390/ijms241914638

FileName=['Rate_' num2str(kramp)]; 
BinSize=1.;%2;

FRlim=30.;
IFlim=80;
Vmin=-80;
Vmax=40;
 xstart=-10;
 xlimit=60.;%


colorTem=[255./255. 0./255. 43./255.];
FontSz=16.;
%% El activity
 
t=[t0; t1; t2; t3; t4];
V=[ymp0(:,1);ymp1(:,1);ymp2(:,1);ymp3(:,1);ymp4(:,1)];
Cai=[ymp0(:,8);ymp1(:,8);ymp2(:,8);ymp3(:,8);ymp4(:,8)];
mTRP=[ymp0(:,11);ymp1(:,11);ymp2(:,11);ymp3(:,11);ymp4(:,11)];
hTRP=[ymp0(:,10);ymp1(:,10);ymp2(:,10);ymp3(:,10);ymp4(:,10)];
G_TRP=mTRP.*hTRP*GleakTest; 

 k2=-kramp;
 b2=T0+kramp*timeStart2;
 TT2=k2*t1+b2;

 k4=kramp;
 b4=T1-kramp*timeStart4;
 TT4=k4*t3+b4;
 
for j=1:length(t0)
     Temperature1(j)=T0-273.15;
end 
for jj=1:length(t1)
     Temperature2(jj)=(k2*t1(jj)+b2)-273.15;
end
for jjj=1:length(t2)
     Temperature3(jjj)=T1-273.15;
end 
for jjjj=1:length(t3)
     Temperature4(jjjj)=(k4*t3(jjjj)+b4)-273.15;
end
for jjjjj=1:length(t4)
     Temperature5(jjjjj)=T0-273.15;
end 
 TemperatureC=[Temperature1 Temperature2 Temperature3 Temperature4 Temperature5];
 TK=TemperatureC+273.15;   
    
      
            
%% ***** FR *****
RampName=['dT/dt=' num2str(kramp) ' deg/s'];
spikeNN=FunkNNmax(t, V, thresh);
spikeTime=t(spikeNN);
    if spikeNN>0
    spikeTime=t(spikeNN);
    ISI=t(spikeNN(2:end))-t(spikeNN(1:end-1));    
    Frequency=1./ISI;
    MF=mean(Frequency);
    else
        MF=0;
    end 


NBin=floor(t(end)/BinSize);

                    for j=1:NBin
                        ttt(j)=(j-1)*BinSize;
                        FRbin(j)=length((find(spikeTime>(j-1)*BinSize&spikeTime<=j*BinSize)))/BinSize;                         
                    end
                    
                    figure; plot(G_TRP(spikeNN(2:end)),Frequency)
                    hold on
                    xlim([0,1]);ylim([0,IFlim]);
                    plot(G_TRP(spikeNN(2:end)),Frequency, 'ko', 'LineWidth',1.5,'MarkerEdgeColor','r','MarkerSize',5)
                    xlabel('G_{TRP} (nS)')
                    ylabel('IF (Hz)')
                    set(gca,'Ycolor',[0 0 0],'linewidth', 2, 'FontWeight','bold','fontsize',16,'FontName', 'Aparajita')
                    set(gca,'box','off')
tonset=t0(end);
                      
            
figure
 plot(t-tonset,V,'color',[0./255. 90./255. 255./255.],'linewidth',0.01)
 set(gca,'Ycolor',[0 0 0],'linewidth', 0.5, 'FontWeight','bold','fontsize',16)
 set(gca,'box','off')
 xlim([2 6]);
 ylim([Vmin Vmax]);
 ylabel('V_m (mV)');
 xlabel('Time (s)');
 
            
  
  
                figure1=figure('Position', [0, 0, 800, 800]);
                subplot(2,1,1)
                plot(t-tonset,V,'color',[0./255. 90./255. 255./255.],'linewidth',0.01)
                set(gca,'Ycolor',[0 0 0],'linewidth', 0.5, 'FontWeight','bold','fontsize',16)
                set(gca,'box','off')
                xlim([xstart xlimit]);
                ylim([Vmin Vmax]);
                set(gca,'xticklabel',[])
                ylabel('V_m (mV)');
                title(RampName)              
                
                            subplot(2,1,2)
                            plot(t-tonset,TemperatureC,'color',[0 0 0],'linewidth',3.);
                            set(gca,'Ycolor',[0 0 0],'linewidth', 1, 'FontWeight','bold','fontsize',16,'FontName', 'Aparajita')
                            set(gca,'box','off')
                            %set(gca,'xticklabel',[])
                            ylim([8 25]);
                            xlim([xstart xlimit]);
                            ylabel('T ({}^oC)');
                            xlabel('Time (s)');
                             

                         
         


%% this will be used for heatmaps
[~, ind] = unique(t); % ind = index of first occurrence of a repeated value 
G_LTestInt=interp1(t(ind),G_TRP(ind),spikeTime);   
TCint=interp1(t(ind),TemperatureC(ind),spikeTime);% Interpolation of Temperature(t) 

 

HeatMaps


