function [after_data] = ApSelection(raw_data,num_ap_select)
%

% Inuput: Raw Data in 1D
% Output: Data after AP selection based on cluster score;


% Initial

position_start=0;
position_end=6;
AP_start=3;
AP_end=13;




 selection_score=zeros(1,AP_end-AP_start+1);
 
for i=AP_start:AP_end
    var_each_cluster=zeros(1,length(position_end-position_start));
    average_each_cluster=zeros(1,length(position_end-position_start));

    for j=position_start:1:(position_end-1)
       index=find(raw_data(:,2)>=j & raw_data(:,2)<=j+1);
       average_each_cluster(j+1)=mean(raw_data(index,i));
       var_each_cluster(j+1)=var(raw_data(index,i));
    end
    
    % Matrix:(mi-mj)^2
    tmp=repmat(average_each_cluster,length(average_each_cluster),1);
    diff=tril((tmp-tmp').*(tmp-tmp'));   % upper triangular matrix 
    selection_score(i-2)=sum(diff(:))/sum(var_each_cluster);     % score=[(mi-mj)^2]/(Si+..Sj)
    
end

[A,B]=sort(selection_score,'descend');
after_data=raw_data;
after_data(:,B(num_ap_select+1:AP_end-2)+2)=0;

end

