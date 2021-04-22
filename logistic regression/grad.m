function [grad_wt] = grad(X,Y,N,wt)
%GRAD_WT ‚±‚ÌŠÖ”‚ÌŠT—v‚ğ‚±‚±‚É‹Lq
%   obtain grad with respect to wt

t=zeros(size(wt,1),1);
for i_sample=1:N
    z=Y(i_sample)*X(i_sample,:)';
    q=1+exp(Y(i_sample)*X(i_sample,:)*wt);
    t=t+z/q;
end
grad_wt=-(1/N)*t;
end

