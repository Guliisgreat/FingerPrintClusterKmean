%% load data;

tmp=importdata('1Dx1.txt');
data=tmp.data;

%% EM conditon set
iterateMax=10;
error=10e-4;

%% Parameter initial
numOfGauss=5;
weightEach=zeros(iterateMax,numOfGauss);
meanEach=zeros(iterateMax,numOfGauss);
varEach=zeros(iterateMax,numOfGauss);

%% Weight initial

% Kmeans
sumCount=length(data(:,1));
[Clusterids,ClusterCtr]=kmeans(data,numOfGauss);

for i=1:numOfGauss
    weightEach(1,i)=length(find(ClusterCtr==i))/sumCount;
end

%% E step
