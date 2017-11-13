function [ F ] = Fundamental(matches)
    % Fundamental Matrix -> unnormalized 
    x1 = matches(:,1);
    y1 = matches(:,2);
    x2 = matches(:,3);
    y2 = matches(:,4);
    temp = [ x1.*x2, x1.*y2, x1, y1.*x2, y1.*y2, y1, x2, y2, ones(size(matches,1), 1)];
    [~,~,V] = svd(temp);
    X = V(:,9);
    F = reshape(X, 3,3)'; 
    [U, S, V] = svd(F);
    S(end) = 0;
    F = U*S*V';
end