tmp=importdata('1Dx1.txt');
data=tmp.data;
afterdata=[];
ap=5;
kNumber=4;


%% Clustering Kmeans
 
dataCluster=[data(:,2),data(:,ap)];

 [Clusterids,ClusterCtr]=kmeans(data(:,ap),kNumber);


cluster1=dataCluster((Clusterids==1),:);
cluster2=dataCluster((Clusterids==2),:);
cluster3=dataCluster((Clusterids==3),:);
cluster4=dataCluster((Clusterids==4),:);

plot(cluster1(:,1),cluster1(:,2),'b.');
hold on;
plot(cluster2(:,1),cluster2(:,2),'r.');
plot(cluster3(:,1),cluster3(:,2),'g.');
plot(cluster4(:,1),cluster4(:,2),'m.');







% %% Anomaly Detection based on density
% 
% for y=0:0.2:5.8
%     sub=data((data(:,2)>=y & data(:,2)<(y+0.2)),ap);
% 
%     
%     if length(sub)<=3
%         continue
%     end
%     
%     sub=AnomalyDetectionDensity(sub',3,0.75);
%     number=length(sub);
%     tmp=y*ones(number,1);
%     adding=[tmp,sub'];
%     afterdata=[afterdata;adding];
%    
%     
%     
% end   
% plot(afterdata(:,1),afterdata(:,2),'.r');
% 






% %% Mean + Interporlation
%  
% afterdata=[];
% for y=0:0.2:5.8
%     sub=data((data(:,2)>=y & data(:,2)<(y+0.2)),ap);
%     
%     ave=mean(sub);
%  
%     
%     adding=[y,ave];
%     afterdata=[afterdata;adding];
%    
%     
%     
% end   
% x=0:0.1:6;
% y1=interp1(afterdata(:,1),afterdata(:,2),x,'spline');
% plot(x,y1);
% 
%















% %% Sampling Process Simulation
% 
% obsNumber=length(data(:,1));
% 
% for i=1:obsNumber
%     x=data(i,2);
%     y=data(i,3);
%     
%     plot(x,y,'.');
%     axis([0,6,-80,-45]);
%     
%     hold on;
%     i
%     pause;
% end