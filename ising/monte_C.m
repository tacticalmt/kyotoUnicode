function [sample] = monte_C(J,N,beta,sample)
%MONTE_C 此处显示有关此函数的摘要
%N = number of spin
%   此处显示详细说明
index_v=randperm(N,1);
 switch index_v
        case 1
            next=2;
            sum_j=sample(next);
        case N
            next=N-1;
            sum_j=sample(next);
        otherwise
            sum_j=sample(index_v+1)+sample(index_v-1);
 end
    temp_v=-1*sample(index_v);
    a=exp(2*temp_v*beta*J*sum_j);
    threshold=rand(1);
    if a>threshold
        sample(index_v)=-1*sample(index_v);
    end
end

