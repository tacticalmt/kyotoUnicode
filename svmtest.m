function [predict_label,outputArg2] = svmtest(model,X_test,test_class1,test_class2)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
num_sample=size(X_test,1);%样本个数
test_temp = X_test; %测试样本矩阵，一行为一个样本
likelyhood=X_test*model.w+model.b; %likelyhood为置信度
predict_label=zeros(num_sample,1);
pos_label_index=find(likelyhood>=0);
neg_label_index=find(likelyhood<0);
predict_label(pos_label_index)=test_class1;
predict_label(neg_label_index)=test_class2;


end

