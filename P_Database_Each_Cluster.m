function [result_database  ] = P_Database_Each_Cluster( data_Each_Cluster,cluster_Coordinates )
% ÿһ�������������AP���[-90dbm,0dbm]���ʷֲ�

% data ��ʾ��������������
% cluter_Coordinates ��ʾÿһ�������꣬Ԫ��1Ϊx��Ԫ��2Ϊy

% ����Lx���RSS������

ap_number=length(data_Each_Cluster(1,3:13));
num_Appendix=length(cluster_Coordinates)+1+1+1;   % ���ָ�ƿ�ĸ�ʽ��x��y��z��Direction��AP��Probability(-90~0dBm)
result_database=zeros(ap_number,61+num_Appendix);

for i=1:ap_number                               % ����ÿһ��AP���[-90dbm,0dbm]���ʷֲ�
    
    tmp=GaussianP_Generation(data_Each_Cluster(:,i+2));
    result_database(i,:)=[cluster_Coordinates(1),cluster_Coordinates(2),0,1,i,tmp];

end




end

