function [rgbans] = sse(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
[m,n] = size(red);

r = 100,c = 100, szr = 100, szc = 100; 
fix = red(r:r+szr,c:c+szc);

mn = intmax;
for i = r-31 : r+31
    for j = c-31 : c+31
        subm = green(i:i+szr,j:j+szc);
        er = (fix-subm).*(fix-subm);
        tot = sum(sum(er));
        if tot < mn
            mn = tot;
            gr = i;
            gc = j;
        end
    end
end

green_new = circshift(green,[r-gr,c-gc]);


mn = intmax;
for i = r-31 : r+31
    for j = c-31 : c+31
        subm = blue(i:i+szr,j:j+szc);
        er = (fix-subm).*(fix-subm);
        tot = sum(sum(er));
        if tot < mn
            mn = tot;
            br = i;
            bc = j;
            tot = normxcorr2(fix,subm);
        end
    end
end

blue_new = circshift(blue,[r-br,c-bc]);
%fprintf('%d %d %d %d', br,bc, gr,gc)
[rgbans] = cat(3, red, green_new, blue_new);


end
