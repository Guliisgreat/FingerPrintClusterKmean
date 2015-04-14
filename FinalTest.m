clc;
clear;
%% Import and Initial
tmp=importdata('xd.txt');
data=tmp.data;

%% AnomalyDetection
afterAnomal= AnomalyDetection( data,1 );

%% FuzzyCluster Correct
afterFuzzy=processFuzzyClustering2D(afterAnomal,2,2 );



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


% %% SOM
% outputs=somClustering(after(:,3:13),3);
% index=find(outputs(1,:)==1);
% indexx=find(outputs(2,:)==1);
% indexxx=find(outputs(3,:)==1);
%  figure;
%  plot(after(index,2),1,'ob');   
%  hold on; 
%  plot(after(indexx,2),2,'or');
%  hold on; 
%  plot(after(indexxx,2),3,'og');  
 
 %% Kernal Regression
afterRegression=AddingDataSet( afterFuzzy,1);

%   % Graph Drawing
%   x=after(:,2);
%   y=after(:,8);
%   i=1;
%   for xx=0.5:0.01:5
%      yy(i)=GP_Regression(x,y,xx);
%      i=i+1;
%   end
%   xx=0.5:0.01:5;
%   plot(xx,yy,'b');
%   hold on;
%   plot(x,y,'ob');

%% DataBase Create
 database=fingerprint_Database_Final(afterFuzzy);