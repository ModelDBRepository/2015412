% The script was written by Natalia Maksymchuk for the article 
% Maksymchuk N, Sakurai A, Cox DN, Cymbalyuk GS. 
% Cold-Temperature Coding with Bursting and Spiking 
% Based on TRP Channel Dynamics in Drosophila Larva Sensory Neurons. 
% International Journal of Molecular Sciences. 2023; 24(19):14638. 
% https://doi.org/10.3390/ijms241914638

%_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_
% April 28 2020 improved version wich takes into account small oscillations
%_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_

function [NNmax] = FunkNNmax(t,V,thresh)

                      
[Vpeak,NNpeak] = findpeaks(V);
a=find(Vpeak>=thresh);
NNmax=NNpeak(a);



if   isempty(a)==1
     NNmax=zeros;
end     
    
      
end 





