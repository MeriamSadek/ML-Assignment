function centroids = CentroidCalculation(X,C,K)

[m n] = size(X);
centroids = zeros(K, n);
for k = 1 : K
	id = find(C == k);
	centroids(k,:) = sum(X(id , :)) / size(id , 1); %mean of points assigned to cluster k
end
end