function [ dataPreprocess ] = preProcess( filename )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

rawData=importdata(filename);
sampleSize=size(rawData(:,1));


for i=1:sampleSize
    
     if isempty(find(rawData(i,:)==-120))==0
         rawData(i,1)=9999;
     end 

end



rawData(find(rawData(i,1)==9999),:)=[];



dataPreprocess=rawData(:,3:13);



end

