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

Mean_X = mean(X);  % vector 18 value of each column
StandardDiv = std(X);
A = zeros(n);
product = 1;
for i = 1:n
pdf = normcdf(X(10, i), Mean_X(i), StandardDiv(i)); % 18 value
product = product * pdf;
end
if  product> 0.999 || product< 0.001
    %Anomaly
    fprint('Anomaly \n');
else  
    %Not Anomaly
    fprint('Not Anomaly \n');
end