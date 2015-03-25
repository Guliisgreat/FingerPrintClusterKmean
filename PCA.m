






rawData=importdata('1_D_data_selected.txt');


%% Preprocessing

i=1;
dataSize=length(rawData(:,1));



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
preData=rawData(:,3:13);

%% PCA

[coeff,score,latent]=pca(preData(1:100,:));

p=coeff(:,1:5);
u=p';
z=u*preData(:,:)';
z=z*(-1);

tmp=find(z(1,:)<60);

plot3(z(1,1:19),z(2,1:19),z(3,1:19),'.r');
hold on;
plot3(z(1,20:100),z(2,20:100),z(3,20:100),'.b');
axis([40,140,0,90,25,100]);
legend('在X=0点采样值','其它点采样值');
title('PCA降维后结果（11维->3维）')





% % Clustering
% 
% kNumber=4;
% 
% dataRawCluster=z';
%  [Clusterids,ClusterCtr]=kmeans(dataRawCluster,kNumber);
% 
%  N=50;
%  clusterMember=zeros(kNumber,N);
%  clusterMemberNumber=zeros(kNumber,1);
%  colorCluster={'.r'; '.b'; '.g';'.y'};
%  for i=1:kNumber
%      
%      clusterMemberNumber(i,1)=length(preData(Clusterids==i));
%      complementaryNumber=N-clusterMemberNumber(i,1); 
%      clusterMember(i,:)=[preData(Clusterids==i)',zeros(1,complementaryNumber)];
%     
%  end     
%  
% %%  Drawing figure of clustering result
%  plot(clusterMember(1,1:clusterMemberNumber(1,1))',zeros(1,clusterMemberNumber(1,1)),'.c');
%  hold on;
%  plot(clusterMember(2,1:clusterMemberNumber(2,1))',zeros(1,clusterMemberNumber(2,1)),'.g');
%  plot(clusterMember(3,1:clusterMemberNumber(3,1))',zeros(1,clusterMemberNumber(3,1)),'.b');
%  plot(clusterMember(4,1:clusterMemberNumber(4,1))',zeros(1,clusterMemberNumber(4,1)),'.r');
%  axis([-90,-40,-0.2,0.2]);
% title('PCA+Kmeans');
%  
% 
% 
