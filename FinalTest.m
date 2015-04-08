clc;
clear;

tmp=importdata('xd.txt');
data=tmp.data;

dataAnomal= AnomalyDetection( data,1 );
after=processFuzzyClustering2D(dataAnomal,2,2 );



% %% Kmeans
% 
% [Clusterids,ClusterCtr]=kmeans(data(:,3:13),5);
% plot(data(:,2),Clusterids,'.');
% 
% [Clusterids,ClusterCtr]=kmeans(dataAnomal(:,3:13),5);
% figure;
% plot(dataAnomal(:,2),Clusterids,'o');
% 
% 
% [Clusterids,ClusterCtr]=kmeans(after(:,3:13),5);
% figure;
% plot(after(:,2),Clusterids,'.');


%% SOM
outputs=somClustering(after(:,3:13),3);
index=find(outputs(1,:)==1);
indexx=find(outputs(2,:)==1);
indexxx=find(outputs(3,:)==1);
 figure;
 plot(after(index,2),1,'ob');   
 hold on; 
 plot(after(indexx,2),2,'or');
 hold on; 
 plot(after(indexxx,2),3,'og');  
 
 %%