data=importdata('2d-309-all.txt');
dataRaw=OutofBoundsDetection(data,100);
index=find(dataRaw(:,2)<=4 & dataRaw(:,2)>0);
dataRaw=dataRaw(index,:);
AP=3:11;

x=dataRaw(:,1);
y=dataRaw(:,2);
RSSI=dataRaw(:,AP);

kNumber=4;
%% Fuzzy Clustering
% [center,U]=fcm(RSSI,kNumber); 
% 
% index=find(U(1,:)'>=0.45);
% plot3(dataRaw(index,1),dataRaw(index,2),U(1,index)','ro');
% hold on;
% 
% index=find(U(2,:)'>=0.45);
% plot3(dataRaw(index,1),dataRaw(index,2),U(2,index)','bo');
% figure;
% index=find(U(3,:)'>=0.45);
% plot3(dataRaw(index,1),dataRaw(index,2),U(3,index)','go');
% hold on;
% index=find(U(3,:)'>=0.45);
% plot3(dataRaw(index,1),dataRaw(index,2),U(3,index)','mo');


[Clusterids,ClusterCtr]=kmeans(dataRaw(:,AP),4);