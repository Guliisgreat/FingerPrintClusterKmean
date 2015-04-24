function [ dataAfter ] = processFuzzyClustering2D(dataRaw,kNumber,mode )
% Use Fuzzy clustering to make preprocess on raw data

% This function has two mode. When mode equals 1,this function is merely eliminating 
% anomaly. When mode equals 2, this function is making some smooth on anomaly.


%% Initial Condition

ymax=6;


[m,n]=size(dataRaw);
AP=3:7;
RSSI=dataRaw(:,AP);
x=dataRaw(:,1);
y=dataRaw(:,2);
sampleNumber=m;



%% Fuzzy Clustering
[center,U]=fcm(RSSI,kNumber);      % center       the value of individual cluster centers
                                   % U            the probability of individual sample belong to respect cluster
%    % Drawing Graph
%      plot(y,U(1,:)','b.');

                                   
%% Linear Regression to determine the variation tendency by slope                                 
[r,slope,b]=regression(y,U(1,:)','one');
                                   

% Find singular samples
if slope>0 
    mark=(y<(ymax/2) & U(1,:)'>0.5)+(y>(ymax/2) & U(1,:)'<0.5);

elseif slope<=0
    mark=(y<(ymax/2) & U(2,:)'>0.5)+(y>(ymax/2) & U(2,:)'<0.5);
else 
    tmp='slope=0';
    disp(tmp);
end                                   

% 
%  % Drawing Graph
%      
%      hold on
%      index=find(mark==1);
%      plot(y(index),U(1,index),'or');
     


%% Mode

if mode==1;
    dataRaw(find(mark==1)',:)=[];
    dataAfter=dataRaw;
  
%     %Drawing Graph
%     U(:,find(mark==1))=[];
%     plot(dataAfter(:,2),U(1,:)','o');

elseif mode==2
    
    indexSingular=find(mark==1);
    number=length(indexSingular);
    
    for i=1:number
       

        
        ySingular=dataRaw(indexSingular(i),2);        % extract y co
        


        smoothingSampleRange=find (~(mark)  & (((dataRaw(:,2)>=ySingular-0.2 & dataRaw(:,2)<ySingular) | (dataRaw(:,2)>ySingular & dataRaw(:,2)<ySingular+0.2 )))==1) ;
        smoothingSample=dataRaw(smoothingSampleRange',AP);
        
        if length(smoothingSample(:,1))==0
            continue;
            
        elseif length(smoothingSample(:,1))==1
            dataRaw(indexSingular(i),AP)=smoothingSample;
        else
             modification=mean(smoothingSample);
             dataRaw( indexSingular(i),AP)=modification;
        end
        
        

    
    end
    
    dataAfter=dataRaw;
    
%     %Drawing Graph
%       
%       hold on
%       AP2=dataAfter(:,3:13);
%       [center2,U2]=fcm(AP2,2);
%       plot(dataAfter(:,2),U2(2,:)','or');
end


end

