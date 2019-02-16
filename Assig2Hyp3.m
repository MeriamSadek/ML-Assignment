clc
close all
clear all
ds = tabularTextDatastore('heart_DD.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
size(T);
Alpha=.01;
;
m=length(T{:,1});
U0=T{:,2}
U=T{:,3:8};

U1=T{:,12:13};
U2=U.^2;
X=[ones(m,1) U U1 U1.^2];

n=length(X(1,:));
for w=2:n
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w)); %scaling Mean Normalization
    end
end

Y=T{:,14}/mean(T{:,14});   %price / mean
Theta=zeros(n,1);  % 1 column of zeros
k=1;
H = 1./(1+exp(-X*Theta));
E(k)=-(1/m)*sum(Y.*log(H) + (1-Y).*log(1-H));  %cost function J

R=1;
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*X'*(H-Y);
k=k+1
E(k)=(1/m).*sum(-Y.*log10(H)- (1-Y).*log10(1-H));
if E(k-1)-E(k)<0
    break
end 
q=(E(k-1)-E(k))./E(k-1);
if q <.000001;
    R=0;
end
end

%plot (X(:,3),Y);
plot(E);
