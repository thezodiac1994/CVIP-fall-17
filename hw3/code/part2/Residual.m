function [pt_line_dist] = Residual(F,N,matches,I1,I2,flag,inlier_threshold)

% function returns the residual error 

L = (F * [matches(:,1:2) ones(N,1)]')'; % transform points from 
% the first image to get epipolar lines in the second image

% find points on epipolar lines L closest to matches(:,3:4)
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); % rescale the line
pt_line_dist = abs(sum(L .* [matches(:,3:4) ones(N,1)],2));
closest_pt = matches(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);

% find endpoints of segment on epipolar line (for display purposes)
pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; % offset from the closest point is 10 pixels
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;
ind = find(pt_line_dist<=inlier_threshold);
ind(:)';
% display points and segments of corresponding epipolar lines

if(flag==1)
    clf;
    imshow(I2); hold on;
    plot(matches(ind(:)',3), matches(ind(:)',4), '+r');
    line([matches(ind(:)',3) closest_pt(ind(:)',1)]', [matches(ind(:)',4) closest_pt(ind(:)',2)]', 'Color', 'r');
    line([pt1(ind(:)',1) pt2(ind(:)',1)]', [pt1(ind(:)',2) pt2(ind(:)',2)]', 'Color', 'g');
end

end

