function [] = visualize(T, Centers)
    figure;  hold on; 
    axis equal;
    plot3(-Centers(1,1), Centers(1,2), Centers(1,3),'ob'); % plot centers 1 
    plot3(-Centers(2,1), Centers(2,2), Centers(2,3),'og'); % plot centers 2 
    plot3(-T(:,1), T(:,2), T(:,3), '+r'); % plot points 
end