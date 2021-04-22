function [model] = per_training(training_data,training_label)
%PER_TRAINING この関数の概要をここに記述
%   詳細説明をここに記述
X = training_data;
Y = training_label;
wt=ones(size(X,1)+1,1);%列向量
%wt=rand(size(X,1)+1,1); create random initial weights
N=length(Y);%number of sample
training_iteration=0;
D=[ones(N,1) X'];
flag=0;
while flag==0 && training_iteration<=1000  %because iris is not linearly separateable
    Nw=randperm(N);%give random order to samples
    tra_s=0;    %  遍?数据集 n th sample being checked
    tra_e=0;    %  1 if there is sample having to train, 0 otherwise
    while tra_s<N && tra_e==0
        cur_sam=Nw(tra_s+1);
        if sign(D(cur_sam,:)*wt)~=Y(cur_sam)
            tra_e=1;
            t_ind=cur_sam;
        end
        tra_s=tra_s+1;
    end
    if tra_e==0
        flag=1;
    else
        wt=wt+Y(t_ind)*D(t_ind,:)';  %update weigtht
        training_iteration=training_iteration+1;
    end
end
model.wt=wt;
model.training_iter=training_iteration;
end

