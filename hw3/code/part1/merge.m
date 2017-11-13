function [ims] = merge(img1,img2,tform1)
% http://home.deib.polimi.it/boracchi/teaching/IAS/Stitching/stitch.html

[im2t,xdataim2t,ydataim2t]=imtransform(img2,tform1);
xdataout=[min(1,xdataim2t(1)) max(size(img1,2),xdataim2t(2))];
ydataout=[min(1,ydataim2t(1)) max(size(img1,1),ydataim2t(2))];
im2t=imtransform(img2,tform1,'XData',xdataout,'YData',ydataout);
im1t=imtransform(img1,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);
ims=max(im1t,im2t);
end
