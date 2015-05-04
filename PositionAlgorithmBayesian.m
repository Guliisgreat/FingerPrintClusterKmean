function [ Position_result ] = PositionAlgorithmBayesian( filename,S_rssi )
% Use Naive Bayesian Classification as Position Algorithm 
% Data import from Fingerprints database


%% Data Import
dataBase=importdata(filename);

%% Initial
num_AP=11;
x=1;
y=2;
AP=5;


max_Lj=max(dataBase(:,y));
min_Lj=min(dataBase(:,y));
num_Lj=(max_Lj-min_Lj)/0.5;            % Step of Location = 0.5
P_S_Lj=zeros(1,num_Lj);                % 0:0.5:6  13 Location points

%% Calulate condition probability P(S|Lj)
Probability_Lj=1;
for Lj=min_Lj:0.5:max_Lj

    Probability_Lj=1;
    for i=1:num_AP
        col_index=find(dataBase(1,:)==S_rssi(i))+1;
        row_index=find(dataBase(:,y)==Lj);
        row_index=row_index(i);
        Probability=dataBase(row_index,col_index);   % Find the probabilty of rssi in Lj from database
        if Probability==0
            Probability=1e-20;
        end
        Probability_Lj=Probability*Probability_Lj;     % Calulate the P(S/Lj)=P(S(1)/Lj)*P(S(2)/Lj)*P(S(3)/Lj)...
    end
    P_S_Lj((Lj/0.5)+1)=Probability_Lj;
    
end


%% Calulate condition probability P(Lj|S)
 P_Lj_S=P_S_Lj/sum(P_S_Lj);
 P_Lj_S=P_Lj_S/sum(P_Lj_S); % normalization

%% Calculate position with probablity based on weighting
 
[probability_sort,index]=sort( P_Lj_S,'descend');
location_sort=(index-1)*0.5;
Position_result=sum(probability_sort.*location_sort)/sum(probability_sort);


end

