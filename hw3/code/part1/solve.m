function[CX,CY,R] = solve (n,k,first,threshold,type,img)
% BLOB DETECTION FROM HW 2
response = cell(n,1); %stores filter responses  
downscale = cell(n,1);  % stores downscaled images 
scale = zeros(n,1); %stores all the scales accross which we are going to be working 
scale(1,1) = first; %initialization of 1st scale

 
for i = 2:n
    scale(i,1) = scale(i-1,1)*k; % multiply last scale by a factor of k
end

switch type
    case 1 % filter upscaling
        
        for i = 1:n 
            filter = fspecial('log',2 * ceil (3*scale(i,1) + 1),scale(i,1)); %generate LOG filter 
            filter = filter.*(scale(i,1)*scale(i,1)); % scale normalization 
            response{i,1} = imfilter(img,filter,'replicate'); % padding 
            response{i,1} = response {i,1}.*response{i,1}; % square filter response as we also get -ve values
        end
        
        
    case 2
        
        downscale{1,1} = imresize(img,1/scale(1,1));
        for i = 2:n
             downscale{i,1} = imresize(downscale{i-1,1},1/k);
             %downscale{i,1} = imresize(img,1/scale{i,1});
        end
        for i = 1:n 
            filter = fspecial('log',2 * ceil (3*scale(1,1) + 1),scale(1,1)); %constant filter <-> 1st one used 
            response{i,1} = imfilter(downscale{i,1},filter,'replicate'); % padding
            response{i,1} = imresize(response{i,1},size(img),'bicubic'); %bicubic interpolation gives accurate blobs and is fastest
            response{i,1} = response {i,1}.*response{i,1}; %square filter response 
            
        end
         
end
        
%nms
nmsresponse = nms(response,[5 5]); 

% Find elements with value more than threshold once 
[newImg,rads] = max(cat(3,nmsresponse{:,:}),[],3); % we get max pixel intensity across all scales in 
% newImg and radius is the scale number in which this max intesnity pixel is present
indices = find(newImg>threshold);  %find positions where intensity > threshold
[CX, CY] = ind2sub(size(newImg), indices); % CX CY

%radius
R = zeros(size(CX,1),1);
for i = 1:size(CX)
      R(i) = rads(CX(i),CY(i))  * sqrt(2);
end 
%figure, imagesc(newImg)
%figure, show_all_circles(img,CY,CX,R,'r',1.25);
end