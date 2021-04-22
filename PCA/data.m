A=rand(3,3);
B=A*A';
C=B+B';

mu=[3,10,2];
sigma=C;
data_pca=mvnrnd(mu,sigma,200);

data_E=mean(data_pca,1);
central_d=data_pca-data_E;
covar_data=central_d'*central_d
[U_1,S_1,V_1]=svd(covar_data)
%figure(3);
%plot(data_pca(:,1),data_pca(:,2),data_pca(:,3),'k*')
%plot3(data_pca(:,1),data_pca(:,2),data_pca(:,3),'r.','MarkerSize',13)
scatter3(data_pca(:,1),data_pca(:,2),data_pca(:,3),'.','r') 
new_ax=central_d*U_1(:,1);
new_ay=central_d*U_1(:,2);
figure(2)
plot(new_ax,new_ay,'k*');
figure(3)
plot(central_d(:,1),central_d(:,2),'k*');