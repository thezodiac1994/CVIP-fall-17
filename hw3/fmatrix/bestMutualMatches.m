function matches = bestMutualMatches( f1, f2 )
% matches = bestMutualMatches( f1, f2 )
%   Finds best mutual matches between two feature sets
%   returns a Nx2 array of match indices 

bm1 = [];
for i=1:f1.count
    if isempty(f1.matches{i})
        bm1(i) = f2.count+1; 
    else
        [val,idx] = max( f1.matches{i}(:,2) );
        idx = f1.matches{i}(idx,1);
        bm1(i) = idx;
    end
end

bm2 = [];
for i=1:f2.count
    if isempty(f2.matches{i})
        bm2(i) = -1; 
    else
        [val,idx] = max( f2.matches{i}(:,2) );
        idx = f2.matches{i}(idx,1);
        bm2(i) = idx;
    end
end
bm2(f2.count+1) = -1;

matchidx = find( bm2(bm1) == [1:f1.count]);
matches = [matchidx' bm1(matchidx)'];
