function [cmd,predict_label,OA]=hohosvm(train_x,train_y,test_x,test_y)
train=train_x;
test=test_x;
train_group=train_y;
test_group=test_y;
% %数据预处理，用matlab自带的mapminmax将训练集和测试集归一化处理[0,1]之间
% %训练数据处理
% [train,pstrain] = mapminmax(train');
% % 将映射函数的范围参数分别置为0和1
% pstrain.ymin = 0;
% pstrain.ymax = 1;
% % 对训练集进行[0,1]归一化
% [train,pstrain] = mapminmax(train,pstrain);
% % 测试数据处理
% [test,pstest] = mapminmax(test');
% % 将映射函数的范围参数分别置为0和1
% pstest.ymin = 0;
% pstest.ymax = 1;
% % 对测试集进行[0,1]归一化
% [test,pstest] = mapminmax(test,pstest);
% % 对训练集和测试集进行转置,以符合libsvm工具箱的数据格式要求
% train = train';
% test = test';
[mtrain,ntrain]=size(train);
[mtest,ntest]=size(test);
dataset=[train;test];
[dataset_scale,ps]=mapminmax(dataset',0,1);
dataset_scale=dataset_scale';
train=dataset_scale(1:mtrain,:);
test=dataset_scale((mtrain+1):(mtrain+mtest),:);
%寻找最优c和g
%粗略选择：c&g 的变化范围是 2^(-10),2^(-9),...,2^(10)
[bestacc,bestc,bestg] = SVMcgForClass(train_group,train,-10,10,-10,10);
%精细选择：c 的变化范围是 2^(-2),2^(-1.5),...,2^(4), g 的变化范围是 2^(-4),2^(-3.5),...,2^(4)
[bestacc,bestc,bestg] = SVMcgForClass(train_group,train,-2,4,-4,4,3,0.5,0.5,0.9);

%训练模型
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
model=libsvmtrain(train_group,train,cmd);
disp(cmd);

%测试分类
[predict_label, accuracy, dec_values]=libsvmpredict(test_group,test,model);
OA=accuracy/100;
end

