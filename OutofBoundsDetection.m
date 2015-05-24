function [ afterData] = OutofBoundsDetection( data,boundValue,num_AP)
%UNTITLED Summary of this function goes here

afterData=data;

if num_AP==11
    index=find(data(:,3)<=-boundValue | data(:,4)<=-boundValue | data(:,5)<=-boundValue | data(:,6)<=-boundValue | data(:,7)<=-boundValue | data(:,8)<=-boundValue | data(:,9)<=-boundValue | data(:,10)<=-boundValue |data(:,11)<=-boundValue | data(:,12)<=-boundValue |data(:,13)<=-boundValue );
    afterData(index,:)=[];
elseif num_AP==12
    index=find(data(:,1)<=-boundValue | data(:,2)<=-boundValue | data(:,3)<=-boundValue | data(:,4)<=-boundValue | data(:,5)<=-boundValue | data(:,6)<=-boundValue | data(:,7)<=-boundValue | data(:,8)<=-boundValue |data(:,9)<=-boundValue | data(:,10)<=-boundValue |data(:,11)<=-boundValue |data(:,12)<=-boundValue );
    afterData(index,:)=[];
    


end

