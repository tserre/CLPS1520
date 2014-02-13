% This is a MATLAB script for the 
% CLPS1520 lab on CONVOLUTION 

% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% Author: Thomas Serre 
% Brown University
% CLPS Department
% email: Thomas_Serre@Brown.edu
% Website: http://serre-lab.clps.brown.edu
% February 2014; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% First you should download the data at                   %%
% https://www.dropbox.com/sh/2pga3leyhklri20/pSAtZKoAW1   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all

method = 'conv2';

img = imread('../Data/soccer.jpg');
img = double(img);
% If color image, convert to greyscale
if size(img,3) > 1
    img = rgb2gray(img/255);
end

figure(1)
imshow(img)

% interactively
[sub_img,rect_img] = imcrop(img); % choose the pepper below the img
h = size(sub_img, 1);
w = size(sub_img, 2);


% display sub images
figure(2), imshow(sub_img); axis image;

switch method
    case 'normxcorr2'
        c = normxcorr2(sub_img, img);
        
        %crop c to make it the same size as the original image
        c = imcrop(c, [floor(w/2)+1 floor(h/2)+1 size(img,2)-1 size(img,1)-1]);
       
      
    case 'imfilter'
       c = imfilter(img, sub_img, 'symmetric','same');
        
    case 'conv2'
        c = conv2(img, rot90(sub_img,2),'same');

        
end

figure(3), imagesc(c/max(c(:))); axis image; colormap hot; colorbar;

        
% Show results using alpha-mask / assuming result image is same
% size as original image
green = cat(3, zeros(size(c)), ones(size(c)), zeros(size(c)));
figure(1)
hold on
h = imshow(green);
hold off

X = 0.50;
s = sort(c(:));
set(h, 'AlphaData', c>s(round(length(c(:)).*X))); %% display top X% responses

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MORE FILTERING EXAMPLES                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

% Read image (and convert to double)
img = imresize(double(imread('../Data/Federal_Building_Hamilton.jpg')),.5);
% If color image, convert to greyscale
if size(img,3) > 1
    img = rgb2gray(img/255);
end
 
%  Change the following lines to experiment with different filters
% 'average'   averaging filter
% 'disk'      circular averaging filter
% 'gaussian'  Gaussian lowpass filter
% 'laplacian' filter approximating the 2-D Laplacian operator
% 'log'       Laplacian of Gaussian filter
% 'motion'    motion filter
% 'prewitt'   Prewitt horizontal edge-emphasizing filter
% 'sobel'     Sobel horizontal edge-emphasizing filter

f = fspecial('laplacian', .5);

% f = [-1; 1];

% Filter the image
newImg = imfilter(img, f, 'conv');

figure(1)
subplot(1,2,1)
imagesc(img);
axis('off'); axis('equal'); axis('tight'); colormap(gray)
title('original image')

subplot(1,2,2)
imagesc(newImg);
axis('off'); axis('equal'); axis('tight'); colormap(gray)
title('filtered image'); colormap gray;

figure(2)
imagesc(f);
axis('off'); colormap(gray)
title('filter')

