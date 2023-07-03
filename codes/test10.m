clear all;
clc;
close all;
A = inputdlg('select data,1 for salinas;2 for indian_pines;3 for paviaU;4 for KSC;5 for DFC');
selectdata = str2num(cell2mat(A));
[result,accur]=dmsfe(selectdata);
% conclusion=[];
% for i=1:10
%     [result,accur]=dmsfe(selectdata);
%     re=[accur;result];
%     conclusion=[conclusion,re];
% end
% save(['fcnconclusion',num2str(selectdata),'.mat'],'conclusion');