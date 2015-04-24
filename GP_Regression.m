function [ y_target ] = GP_Regression(x_input,y_input,x_target)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

gaussian_Noise=0.1;
scale_Relativity=0.3;


num_Sample=length(x_input);
rssi_Sample_StandardDeviation=std(y_input);

%% Kernal Matrix
 % K(i,j)=std^2*exp[(1/-2l^2)*abs((xi-xj)^2)]
x_input_tmp=repmat(x_input,1,num_Sample);
diff_K=(abs(x_input_tmp-x_input_tmp')).*(abs(x_input_tmp-x_input_tmp'));
kernal_Matrix=rssi_Sample_StandardDeviation^2*exp((1/2*scale_Relativity^2)*diff_K);

%% Relativity Matrix
diff_k=abs(x_input-x_target).*abs(x_input-x_target);
relativity_Matrix=rssi_Sample_StandardDeviation^2*exp((1/2*scale_Relativity^2)*diff_k);

%% yTarget Calculation
unit_Matrix=eye(num_Sample,num_Sample);
y_target=relativity_Matrix'* inv(kernal_Matrix+unit_Matrix*gaussian_Noise)*y_input;

% %% Graph Drawing
% plot(x_input,y_input,'.b');
% hold on
% plot(x_target,y_target,'.r')

end

