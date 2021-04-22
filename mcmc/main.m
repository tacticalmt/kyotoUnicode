%init
paratarget.rho_target=0.6;
paratarget.mean_target=[3 4]';
paratarget.sigma_target=[1 1]';
x_target=3;
y_target=4;
p=gauss(x_target,y_target,paratarget);
display(['p is ' , num2str(p)]);

proposl_para.rho_target=0;
mean_proposl=[-10 -3];
proposl_para.mean_target=mean_proposl;
proposal_sigma=[1 0;0 1];
sigma_p=[1 1]';
proposl_para.sigma_target=sigma_p;
sample_times=10000;
p_stat=zeros(sample_times,2);%采?次数个状?，?个状?2?
p_stat(1,:)=mean_proposl;
proposl_cur=proposl_para;
proposl_next=proposl_para;
for i_sample=1:sample_times
    p_stat(i_sample+1,:)=mvnrnd(p_stat(i_sample,:),proposal_sigma,1)';
    proposl_cur.mean_target=p_stat(i_sample,:);
    proposl_next.mean_target=p_stat(i_sample+1,:)';
    q_next=gauss(p_stat(i_sample+1,1),p_stat(i_sample+1,2),proposl_cur);%更新率
    q_cur=gauss(p_stat(i_sample,1),p_stat(i_sample,2),proposl_next);%%??个量更新有??
    p_next=gauss(p_stat(i_sample+1,1),p_stat(i_sample+1,2),paratarget);%更新有??，没同?
    p_cur=gauss(p_stat(i_sample,1),p_stat(i_sample,2),paratarget);
    p_next_to_cur=q_cur*p_next;%%%
    p_cur_to_next=q_next*p_cur;%
    alpha=min(1,(p_next_to_cur/(p_cur_to_next)));
    U_norm=rand(1,1);
    if U_norm<=alpha
        %plot(p_stat(i_sample,1),p_stat(i_sample,2),'k*');
        continue;
    else
        p_stat(i_sample+1,:)=p_stat(i_sample,:);
        
        %plot(p_stat(i_sample,1),p_stat(i_sample,2),'k*');
    end
    
end
plot(p_stat(:,1),p_stat(:,2),'k*');
