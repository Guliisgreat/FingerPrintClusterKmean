function [ result_database] = fingerprint_Database_Final( data )
% Use processed data to be classified into each cluster
% Use data in each cluster to fit a Gaussian distribution
% Build Fingerprint database with each Gaussian distribution 


% 1D: only have variable in y_coordinate
% Input Format (data): x,y,AP1,...AP13
% Output: TXT file
%% Initial

result_database=[];

x=data(:,1);
y=data(:,2);
num_Sample=length(data(:,1));
coordinates_Start=round(min(y));
coordinates_End=round(max(y));

%% Classification
cluster_Coordinates=coordinates_Start:0.5:coordinates_End;                % Coordination of each cluster
x_Fit=repmat(x(1),1,length(cluster_Coordinates));
cluster_Coordinates=[x_Fit;cluster_Coordinates];                          % Coordination Fomat: [x_Coordinate;y_Coordinate]

sample_Belongsto_Cluster=zeros(1,num_Sample);

for i=1:num_Sample
    diff=abs(y(i)-cluster_Coordinates(2,:));
    [tmp,sample_Belongsto_Cluster(i)]=min(diff); 
    
end

%% dataBase

for j=1:length(cluster_Coordinates)
    data_Each_Cluster=data(find(sample_Belongsto_Cluster==j),:);
    tmp= P_Database_Each_Cluster( data_Each_Cluster,cluster_Coordinates(:,j) );
    result_database=[result_database;tmp];

end

