function [ scoreOutlier ] = AnomalyDetectionDensity1D( rawData,K)
% Anomaly Detection based on Density

% Definite Score of outlier to value the density of each data
% Score of outlier : the reciprocal of the average of KNN
% Choose K as a value to 

%% Initial

numberOf_rawData=length(rawData);
processData=rawData;
scoreOutlier=zeros(1,numberOf_rawData);
%% Distance Matrix
distance=zeros(numberOf_rawData,numberOf_rawData);

for i=1:numberOf_rawData
    for j=1:numberOf_rawData
        distance(i,j)=abs(rawData(i)-rawData(j));
        
    end
end

%% KNN + Outlier Score
if numberOf_rawData<K
    processData=rawdata;
    
else
    for i=1:numberOf_rawData
        tmp=sort(distance(i,:));
        dataChooseKnn=tmp(1:K);
        scoreOutlier(i)=(sum(dataChooseKnn)/K)^(-1);
    end
    
end

scoreOutlier(scoreOutlier==Inf)=100;










end

