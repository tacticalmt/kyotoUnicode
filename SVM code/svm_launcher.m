dataset_imported=load(['..\dataset\UCI5cv.mat']);
data_set=dataset_imported.UCI5cv{7,2};
implement_parameter.p=1e-6;
implement_parameter.cvtimes=5;
sample_parameter.num_sample=size(data_set{1,1},1);
Test_sample=data_set{1,2}(:,1:end-1);
sample_parameter.label=data_set{1,1}(:,end);
sample_parameter.testlabel=data_set{1,2}(:,end);
[num_class,index,~]=unique(sample_parameter.label);
sample_parameter.numclass=length(num_class);
sample_parameter.namelabel=num_class;%类标名向量
sample_parameter.label_index=index;
svm_main(data_set,data_set,sample_parameter,implement_parameter);
