function [ warp_im ] = warpA( im, A, out_size )
im_new = zeros(out_size(1),out_size(2));
L = A(1:2 , 1:2);
LI = inv(L);
T = A(1:2 , 3);

for i=1:out_size(1)
    for j = 1:out_size(2)
        dest = [i;j];
        reposition = LI*dest - T;
        
        ii = round(reposition(1,1));
        jj = round(reposition(2,1));
        if ii>0 && ii<size(im,1) && jj>0 && jj<size(im,2)
           im_new (i,j) = im(ii,jj);      
    
        end
    end
end
warp_im = im_new;
end