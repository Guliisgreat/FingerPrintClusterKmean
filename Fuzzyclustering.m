tmp=importdata('2d-309-after.txt');
data=tmp.data;


arr=3;
AP=data(:,3:13);
[center,U]=fcm(AP,5);


for i=1:5
   figure;
    plot3(data(:,1),data(:,2),U(i,:)','.');
end
