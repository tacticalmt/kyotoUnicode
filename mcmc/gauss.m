function [prob] = gauss(x_target,y_target,para)
%GAUSS この関数の概要をここに記述
%   詳細説明をここに記述
mean_target=para.mean_target;
sigma_target=para.sigma_target;
rho=para.rho_target;
eco=1-para.rho_target^2;
constant=(2*pi*para.sigma_target(1)*para.sigma_target(2)*eco^(0.5))^(-1);
x_compoent=((x_target-mean_target(1))/sigma_target(1))^2;
y_compoent=((y_target-mean_target(2))/sigma_target(2))^2;
distri=exp(-(2*eco)^(-1)*(x_compoent+y_compoent-2*rho*((x_target-mean_target(1))/sigma_target(1))*((y_target-mean_target(2))/sigma_target(2))));
prob=constant*distri;

end

