function [train_x,train_y,test_x,test_y,trainp,testp]=trainortest(data_x,numclass,y,trainc,testc)
x=data_x';
for i=1:numclass
    if i==1
        train_x=x(trainc{i},:);
        trainp=trainc{i};
        train_y=y(trainc{i},:);
        test_x=x(testc{i},:);
        testp=testc{i};
        test_y=y(testc{i},:);
    else
        train_x=[train_x;x(trainc{i},:)];
        trainp=[trainp;trainc{i}];
        train_y=[train_y;y(trainc{i},:)];
        test_x=[test_x;x(testc{i},:)];
        testp=[testp;testc{i}];
        test_y=[test_y;y(testc{i},:)];
    end    
end
end
