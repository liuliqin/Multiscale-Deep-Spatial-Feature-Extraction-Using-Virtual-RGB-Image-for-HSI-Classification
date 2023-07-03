function [data_x,width,height]=spespatest(fm,data,sda,sde)
%fm为空间特征d*h*w，data为高光谱数据h*w*d，sda，sde分别为空间、光谱维度
hyperspectraldata=data;
[height,width,spectral]=size(hyperspectraldata);
da=size(fm,1);
xspa=zeros(da,height*width);
xspe=zeros(spectral,height*width);
%将光谱、空间特征变为d*n
for i=1:height
    for j=1:width
        xspa(:,(i-1)*width+j)=fm(:,i,j);
        xspe(:,(i-1)*width+j)=hyperspectraldata(i,j,:);        
    end
end
%% 光谱特征归一化
[a ps]=mapminmax(xspe);
% PCA
[coeff,score,latent] = pca(a');

xspe=(score(:,1:sde))';
%每维特征求均值、方差
mean_xspe=mean(xspe);
std_xspe=std(xspe);
[~,coldata]=size(xspe);
fxspe=zeros(sde,height*width);
for j=1:coldata
    temp=(xspe(:,j)-mean_xspe(:,j))/std_xspe(:,j);
    fxspe(:,j)=temp/norm(temp);
end
%% 空间特征归一化
% [a ps]=mapminmax(xspa);
% % PCA
% [coeff,score,latent] = pca(a');
% 
% xspa=(score(:,1:sda))';
% %
mean_xspa=mean(xspa);
std_xspa=std(xspa);
[~,coldata]=size(xspa);
fxspa=zeros(sda,height*width);
for j=1:coldata
    temp=(xspa(:,j)-mean_xspa(:,j))/std_xspa(:,j);
    fxspa(:,j)=temp/norm(temp);
end
data_x=[fxspa;fxspe];
end
