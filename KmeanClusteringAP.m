clear;
clc;

%% Variable Set
rawData=importdata('1_D_data_selected.txt'); 
apNumber=length(rawData(1,:))-2;
rawDataNumber=length(rawData(:,1));



%% Preprocess, filter overflow data
rawData=rawData(:,2:13);
i=1;
dataSize=rawDataNumber;



while  not(isempty(rawData(i,:)))==1;
   

   
   
    if find(rawData(i,:)==-120)>0
        rawData(i,:)=[];
        dataSize=dataSize-1;
    end
   
    if dataSize==i
        break;
    end
     i=i+1;
    
    
end
preData=rawData;
% x=zeros(1,dataSize);
% plot(preData(:,1)',x,'.');

%% Kmeans Clustering
kNumber=4;

dataRawCluster=preData(:,2:apNumber-1);
 [Clusterids,ClusterCtr]=kmeans(dataRawCluster,kNumber);

 N=50;
 clusterMember=zeros(kNumber,N);
 clusterMemberNumber=zeros(kNumber,1);
 colorCluster={'.r'; '.b'; '.g';'.m'};
 for i=1:kNumber
     
     clusterMemberNumber(i,1)=length(preData(Clusterids==i));
     complementaryNumber=N-clusterMemberNumber(i,1); 
     clusterMember(i,:)=[preData(Clusterids==i)',zeros(1,complementaryNumber)];
    
 end     
 
%%  Drawing figure of clustering result
 plot(clusterMember(1,1:clusterMemberNumber(1,1))',zeros(1,clusterMemberNumber(1,1)),'.r');
 hold on;
 plot(clusterMember(2,1:clusterMemberNumber(2,1))',zeros(1,clusterMemberNumber(2,1)),'.g');
 plot(clusterMember(3,1:clusterMemberNumber(3,1))',zeros(1,clusterMemberNumber(3,1)),'.b');
 plot(clusterMember(4,1:clusterMemberNumber(4,1))',zeros(1,clusterMemberNumber(4,1)),'.y');

 xlabel('×ø±êX');
title('Kmeans  (k=4)')