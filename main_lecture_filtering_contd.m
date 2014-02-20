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

% simple differential operator
% f = [-1; 1];

% f = fspecial('log', 10, 1);

% Gabor
% load ../Data/gb;
% f = imrotate(gb, 45);
% f = imresize(gb, 2);

% Leung-Malik filter battery
load ../Data/LMFilters;
f = F(:,:,10);
figure(3)
for ii =1:48
    subplot(8,6,ii), imagesc(F(:,:,ii)); 
    axis off; axis square; colormap gray
end

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



