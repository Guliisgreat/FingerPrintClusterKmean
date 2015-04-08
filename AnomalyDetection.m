function [ dataAfter] = AnomalyDetection( dataRaw,mode )

[m,n]=size(dataRaw);
AP=3:n;
sampleNumber=m;

if mode==1
   K=20;
   threhold=5;
   flag=zeros(1,sampleNumber);

   for i=1:length(AP)
       scoreOutlier  = AnomalyDetectionDensity2D( dataRaw(:,2),dataRaw(:,AP(i)),K);
       
       flag=flag+(scoreOutlier<=threhold);

   end
   
dataAfter=dataRaw;
dataAfter(find(flag>=3),:)=[];
   
   
end   

end

