function [ P_rss] =GaussianP_Generation(Data)
% ��Data�������ɸ�˹���ʷֲ�
% ȡֵ��Χ[-90,0],step=1
Data(Data<=-90)=[];

Data_row=Data';
Data_average=mean(Data_row);         % Data_average  ����
Data_variance=var(Data_row)+0.001;         % Data_variance ����

P_rss=zeros(1,61);
index=1;


    
for rss=-90:-30
    P_rss(index)=0.5*(erfc((rss-0.5-Data_average)/(sqrt(2)*Data_variance))-erfc((rss+0.5-Data_average)/(sqrt(2)*Data_variance)));
    index=index+1;                   % P_rss         ÿһ��rss+��0.5�����ڸ���

end



sumP=sum(P_rss);                     % ��һ������
P_rss=P_rss/sumP;



end

