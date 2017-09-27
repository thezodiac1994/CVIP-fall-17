%%
% Read in the image
im = imread('C:\Gautam\Masters\class notes\cse 573\hw0\release\data\mug.jpg');

% Convert to grayscale
im_gray = rgb2gray(im);

% Create a figure.

figure(1);
% Subplot splits the display ( doc subplot )
subplot(221);
imshow(im);
title('original');

% Convert to double
im_gray = double(im_gray);

% Note: imshow(im_gray) will not work now,
% it assumes pixel values from 0 - 1 when double typed
im_gray = im_gray/255;

subplot(222);
imshow(im_gray);
title('grayscale');


% Define inline function to create an
% affine scaling matrix:
Scalef = @(s)([ s 0 0; 0 s 0; 0 0 1]);
% Same for translation
Transf = @(tx,ty)([1 0 tx; 0 1 ty; 0 0 1]);
% Same for rotation
Rotf = @(t)([cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1]);

% Output
out_size = [size(im, 1) size(im, 2)];

% Pick a point around which to center
cx = size(im, 2) / 2;
cy = size(im, 1) / 2;

% Hold graphics and plot a dot at the center
hold on;
plot( cx, cy, 'r+');

% Center around cx,cy, rotate it a bit and scale.
A = Transf(out_size(2) / 2, out_size(1) / 2) ...
    * Scalef(0.8) ...
    * Rotf(-30 * pi / 180) ...
    * Transf(-cx, -cy);
warp_im = warpA_check( im_gray, A, out_size );
warp_im2 = warpA( im_gray, A, out_size );
% warp_im3 = warpA_bil( im_gray, A, out_size );
%warp_im4 = LTforward( im_gray, A, out_size );
%warp_im5 = LTback( im_gray, A, out_size );

% Show
subplot(223);
imshow(warp_im); % Change to warp_im2 and warp_im3 to check and save results.
title('warped ideal');

subplot(224);
imshow(warp_im2); % Change to warp_im2 and warp_im3 to check and save results.
title('warped mine');

%subplot(3,3,5)
%imshow(warp_im4);
%title('warped LT forward');

%%subplot(3,3,6)
%imshow(warp_im5);
%title('warped LT back');

% Write a screenshot of the image
% Set figure background color
set(gcf, 'Color', [1 1 1]);
set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, 'C:\Gautam\Masters\class notes\cse 573\hw0\release\50245840\results\transformed.jpg');
