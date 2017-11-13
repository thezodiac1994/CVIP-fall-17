uttower = 1; ledge = 0; pier = 0;hills = 1; % set 1 to stitch

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(uttower==1)
    rgbimg1 = imread('..\..\data\part1\uttower\left.jpg');
    rgbimg2 = imread('..\..\data\part1\uttower\right.jpg');

    stitch_ledge = part1solve(rgbimg1,rgbimg2,0.02,0.02,299);
    figure,imshow(stitch_ledge)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(ledge==1)
    rgbimg1 = imread('..\..\data\part1\ledge\1.jpg');
    rgbimg2 = imread('..\..\data\part1\ledge\2.jpg');

    stitch_1 = part1solve(rgbimg1,rgbimg2,0.01,0.001,299);
    figure,imshow(stitch_1);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(pier==1)
    rgbimg1 = imread('..\..\data\part1\pier\1.jpg');
    rgbimg2 = imread('..\..\data\part1\pier\2.jpg');

    stitch_1 = part1solve(rgbimg1,rgbimg2,0.01,0.01,399);
    figure,imshow(stitch_1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(hills==1)
    % EXTRA CREDIT
    rgbimg1 = imread('..\..\data\part1\hill\1.jpg');
    rgbimg2 = imread('..\..\data\part1\hill\2.jpg');
    rgbimg3 = imread('..\..\data\part1\hill\3.jpg');

    stitch_1 = part1solve(rgbimg1,rgbimg2,0.01,0.01,299);
    stitch_2 =  part1solve(stitch_1,rgbimg3,0.01,0.005,299);
    figure,imshow(stitch_2);
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTE : to see plotting of inliers -> goto the function part1solve and
% uncomment the show_all_circles functions
