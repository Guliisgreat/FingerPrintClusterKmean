function [ Position_result ] = PositionAlgorithmBayesian( dataBase,S_rssi,mode)
% Use Naive Bayesian Classification as Position Algorithm 

% Mode define the method of process
% mode=1 Weighting; mode=2 Choose max probability



%% Initial
global num_AP;

x=1;
y=2;


num_L=length(dataBase(:,1))/num_AP;

L_coordinate.x=dataBase(1:num_AP:end,x);       % L_coordinate : (x,y) of each L in dataBase
L_coordinate.y=dataBase(1:num_AP:end,y);

P_S_Lj=zeros(1,num_L);   % P_S_Lj:  P(S|Lj)


%% Calulate condition probability P(S|Lj)

for Lj=1:num_L
   
    Probability_Lj=1;
    for i=1:num_AP
        % Find the probabilty of rssi in Lj from database
        col_index=find(dataBase(1,:)==S_rssi(i))+1;
        row_index=find(dataBase(:,x)==L_coordinate.x(Lj) & dataBase(:,y)==L_coordinate.y(Lj));   
        row_index=row_index(i);
        
        Probability=dataBase(row_index,col_index); 
       
        % Probability nonzero    
        if Probability==0
            Probability=1e-20;
        end
        
        % Calulate the P(S|Lj)=P(S(1)|Lj)*P(S(2)|Lj)*P(S(3)|Lj)...
        Probability_Lj=Probability*Probability_Lj;     
    end
    
    
    P_S_Lj(Lj)=Probability_Lj;

end



%% Calulate condition probability P(Lj|S)
 P_Lj_S=P_S_Lj/sum(P_S_Lj);
 P_Lj_S=P_Lj_S/sum(P_Lj_S); % normalization

%% Calculate position with probablity based on weighting
 
[probability_sort,index_sort_descend]=sort( P_Lj_S,'descend');
location_sort_x=L_coordinate.x(index_sort_descend);
location_sort_y=L_coordinate.y(index_sort_descend);

if mode==1     % Weighting all position
   Position_result.coordinate=[sum(probability_sort.*location_sort_x')/sum(probability_sort),sum(probability_sort.*location_sort_y')/sum(probability_sort)];
elseif mode==2     % Choose the position with the most probability
   Position_result.coordinate=[location_sort_x(1),location_sort_y(1)];
   Position_result.probability=probability_sort(1);
end

end

