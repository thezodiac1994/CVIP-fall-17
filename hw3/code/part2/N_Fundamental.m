function [ F_matrix ] = N_fundamental(a,b)
% Normalized Fundamental Matrix function
[b1,Nb] = normalize(a);
[a1,Na] = normalize(b);
X = a1 .* repmat(b1(:,1), [1,3]);
Y = a1 .* repmat(b1(:,2), [1,3]);
A = [X Y a1];

[U,S,V] = svd(A);
f = V(:,end);
F = reshape(f, [3,3])';

[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V';

F_matrix = Nb' * F * Na;


end