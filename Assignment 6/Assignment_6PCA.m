close all;
clear all;
clc

ds = tabularTextDatastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
size(T);

m=length(T{:,1}); % #of samples

U1=T{:,4:21};
X=[U1];
Y = T{:, 3};
n=length(X(1,:)); % #of features

%feature normalization
Mean_X = mean(X);
X_Normlized = bsxfun(@minus, X, Mean_X);
standardDiv = std(X_Normlized);
X_Normlized = bsxfun(@rdivide, X_Normlized, standardDiv);

%Corr_x = corr(x);
% best corr Matrix is when corr (x) = I

%covariance Matrix
%sigma = 1/m * X' * X;
x_cov=cov(X); 

%U eigen vectors
%S eigen values
[U S V] =  svd(x_cov);

% calculate K
l=length(diag(S));
alpha = 0.01;
S_diag = diag(S);
for K = 1:l
    alpha = 1 - sum(S_diag(:,1:K))/ sum(diag(S));
    if alpha <0.001
        break;
    end
end

%transformed data
U_reduced = U(:,1:K);
Z= U_reduced' .* X;

%approximate data 
X_approximate = Z * U_reduced;

%Error estimated
error = 1/m *(sum((X - X_approximate).^2));

% Linear regression 
alpha = 0.01;
numOfitrations= 100;
[m, n] = size (X_approximate);
theta = zeros(n,1);
[theta, J] = GradientDescent(X_approximate, Y, theta, alpha,numOfitrations);

