N=100;%set the value of N
J=1;
beta=1;
inti_v=1*ones(1,N);%randi(2,1,N)-1;%
inti_v(inti_v==0)=-1;
for i_N=1:10000
    index_v=randperm(N,1);
    switch index_v
        case 1
            next=2;
            sum_j=inti_v(next);
        case N
            next=N-1;
            sum_j=inti_v(next);
        otherwise
            sum_j=inti_v(index_v+1)+inti_v(index_v-1);
    end
    temp_v=-1*inti_v(index_v);
    a=exp(2*temp_v*beta*J*sum_j);
    threshold=rand(1);
    if a>threshold
        inti_v(index_v)=-1*inti_v(index_v);
    end
end
energy=0;
for en=1:N-1
    temp_en=inti_v(en)*inti_v(en+1);
    energy=energy+temp_en;
end
energy=J*-1*energy;
avg_ener=energy/N;