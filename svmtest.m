function [predict_label,outputArg2] = svmtest(model,X_test,test_class1,test_class2)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
num_sample=size(X_test,1);%��������
test_temp = X_test; %������������һ��Ϊһ������
likelyhood=X_test*model.w+model.b; %likelyhoodΪ���Ŷ�
predict_label=zeros(num_sample,1);
pos_label_index=find(likelyhood>=0);
neg_label_index=find(likelyhood<0);
predict_label(pos_label_index)=test_class1;
predict_label(neg_label_index)=test_class2;


end

