function [model] = logit_traing(train_sample,train_label,para)
%LOGIT_TRAING この関数の概要をここに記述
%   詳細説明をここに記述
X=train_sample;
Y=train_label;
max_times=para.max_time;
%wt=rand(size(X,1)+1,1);%generate a random initial
wt=ones(size(X,1)+1,1);%generate all 1 weights for initial
N=length(Y);
D=[ones(N,1) X'];
loss=zeros(max_times,1);
for i_train=1:max_times
    grad_wt=grad(D,Y,N,wt);
    wt=wt-para.lr*grad_wt; 
    loss(i_train)=loss_measure(D,Y,wt);
    if loss==0
    break;
    end
end



model.wt=wt;
model.loss=loss;

end

