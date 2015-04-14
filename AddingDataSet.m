function [ afterData] = AddingDataSet( data,mode)
% Because of small data set after different preprocessing method, it is
% difficult and invalid to use statitics method to make inference.Therfore,
% we need to use some method to increase the scale of data set,such as
% regression,interpolation and so on.

% 1D

% Mode=1: Gaussian Process Regression


%% Initial 
num_AP=length(data(1,:))-2;
x_Coordinate=data(:,1);
y_Coordinate=data(:,2);

x_input=data(:,2);
y_input=data(:,3:num_AP+2);   %%  11 AP

x_target=min(x_input):0.01:max(x_input);
num_xTarget=x_target;

rssi_AP=[];



if mode==1
    

   for i=1:num_AP
       tmp_yTarget=zeros(1,length(num_xTarget));
       
       j=1;
       for x_target=min(x_input):0.01:max(x_input);
          tmp_yTarget(j)=GP_Regression(x_input,y_input(:,i),x_target);
          j=j+1;
       end
      
       rssi_AP=[rssi_AP,tmp_yTarget'];

   end

   
   x_target=min(x_input):0.01:max(x_input);
   x_Coordinate_Target=repmat(x_Coordinate(1),1,length(x_target));
   y_Coordinate_Target=x_target;

   afterData=[x_Coordinate_Target',y_Coordinate_Target',   rssi_AP];
end










end

