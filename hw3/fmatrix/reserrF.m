function err = reserrF( F, x, xp )
% err = reserrF( F, x, xp )
%   return the residual error for F and pairs of correspondence points

x(:,3) = 1;
xp(:,3) = 1;
L1 = normalizeLine(F * x');
L2 = normalizeLine(F' * xp');
dist1 = abs(dot( xp', L1 ));
dist2 = abs(dot( L2, x' ));
err = sum( dist1.^2 + dist2.^2 ) / size(x,1);
