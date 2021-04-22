N_v=[50,100,200];%set number of spin
beta_v=[0.25,0.5,0.75,1,2,3];
warm_up=5000; %set iteration of warming up
MC_step=10000;%set MC step(sample times)
J=1;
tanmc_value=zeros(length(N_v),length(beta_v));
tanvalue=zeros(length(N_v),length(beta_v));
for N_iter=1:length(N_v)
    N=N_v(N_iter);
    inti_v=randi(2,1,N)-1;
    inti_v(inti_v==0)=-1;
    spin_v=inti_v;
    for beta_iter=1:length(beta_v)
        beta=beta_v(beta_iter);
        for i_warm=1:warm_up
            spin_v=monte_C(J,N,beta,spin_v);
        end
        temp_energy=zeros(1,MC_step);
        for i_monte=1:MC_step
            spin_v=monte_C(J,N,beta,spin_v);
            temp_energy(i_monte)=cal_energy(J,N,spin_v);
        end
        avg_en=sum(temp_energy)/MC_step;
        tanmc_value(N_iter,beta_iter)=avg_en/N;
        tanvalue(N_iter,beta_iter)=-1*tanh(beta);

    end

end

plot(tanmc_value(1,:),'-*b')
hold on
plot(tanmc_value(2,:),'-or');
hold on
plot(tanmc_value(3,:),'-xy');
hold on
plot([0,6],[tanvalue(1,1),tanvalue(1,1)]);
hold on
plot([0,6],[tanvalue(1,2),tanvalue(1,2)]);
hold on
plot([0,6],[tanvalue(1,3),tanvalue(1,3)]);
hold on
plot([0,6],[tanvalue(1,4),tanvalue(1,4)]);
hold on
plot([0,6],[tanvalue(1,5),tanvalue(1,5)]);
hold on
plot([0,6],[tanvalue(1,6),tanvalue(1,6)]);
grid on
