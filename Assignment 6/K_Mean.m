close all;
clear all;
clc

ds = tabularTextDatastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
size(T);

m=length(T{:,1}); % #of samples

X=T{:,4:21};
Y = T{:, 3};
n=length(X(1,:)); % #of features

% number of clusters
K = 5;
% choose random centroids
centroids = zeros(K, n);
J = zeros(5,18);

centroids = zeros(K, size(X, 2));
randidx = randperm(size(X , 1));
centroids = X(randidx(1 : K) ,:);

for j = 1:10
    C = ClusterIdentifying(X, centroids);
    centroids = CentroidCalculation(X,C,K);
end


