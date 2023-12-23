% The script was written by Natalia Maksymchuk for the article 
% Maksymchuk N, Sakurai A, Cox DN, Cymbalyuk GS. 
% Cold-Temperature Coding with Bursting and Spiking 
% Based on TRP Channel Dynamics in Drosophila Larva Sensory Neurons. 
% International Journal of Molecular Sciences. 2023; 24(19):14638. 
% https://doi.org/10.3390/ijms241914638

load('NN.mat');
load('Data.mat');

% Create labels for heat maps 
% Create text files for correspondance of GleakTest and Temperature to j and i 

% Temperature
[fidTemp,message]= fopen('T.txt', 'w');
for i=1:NC2 %T
    fprintf(fidTemp,'%f  ',i,Tv(i)); 
    fprintf(fidTemp,'\n');
    Tvalues(i) = {num2str(Tv(i))};
end
fclose(fidTemp);


% GLTRP
[fidGleakTest,message]= fopen('GleakTest.txt', 'w');
for j=1:NC1 %GleakTest
    fprintf(fidGleakTest,'%f  ',j,GLTestv(j));
    fprintf(fidGleakTest,'\n');
    GLTestValues(j) = {num2str(GLTestv(j))};
 end
fclose(fidGleakTest);


pp1range=GLTestv; %x values
pp2range=Tv; %y values
pp1='G_{LTRP} (nS)';
pp2='Temp ({}^oC)';
ptsize=72; % size of squares on stationary heat map
cirklesize=65.; % size of circles on GTRP trajectory

% Mean Frequency
HeatMapValues=MeanFreq;
titleString='MF (Hz)';
colorbarString='MF (Hz)';

 figure;
    for ii=1:length(pp2range)
      hm=scatter(pp1range,ones(1,length(pp1range))*pp2range(ii),ptsize,HeatMapValues(ii,:),'s','filled',...
      'MarkerFaceAlpha',.6, 'MarkerEdgeAlpha',0.6);         
        hold on
    end
    colormap(jet); 
    set(gca, 'Ycolor',[0 0 0],'linewidth', 2,'FontSize', 14,'FontWeight', 'bold');
    xlabel(pp1);ylabel(pp2);
    title(titleString);
    c=colorbar;
    c.Label.FontSize=14;
    set(gca,'box','off');
    axis([0. 1. 4. 24.]);
    currentSize = get(gca, 'Position');
    clim=get(c, 'limits');
            hold on
               
                ax = axes;
                plot(ax,G_TRP,TK-273.15,'-','color',[0.4 0.4 0.4],'LineWidth',2);
                axis([0. 1. 4. 24.]);
                set(gca, 'FontSize', 14,'FontWeight', 'bold');
                ax.Color = 'none';
                ax.XTick = [];
                ax.YTick = [];                
                
                axis off;  
                % Adjustment of axes position after colorbar rescale
                set(gca, 'Position', currentSize);
            hold on   
            
        hc=scatter(G_LTestInt(2:end),TCint(2:end),cirklesize,Frequency,'filled');
        set(hc,'MarkerEdgeColor',[0 0 0]);
        set(hc,'LineWidth',0.2, 'MarkerEdgeAlpha', 0.5);
        colormap(jet);
        axis([0. 1. 4. 24.])
        set(gca, 'Position', currentSize); 
        caxis(clim);
        
          

 
                   
    

