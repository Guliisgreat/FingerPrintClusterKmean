function [result_database  ] = P_Database_Each_Cluster( data_Each_Cluster,cluster_Coordinates )
% 每一个簇坐标点所有AP点的[-90dbm,0dbm]概率分布

% data 表示经过处理后的数据
% cluter_Coordinates 表示每一个簇坐标，元素1为x，元素2为y

% 导入Lx点的RSS的数据

ap_number=length(data_Each_Cluster(1,3:13));
num_Appendix=length(cluster_Coordinates)+1+1+1;   % 最后指纹库的格式：x，y，z，Direction，AP，Probability(-90~0dBm)
result_database=zeros(ap_number,61+num_Appendix);

for i=1:ap_number                               % 计算每一个AP点的[-90dbm,0dbm]概率分布
    
    tmp=GaussianP_Generation(data_Each_Cluster(:,i+2));
    result_database(i,:)=[cluster_Coordinates(1),cluster_Coordinates(2),0,1,i,tmp];

end




end

