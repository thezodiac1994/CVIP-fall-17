function H = homography(a, b, n)
% F = getF8pt( a, b )
% retrieve F from the first 8 points of a and b
size(a);
size(b);
%[img1pts,T1] = normalize( a(1:8,:) );
%[img2pts,T2] = normalize( b(1:8,:) );
%x  = img1pts(:,1);
%y  = img1pts(:,2);
%xp = img2pts(:,1);
%yp = img2pts(:,2);
x = a(:,1);
y = a(:,2);
x1 = b(:,1);
y1 = b(:,2);

A = zeros(2*n,9);
for i = 1:n
    A(2*i-1,:) = [x(i),y(i),1,0,0,0,-x1(i)*x(i),-x1(i)*y(i),-x1(i)];
    A(2*i,:) = [0,0,0,x(i),y(i),1,-y1(i)*x(i),-y1(i)*y(i),-y1(i)];
end
if (n<4)
    H = null(A);
else
    [~,~,H] = svd(A);
    H = H(:,9);
end
   % size(H)
H = reshape(H,3,3);
end