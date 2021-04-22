function [outputArg1,outputArg2] = svm_mainframework(training_set_inf,testing_set_inf,para_setting)
%SVM_MAINFRAMEWORK 此处显示有关此函数的摘要
%   此处显示详细说明
Training_sample.Instance_matrix = training_set_inf.training_sample;
Training_sample.Instance_label=training_set_inf.training_label;
Training_parameters=training_set_inf.para;
Testing_sample = testing_set_inf;


time=zeros(para_setting.cv_times,1);
ktimes=para_setting.cv_times;
for i_ktimes=1:ktimes
    tic;%记录训练时间
    for i_class1=1:(num_classes-1)
        for i_class2=(i_class1+1):num_classes
            model{i_class1,i_class2}=model_training(Training_sample,Training_parameters);
        end%class2
    end%class1
time(ktimes) = toc;


end

