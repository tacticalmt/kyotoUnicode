function [Train_sets,Train_labels] = generating_train(X_used,X_label,num_classes,name_label,i_class1,i_class2,lotimes)
%GENERATING_TRAIN 此处显示有关此函数的摘要
%   此处显示详细说明
train_cell=X_used;
train_label=X_label;
train_sample_temp=train_cell{lotimes,1}(:,1:end-1);
Train_labels1_index=find(train_label==i_class1);
Train_labels2_index=find(train_label==i_class2);
num_label1=length(Train_labels1_index);
num_label2=length(Train_labels2_index);
label1_temp=ones(num_label1,1);
label2_temp=-ones(num_label2,1);
Train_labels=[label1_temp;label2_temp];
%Train_labels(Train_labels1_index)=1;
%Train_labels(find(train_label==i_class2))=(-1);
Train_sets=[train_sample_temp(Train_labels1_index,1:end);train_sample_temp(Train_labels2_index,1:end)]';

end

