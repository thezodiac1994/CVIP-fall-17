function matches = getWindowedMatches( f1, f2, offs, w, t )
% matches = getWindowedMatches( f1, f2, offs, w )
%   returns the matches to features in  f1 with f2
%   offs  -  offset of the search window 
%   w     -  width of the search window
%   t     -  threshold for similarity measure

matches = {};
compares = 0;
totalMatches = 0;
for i = 1:f1.count
    p1 = f1.pos(i,:);
    rmw1 = f1.rmw{i};    
    window = [ p1 + offs - w / 2; p1 + offs + w / 2 ];
	candidx = find(f2.pos(:,1) >= window(1,1) & ...
                   f2.pos(:,1) <= window(2,1) & ...
                   f2.pos(:,2) >= window(1,2) & ...
                   f2.pos(:,2) <= window(2,2));
	
    candidates = f2.pos( candidx, :);
	m = candidx;
	for j = 1:size(candidx)
        idx = candidx(j);
        rmw2 = f2.rmw{idx};    
        
        % check the windows to make sure that they are the same        
        if (rmw1(1) == rmw2(1) & rmw1(2) == rmw2(2) & ...
            rmw1(3) == rmw2(3) & rmw1(4) == rmw2(4) )
        %if( all(all(rmw1 == rmw2)))
            cc = dot( f1.npixels{i}(:), f2.npixels{idx}(:) );
        else
            cc = -inf;
%             rmwt = [max(rmw1(1,:), rmw2(1,:));...
%                     min(rmw1(2,:), rmw2(2,:))];
%             mw1 = 
        end
        m( j, 1 ) = idx;
        m( j, 2 ) = cc;          
	end    
    if m
        matches{i} = m(find(m(:,2) > t),:);
    else
        matches{i} = [];
    end
end	

