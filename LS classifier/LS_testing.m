function [predict_label] = LS_testing(model,X_test,test_class1,test_class2)
%LS_TESTING ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
num_sample = size(X_test,1);
test_temp=[ones(num_sample,1) X_test];
value_vector=test_temp*model.wt;
predict_label=sign(value_vector);
pos_label_index=find(predict_label==1);
neg_label_index=find(predict_label==-1);
predict_label(pos_label_index)=test_class1;
predict_label(neg_label_index)=test_class2;
end

