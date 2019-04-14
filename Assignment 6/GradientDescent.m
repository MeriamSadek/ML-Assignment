function [theta, J] = GradientDescent(X_approximate, Y, theta, alpha,numOfitrations)

 m = length(Y);
 n = size(X_approximate , 2);
 J = zeros(numOfitrations, 1);
 for i = 1:numOfitrations
     H= X_approximate * theta;
     T = zeros(n,1);
     for j = 1:m
         T = T + (H(j) - Y(j)) * X_approximate(j,:);
     end
     theta = theta - (alpha * T) / m;
     J(i) = sum ((X_approximate * theta - Y).^2) / (2*m);
 end