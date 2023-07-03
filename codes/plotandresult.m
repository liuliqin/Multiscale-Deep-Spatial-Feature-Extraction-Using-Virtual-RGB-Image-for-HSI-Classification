function img=plotandresult(label,height,width,allp)
labelsquare=zeros(height,width);
img=zeros(height,width,3);
for i=1:height
    for j=1:width
        index=find(allp==((i-1)*width+j));
        if isempty(index)
            img(i,j,:)=[0,0,0];
        else
            labelsquare(i,j)=label(index,1);
            switch labelsquare(i,j)
                case 1
                    img(i,j,:)=[255,99,71];
                case 2
                    img(i,j,:)=[0,0,255];
                case 3
                    img(i,j,:)=[255,0,0];
                case 4
                    img(i,j,:)=[0,255,0];
                case 5
                    img(i,j,:)=[255,0,255];
                case 6
                    img(i,j,:)=[255,215,0];
                case 7
                    img(i,j,:)=[255,192,203];
                case 8
                    img(i,j,:)=[0,255,255];
                case 9
                    img(i,j,:)=[255,255,0];
                case 10
                    img(i,j,:)=[139,69,19];
                case 11
                    img(i,j,:)=[138,43,226];
                case 12
                    img(i,j,:)=[30,144,255];
                case 13
                    img(i,j,:)=[128,138,135];
                case 14
                    img(i,j,:)=[34,139,34];
                case 15
                    img(i,j,:)=[237,145,33];
                case 16
                    img(i,j,:)=[255,97,0];
            end
        end               
           
    end
end
% save('D:\levir实验室学习\毕设\程序\predictedlabel2.mat','labelsquare');
end






        