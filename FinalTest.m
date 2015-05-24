clc;
clear;
%% Import and Initial
data=importdata('2d-309-all.txt');
data=OutofBoundsDetection(data,100);

num_ap_select=5;
databaseFinal=[];

for n=1

index=find(data(:,1)==n);
xdata=data(index,:);

%% AP Selection
afterAp=ApSelection(xdata,num_ap_select);

%% AnomalyDetection
afterAnomal= AnomalyDetection( xdata,1 );

%% FuzzyCluster Correct
afterFuzzy=processFuzzyClustering2D(afterAnomal,2,2 );



%% Kmeans

% [Clusterids,ClusterCtr]=kmeans(data(:,3:13),3);
% plot(data(:,2),Clusterids,'o');
% 
% [Clusterids,ClusterCtr]=kmeans(afterAnomal(:,3:13),3);
% figure;
% plot(afterAnomal(:,2),Clusterids,'o');


% [Clusterids,ClusterCtr]=kmeans(afterFuzzy(:,3:13),3);
% figure;
% plot(afterFuzzy(:,2),Clusterids,'o');


% %% SOM
% % Original
% outputs=somClustering(data(:,3:13),3);
% index=find(outputs(1,:)==1);
% indexx=find(outputs(2,:)==1);
% indexxx=find(outputs(3,:)==1);
%  figure;
%  plot(data(index,2),1,'ob');   
%  hold on; 
%  plot(data(indexx,2),2,'or');
%  hold on; 
%  plot(data(indexxx,2),3,'og');  
% 
% % After Process
% figure;
% 
% outputs=somClustering(afterFuzzy(:,3:13),3);
% index=find(outputs(1,:)==1);
% indexx=find(outputs(2,:)==1);
% indexxx=find(outputs(3,:)==1);
%  figure;
%  plot(afterFuzzy(index,2),1,'ob');   
%  hold on; 
%  plot(afterFuzzy(indexx,2),2,'or');
%  hold on; 
%  plot(afterFuzzy(indexxx,2),3,'og');  
%  
 %% Kernal Regression
afterRegression=AddingDataSet( afterFuzzy,1);

  % Graph Drawing
  x=afterFuzzy(:,2);
  y=afterFuzzy(:,13);
  i=1;
  for xx=0.5:0.01:5.5
     yy(i)=GP_Regression(x,y,xx);
     i=i+1;
  end
  xx=0.5:0.01:5.5;
  plot(xx,yy,'b');
  hold on;
  plot(x,y,'ob');

%% DataBase Create
 database=fingerprint_Database_Final(afterFuzzy);
 
 
 %% Correct Database Format
 
 database(find(isnan(database)))=0; 
 count=1;
 num_sample=length(database(:,1));
 num_col=length(database(1,:));
 end_row=num_col;
 
 rssi=-90;
 i=5;
 while count<=61
     tmp=ones(num_sample,1)*rssi;
     part1=database(:,1:i);
     part2=database(:,i+1:end_row);
     
     database=[part1,tmp,part2];
     
     end_row=end_row+1;
     i=i+2;
     count=count+1;
     rssi=rssi+1;
     
 end
 
 % AP
 
 name_AP=[1;2;3;4;5;6;7;8;9;10;11;];
 index=1;
 for i=1:num_sample/11
     database(index:index+10,5)=name_AP;
     index=index+11;
     
 end
 
 
 
 databaseFinal=[databaseFinal;database];


    
end 

 %% TXT File
%  str_n=num2str(n);

%  file_name=['x',str_n,'.txt'];
file_name='afterProcess.txt';
dlmwrite(file_name,databaseFinal);



%% Position
random_select_index=round(rand(1,30)*100);
test_sample=xdata(random_select_index',3:13);

error=zeros(1,length(random_select_index));
for i=1:length(random_select_index)
    real_result=xdata(random_select_index(i),2);
    position_result=PositionAlgorithmBayesian('afterProcess.txt',test_sample(i,:));
    error(i)=abs(real_result-position_result)
end

average=mean(error)
 