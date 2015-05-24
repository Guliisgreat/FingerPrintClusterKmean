clc;
clear;

%% Constant Set
global num_AP;
num_AP=12;
mode=2;   % Define the method of process in function 'PositionAlgorithmBayesian'



%% Data Import
testdata_filename='x 0.5 y 0 .txt';
dataBase_filename='database301.txt';

dataBase=importdata(dataBase_filename);
dataBase=dataBase(:,2:end);

tmp=importdata(testdata_filename);
test_data=tmp.data;
test_data=test_data(:,2:end);
num_test_data_sample_original=length(test_data(:,1));


% Filter data out of bound; Set bound=-90dBm
test_data=OutofBoundsDetection(test_data,90,num_AP);
% Load (x,y) by string process
s= regexp(testdata_filename, '\s+', 'split');
x_fact=str2double(char(s(2)));
y_fact=str2double(char(s(4)));

%% Initial 
num_test_data_sample=length(test_data(:,1));

x_estimate_each=zeros(1,num_test_data_sample);
y_estimate_each=zeros(1,num_test_data_sample);
probability_estimate_each=zeros(1,num_test_data_sample);

%% Calculate the Estimate Coordinate and Probabilty in each Sample

for i=1:num_test_data_sample
    
    S_rssi=test_data(i,:);
    [result]=PositionAlgorithmBayesian( dataBase,S_rssi,mode);
    
    x_estimate_each(i)=result.coordinate(1);
    y_estimate_each(i)=result.coordinate(2);
    probability_estimate_each(i)=result.probability;

end


%% Weighting the estimate result
x_estimate_final=sum(x_estimate_each.*probability_estimate_each)/sum(probability_estimate_each);
y_estimate_final=sum(y_estimate_each.*probability_estimate_each)/sum(probability_estimate_each);

Position.num_sample=num_test_data_sample_original;
Position.fact=[x_fact,y_fact];
Position.estimate=[x_estimate_final,y_estimate_final];
Position
