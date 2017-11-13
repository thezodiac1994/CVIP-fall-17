function H = homography(a, b, n)
% Homography and RANSAC: https://www.youtube.com/watch?v=oT9c_LlFBqs

x = a(:,1);
y = a(:,2);
x1 = b(:,1);
y1 = b(:,2);

A = zeros(2*n,9);
for i = 1:n
    A(2*i-1,:) = [x(i),y(i),1,0,0,0,-x1(i)*x(i),-x1(i)*y(i),-x1(i)];
    A(2*i,:) = [0,0,0,x(i),y(i),1,-y1(i)*x(i),-y1(i)*y(i),-y1(i)];
end

[~,~,H] = svd(A);
H = H(:,end);
H = reshape(H,3,3);
H = H';
H(:) = H(:) / H(3,3);
end