function [model] = LS_training(train_sample,train_label)
%LS_TRAINING この関数の概要をここに記述
%   詳細説明をここに記述
X=train_sample;
Y=train_label;
wt=zeros(size(X,1)+1,1);
N=length(Y);
D=[ones(N,1) X'];
wt=((D'*D)^-1)*D'*Y;
model.wt=wt;
end

