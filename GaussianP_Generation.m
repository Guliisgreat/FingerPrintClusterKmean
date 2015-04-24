function [ P_rss] =GaussianP_Generation(Data)
% 将Data数组生成高斯概率分布
% 取值范围[-90,0],step=1
Data(Data<=-90)=[];

Data_row=Data';
Data_average=mean(Data_row);         % Data_average  期望
Data_variance=var(Data_row)+0.001;         % Data_variance 方差

P_rss=zeros(1,61);
index=1;


    
for rss=-90:-30
    P_rss(index)=0.5*(erfc((rss-0.5-Data_average)/(sqrt(2)*Data_variance))-erfc((rss+0.5-Data_average)/(sqrt(2)*Data_variance)));
    index=index+1;                   % P_rss         每一个rss+—0.5区间内概率

end



sumP=sum(P_rss);                     % 归一化处理
P_rss=P_rss/sumP;



end

