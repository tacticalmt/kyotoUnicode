function [outputArg1,outputArg2] = logit_main(data,parameters)
%LOGIT_MAIN ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
cross_vaild=5;
num_class=parameters.num_class;
index_class=parameters.index_class;
for time_cv=1: cross_vaild
    
    for i_class1=1:(num_class-1)
        for i_class2=(i_class1+1):num_class
            [Train_sets,Train_labels]=generating_train(data,data{time_cv,1}(:,end),num_class,index_class,i_class1,i_class2,time_cv);
            model{i_class1,i_class2}=logit_training(Train_sets,Train_labels,parameters);
            modelloss{time_cv}{i_class1,i_class2}=model{i_class1,i_class2};
            %w=w_para;
        end
    end
    
    disp(['validating']);
    num_classifer=nchoosek(num_class,2);
    num_training_set=size(data{time_cv,1}(:,end),1);
    num_test_sample=size(data{time_cv,2},1);
    
    %%%check training error
    vote_Tra_matrix=zeros(num_training_set,num_classifer+1);
    var_vote=2;
    for test_class1=1:(num_class-1)
        for test_class2=(test_class1+1):num_class
            predict_label=logit_testing(model{test_class1,test_class2},data{time_cv,1}(:,1:end-1),test_class1,test_class2);
            vote_Tra_matrix(:,var_vote)=predict_label;
            var_vote=var_vote+1;
        end
    end
    for i_poll=1:num_training_set
        vote_vector=vote_Tra_matrix(i_poll,2:end);
        vote_Tra_matrix(i_poll,1)=mode(vote_vector);
    end
    error_volume=find((data{time_cv,1}(:,end)-vote_Tra_matrix(:,1))~=0);
    error_number=length(error_volume);
    acc=100*(num_training_set-error_number)/num_training_set;
    disp(['accuracy on training set is ',num2str(acc)]);
    %%check test error
    vote_test_matrix=zeros(num_test_sample,num_classifer+1);
    var_vote=2;
    for test_class1=1:(num_class-1)
        for test_class2=(test_class1+1):num_class
            predict_label=logit_testing(model{test_class1,test_class2},data{time_cv,2}(:,1:end-1),test_class1,test_class2);
            vote_test_matrix(:,var_vote)=predict_label;
            var_vote=var_vote+1;
        end
    end
    for i_poll=1:num_test_sample
        vote_vector=vote_test_matrix(i_poll,2:end);
        vote_test_matrix(i_poll,1)=mode(vote_vector);
    end
    error_volume=find((data{time_cv,2}(:,end)-vote_test_matrix(:,1))~=0);
    error_number=length(error_volume);
    acc_t=100*(num_test_sample-error_number)/num_test_sample;
    disp(['accuracy of test is ',num2str(acc_t)]);
    
end
x_ax=1:1:1000;
lr=parameters.lr;
iter_des=(['iteration (LR=',num2str(lr),')']);
a=modelloss{1}{1,2}.loss';
b=modelloss{1}{1,3}.loss';
c=modelloss{1}{2,3}.loss';
plot(x_ax,a,'-*b',x_ax,b,'-or',x_ax,c,'-xy');
axis([0,25,0,20]);
set(gca,'XTick',[0:1:25]);
set(gca,'YTick',[0:1:20]) %y?�?0-700�C?�u100
legend('1v2','1v3','2v3');   %�E��p?��
xlabel(iter_des)  %x?��?�`�q
ylabel('loss') %y?��?�`�q
end

