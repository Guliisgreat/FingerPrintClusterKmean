function [ data3 ] = PCA11to3( data11,k)
% Use PCA to reduce dimension
% Reduce dimension from 11 to 3

dimensionAfter=3;

[coeff,score,latent]=pca(data11(:,3:13));

p=coeff(:,1:dimensionAfter);
u=p';
z=u*data11(:,3:13)';
z=z*(-1);



plot3(z(1,:),z(2,:),z(3,:),'.');
hold on;

t=z(:,find(data11(:,2)==k)');

plot3(t(1,:),t(2,:),t(3,:),'r.');

data3=z;



end

