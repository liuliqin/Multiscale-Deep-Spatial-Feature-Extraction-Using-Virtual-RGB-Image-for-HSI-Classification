function [trainc,testc,y,numclass,numtrain]=randomselect(hyperlabel,num)
%num 为每类样本数，num<1则按比例计算
labelhyper=hyperlabel;
[height,width]=size(labelhyper);
y=zeros(width*height,1);
for i=1:height
    for j=1:width
        y((i-1)*width+j,1)=labelhyper(i,j);
    end
end      
classes=unique(labelhyper);
numclass=length(classes)-1;
%%
classes=classes(2:numclass+1);
c=cell(numclass,1);
randomc=cell(numclass,1);
trainc=cell(numclass,1);

testc=cell(numclass,1);

numall=zeros(numclass,1);
numtrain=zeros(numclass,1);

for i=1:numclass
    c{i}=find(y==i);
    numall(i,1)=length(c{i});
    rowrank=randperm(numall(i,1));
    randomc{i}=c{i}(rowrank,:);
   if num>1
       numtrain(i,1)=min(num,numall(i,1));
   else
       numtrain(i,1)=round(num*numall(i,1));
   end 
    trainc{i}=randomc{i}(1:numtrain(i,1),:);%每一类选取训练样本的编号
    testc{i}=randomc{i}(numtrain(i,1)+1:numall(i,1),:);
end
end