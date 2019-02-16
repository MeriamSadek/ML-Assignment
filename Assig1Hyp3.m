clc
close all
clear all
ds = tabularTextDatastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
size(T);
Alpha=.01;
;
m=length(T{:,1});
U0=T{:,2}
U=T{:,4:14};

U1=T{:,20:21};
U2=U.^2;
X=[ones(m,1) U U1 U.^2 U.^3];

n=length(X(1,:));
for w=2:n
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w)); %scaling Mean Normalization
    end
end

Y=T{:,3}/mean(T{:,3});   %price / mean
Theta=zeros(n,1);  % 1 column of zeros
k=1;

E(k)=(1/(2*m))*sum((X*Theta-Y).^2);  %cost function J

R=1;
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*X'*(X*Theta-Y);
k=k+1
E(k)=(1/(2*m))*sum((X*Theta-Y).^2);
if E(k-1)-E(k)<0
    break
end 
q=(E(k-1)-E(k))./E(k-1);
if q <.000001;
    R=0;
end
end
% for z=2:n
%     f = figure;
%     plot (X(:,z),Y,'o');
% end
plot(E);
