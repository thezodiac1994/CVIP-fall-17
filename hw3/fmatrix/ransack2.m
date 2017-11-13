function [F] = ransack2(x,xp,cnt)
x = [x ones(size(x,1),1)];
xp = [xp ones(size(x,1),1)];

%run RANSAC
N = 1000;
samplesTaken = 0;
bestResErr = Inf;
maxInliers = 0;
while samplesTaken < N
    %select samples
    samples = randperm(size(pmatches,1));
    samples = samples(1:8);
    samplesTaken = samplesTaken + 1;
   
    %compute model    
    xs = x(samples,1:2); xsp = xp(samples,1:2);
    %F = getF7pt( x(samples,1:2), xp(samples,1:2) );
    F = getF8pt( x(samples,1:2), xp(samples,1:2) );
    for i=1:size(F,3)
        %determine inliers
        L1 = normalizeLine(F(:,:,i) * x');
        dist1 = abs(dot( xp', L1 ));
        
        L2 = normalizeLine(F(:,:,i)' * xp');
        dist2 = abs(dot( L2, x' ));
        
        inliers = find( dist1 < dThresh & dist2 < dThresh );
        inlierCount = size(inliers,2);            
        if inlierCount > 0
            resErr = sum( dist1(inliers).^2 + dist2(inliers).^2 ) / inlierCount;
            %resErr = sampsonErrf( F, x(inliers,1:2), xp(inliers,1:2) );
        else
            resErr = Inf;
        end
        if inlierCount > maxInliers | ...
           (inlierCount == maxInliers & resErr < bestResErr)
            % keep best found so far
            maxInliers = inlierCount;
            bestResErr = resErr;
            bestF = F(:,:,i);
            bestInliers = inliers;            
        end
    end
    
 end        