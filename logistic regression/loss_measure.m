function [loss] = loss_measure(X,Y,wt)
%LOSS_MEASURE ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

N=size(X,1);%number of sample
loss=0;
t=0;%total
for i_iter=1:N
    z=log(1+exp(-Y(i_iter)*X(i_iter,:)*wt));
    t=t+z;
end
loss=t/N;

end

