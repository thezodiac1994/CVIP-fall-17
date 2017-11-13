function [ans] = nms(response,window)
   nmsresponse = cell(size(response,1),1);
   
   for i = 1:size(response,1)
      % nmsresponse{i,1} = colfilt(response{i,1},window,'sliding',@max); % get colfilt response across each scale
       nmsresponse{i,1} = ordfilt2(response{i,1},window(1,1) * window(1,2),ones(window(1,1) , window(1,2)));
      % nmsresponse{i,1} = nlfilter(response{i,1},window,'max(x(:))');
   end
   %both ordfilt2 and colfilt took almost the same time 
   
   nmsmax = max(cat(3,nmsresponse{:,:}),[],3); %maximum of each pixel across all nms responses 
   
   for i = 1:size(response,1)
       bitmask = (nmsmax==response{i,1}); % comparing nmsmax with each filter response to get bitmask set as
       % 1 on maximum positions across all scales and 0 on other positions
       ans{i,1} = response{i,1}.*bitmask;  % multiplying by bitmasks 
   end
   
end