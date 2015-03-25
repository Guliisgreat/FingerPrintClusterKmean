tmp=importdata('1Dx1.txt');
data=tmp.data;
%%
r=find(data(:,2)==0);
e= find(data(:,2)==6);
z=[r;e];

data(z,:)=[];
%%
x=data(:,2);
Ap=data(:,8);






scatter(Ap,x,'r.');
hold on
ma=max(Ap(:,1));
mi=min(Ap(:,1));

l=size(x);
i=1;
for rssa=mi:ma
   
    l(i)=mean(x(find(Ap(:,1)==rssa)));
    i=i+1;
end

xx=mi:ma;

xx(isnan(l))=[];
l(isnan(l))=[];
scatter(l,xx,'filled')


b=regress(xx',l');



y=b*xx;
plot(xx,y);