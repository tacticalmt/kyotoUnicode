%%initialization
dataset='UCI5cv';
data_imported=load(['..\dataset\',dataset,'.mat']);
data_set=data_imported.UCI5cv{7,2};
para.length_w=size(data_set{1,1},2)-1;%% the dimension of the data
w=ones(para.length_w+1,1);%including bais
para.num_tra_sample=size(data_set{1,1},1);%???–{
para.num_tes_sample=size(data_set{1,2},1);%number of testing sample
[para.index_class,index,~]=unique(data_set{1,1}(:,end));%index of class
para.num_class=length(para.index_class);
LS_main(data_set,para);