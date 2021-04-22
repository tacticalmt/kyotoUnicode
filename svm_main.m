function [accuracy,outputArg2] = svm_main(X_sample,X_test,Samp_para,parameter)
%SVM_MAIN 此处显示有关此函数的摘要Samp_para为样本相关参数
%   此处显示详细说明
para = parameter;%参数传递
X_used = X_sample;%训练样本
test_sample=X_test{1,2}(:,1:end-1);%
num_test_sample=size(test_sample,1);
X_label=Samp_para.label;%类标向量
test_label=Samp_para.testlabel;
num_samples=length(X_label);
num_classes=Samp_para.numclass;%类别数
name_label=Samp_para.namelabel;%类别的标签名
time=zeros(para.cvtimes,1);
ktimes=para.cvtimes;
disp(['training...']);

for lotimes=1:ktimes
tic;%记录训练时间
for i_class1=1:(num_classes-1)
    for i_class2=(i_class1+1):num_classes
    [Train_sets,Train_labels]=generating_train(X_used,X_used{lotimes,1}(:,end),num_classes,name_label,i_class1,i_class2,lotimes);%生成两两分类用的数据集
    [model{i_class1,i_class2}.w,~,model{i_class1,i_class2}.b,~,~]=svmtraining(Train_sets,Train_labels,para.p);
    end
end
time(ktimes) = toc;

disp(['vaildating']);
num_classifiers=nchoosek(num_classes,2);
num_training_set=size(X_used{lotimes,1}(:,end),1);
vote_matrix=zeros(num_training_set,num_classifiers+1);
var_vote=2;
for test_class1=1:(num_classes-1)
    for test_class2=(test_class1+1):num_classes
        predit_label=svmtest(model{test_class1,test_class2},X_used{lotimes,1}(:,1:end-1),test_class1,test_class2);
        vote_matrix(:,var_vote)=predit_label;
        var_vote=var_vote+1;
    end %end test2
end%end test1

for i_poll=1:num_training_set
    vote_vector=vote_matrix(i_poll,2:end);
    vote_matrix(i_poll,1)=mode(vote_vector);
end%end poll
error_volume=find((X_used{lotimes,1}(:,end)-vote_matrix(:,1))~=0);
error_number=length(error_volume);
accuracy=100*(num_training_set-error_number)/num_training_set;
disp(['the accuracy of vaildating is ',num2str(accuracy)]);

disp(['testing...']);
num_classifiers=nchoosek(num_classes,2);
vote_matrix=zeros(num_test_sample,num_classifiers+1);
var_vote=2;
for test_class1=1:(num_classes-1)
    for test_class2=(test_class1+1):num_classes
        predit_label=svmtest(model{test_class1,test_class2},test_sample,test_class1,test_class2);
        vote_matrix(:,var_vote)=predit_label;
        var_vote=var_vote+1;
    end %end test2
end%end test1

for i_poll=1:num_test_sample
    vote_vector=vote_matrix(i_poll,2:end);
    vote_matrix(i_poll,1)=mode(vote_vector);
end%end poll
num_testsample=length(test_label);
error_volume=find((test_label-vote_matrix(:,1))~=0);
error_number=length(error_volume);
accuracy=100*(num_test_sample-error_number)/num_testsample;
disp(['the accuracy is ',num2str(accuracy)]);
end
end

