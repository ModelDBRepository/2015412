% The script was written by Natalia Maksymchuk for the article 
% Maksymchuk N, Sakurai A, Cox DN, Cymbalyuk GS. 
% Cold-Temperature Coding with Bursting and Spiking 
% Based on TRP Channel Dynamics in Drosophila Larva Sensory Neurons. 
% International Journal of Molecular Sciences. 2023; 24(19):14638. 
% https://doi.org/10.3390/ijms241914638

% Experimental Fast Temperature protocol
dataName='ExpTetmpData';
TempdataR = load([dataName,'.txt']);% Raw data where t0 is not zero

Tempdata(:,1)=TempdataR(:,1)-TempdataR(1,1);%
Tempdata(:,2)=TempdataR(:,2);

%% Figure with temperature protocol
colorTem=[255./255. 0./255. 43./255.];
FontSz=16.;
FontName='Arial';
figure; 
hp1=plot(Tempdata(:,1),Tempdata(:,2), 'linewidth',2);
set(hp1, 'color', colorTem, 'linewidth', 2)
ylim([8. 26.]);
ylabel('T, {}^oC')
xlabel('t, s')
%set(gca,'Ycolor',colorTem,'linewidth', 2,'FontWeight','bold','fontsize',FontSz)
set(gca, 'FontSize', 10,'FontWeight', 'bold');
title(dataName)


