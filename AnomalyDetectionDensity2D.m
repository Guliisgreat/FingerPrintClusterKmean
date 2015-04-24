function [ scoreOutlier ] = AnomalyDetectionDensity2D( xData,yData,K)
%  Anomaly Detection based on Density

% Definite Score of outlier to value the density of each data
% Score of outlier : the reciprocal of the average of KNN
% K : the number of neibour points choosed

%% Initial

numberOfData=length(yData);
scoreOutlier=zeros(1,numberOfData);

%% Standardzation

rangeX=max(xData)-min(xData);
xStandard=(xData-min(xData))/rangeX;

rangeY=max(yData)-min(yData);
yStandard=(yData-min(yData))/rangeY;
% 
%   %Drawing Graph
%    plot(xStandard,yStandard,'.');

%% Distance Matrix
xx=repmat(xStandard,1,numberOfData);
xDiff=xx-xx';
yy=repmat(yStandard,1,numberOfData);
yDiff=yy-yy';
distance=sqrt(xDiff.*xDiff+yDiff.*yDiff);

%% KNN + Outlier Score
if numberOfData<K
   tmp='number<K';
   disp(tmp); 
else
    for i=1:numberOfData
        tmp=sort(distance(i,:));
        dataChooseKnn=tmp(1:K);
        scoreOutlier(i)=(sum(dataChooseKnn)/K)^(-1);
    end
    
end

scoreOutlier(scoreOutlier==Inf)=100;

%    %Drawing Graph
%      hold on    
%      index=find(scoreOutlier<=5);
%      hold on; 
%      plot(xStandard(index),yStandard(index),'or');
% 

end


