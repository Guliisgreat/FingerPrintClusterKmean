tmp=importdata('1Dx1.txt');
data=tmp.data;

data=data(:,:);

afterdata=[];
ap=5;
kNumber=4;
% index=(find(data(:,2)==0 | data(:,2)==6 )); 
% data(index,:)=[];



% %% PCA
% 
% [coeff,score,latent]=pca(data(:,:));
% 
% p=coeff(:,1);
% u=p';
% z=u*data(:,:)';
% z=z*(-1);
% 
% data=[data(:,1:2),z'];




%% Clustering Fuzzy
 
arr=3:13;

AP=data(:,arr);
[center,U]=fcm(AP,2);

% diff=abs(U(1,:)-U(2,:));
% index=find(diff<0.1);
% 
% data(index,:)=[];
% U(:,index)=[];

plot(data(:,2),U(1,:)','b.');



% 
% tmp1=data(find(U(1,:)'>=0.5 & data(:,2)<=3  ),:);
% tmp2=data(find(U(2,:)'>=0.5 & data(:,2)>=3  ),:);
% 
% tmp=[tmp1;tmp2];
% 
% figure;
% plot(tmp(:,2),tmp(:,4),'.');
% 
% hold on;
% plot(data(:,2),data(:,4),'o');


%%
pppp=data;
x1=find((U(1,:)>0.5)&(data(:,2)'>=3));
x2=find((U(1,:)<0.5)&(data(:,2)'<=3));
index=[x1,x2];

number=length(index);
for i=1:number
    y=pppp(index(i),2);
    rssi=pppp(index(i),3:13);
    smoothindex=find(((pppp(:,2)>=y-0.2 & pppp(:,2)<y) | (pppp(:,2)>y & pppp(:,2)<y+0.2 )) ) ;
    neiboughood=pppp(smoothindex',3:13);
    modification=mean(neiboughood);
    pppp(index(i),3:13)=modification;
end
pppp(find(pppp(:,3:13)==NaN),:)=[];

AP=pppp(:,arr);
[center2,U2]=fcm(AP,2);
hold on;


plot(pppp(:,2),U2(1,:)','r.');




% 
% pppp(index,:)=[];
% U(:,index)=[];
% figure;
% 
% % plot(data(:,2),U(2,:)','o');
% 
% plot(data(:,2),data(:,3),'.');
% hold on;
% plot(pppp(:,2),pppp(:,3),'o');

%% binary division
% x2=find((U(1,:)>0.5)&(data(:,2)'<=3));
% 
% data=data(x2,:);
% [center2,U2]=fcm(data(:,3),2);
% 
% figure;
% plot(data(:,2),U2(1,:)','r.')

% %% Anomaly Detection based on density
% 

% ap=4;
% for y=0:0.2:5.8
%     sub=data((data(:,2)>=y & data(:,2)<(y+0.2)),ap);
% 
%     
%     if length(sub)<=3
%         continue
%     end
%     
%     sub=AnomalyDetectionDensity(sub',3,0.75);
%     number=length(sub);
%     tmp=y*ones(number,1);
%     adding=[tmp,sub'];
%     afterdata=[afterdata;adding];
%    
%     
%     
% end
% hold on;
% plot(afterdata(:,1),afterdata(:,2),'or');







% %% Mean + Interporlation
%  
% afterdata=[];
% for y=0:0.2:5.8
%     sub=data((data(:,2)>=y & data(:,2)<(y+0.2)),ap);
%     
%     ave=mean(sub);
%  
%     
%     adding=[y,ave];
%     afterdata=[afterdata;adding];
%    
%     
%     
% end   
% x=0:0.1:6;
% y1=interp1(afterdata(:,1),afterdata(:,2),x,'spline');
% plot(x,y1);
% 
%















% %% Sampling Process Simulation
% 
% obsNumber=length(data(:,1));
% 
% for i=1:obsNumber
%     x=data(i,2);
%     y=data(i,3);
%     
%     plot(x,y,'.');
%     axis([0,6,-80,-45]);
%     
%     hold on;
%     i
%     pause;
% end