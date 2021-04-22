function [w,u,b,fval,sv_num] = svmtraining(Sample_train,label_train,p)
%SVMTRAINING ������һ��һ���������÷ֿ���󿴣���������Ϊ������ ����Ȩ��w��������������ż�����u����Ŀ�꺯������С����ֵ,pΪ֧������ɸѡ����
%SVMTRAINING 
%

X = Sample_train; %an instance is in a col
Y = label_train; %labels are represented in a column 
X_with_label=X*diag(Y); %
num_sample=size(X,2);%the number of column denotes the size of instance.
e=-ones(num_sample,1);
H=X_with_label'*X_with_label;%H for quadprog
beq=0;%zeros(num_sample,1);
Aeq=Y';
lb=zeros(num_sample,1);
[u,fval]=quadprog(H,e,[],[],Aeq,beq,lb,[]);
sv_index=find(u>p);%the index of support vector 1e-6
if length(sv_index)==0
    sv_index=find(u>0);
end
sv=u(sv_index);%svΪ֧��������Ȩ��
w=X_with_label(:,sv_index)*sv;%retures the weight of classifier.
sv_num=length(sv_index);%number of support vector
sv_e=ones(sv_num,1);
b=(1/sv_num)*(Y(sv_index)'*sv_e-sv_e'*X(:,sv_index)'*w);%the bias of classifier
end

