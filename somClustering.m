function [clusterids ] = somClustering( dataAP,clusterNumber )
% Use SOM to make clustering on RSSI of individual AP
% The dimension of outputs equals to clusterNumber

%% SOM
dataAP=dataAP';
inputs=dataAP;
dimension=clusterNumber;
net=selforgmap(dimension);
[net,tr]=train(net,inputs);
outputs=net(inputs);
clusterids=outputs;

end

