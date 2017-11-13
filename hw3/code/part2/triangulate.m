function [projection1,projection2, tpoints ] = triangulate(matches,cam1,cam2)
%http://dcyoung.weebly.com/fundamental-matrix--triangulation.html

x1 = [matches(:,1:2) ones(size(matches,1))];
x2 = [matches(:,3:4) ones(size(matches,1))];

%initialize triangulation and projection points
tpoints = zeros(size(x1,1), 3);  
projection1 = zeros(size(x1,1), 2);  
projection2 = zeros(size(x1,1), 2);


for i = 1:size(x1,1)
    Cross_prod1 = [0   -x1(i,3)  x1(i,2); x1(i,3)   0   -x1(i,1); -x1(i,2)  x1(i,1)   0];
    Cross_prod2 = [0  -x2(i,3)  x2(i,2); x2(i,3)   0   -x2(i,1); -x2(i,2)  x2(i,1)   0];    
    Eqns = [ Cross_prod1*cam1; Cross_prod2*cam2 ];
    
    [~,~,V] = svd(Eqns);
    tH = V(:,end)'; %4 dim (3 dimensions + homo coord)
    tpoints(i,:) = homogenize(tH);
    
    % projection using both centers 
    projection1(i,:) = homogenize((cam1 * tH')');
    projection2(i,:) = homogenize((cam2 * tH')');
    
end

end

