% This is a MATLAB script for the 
% CLPS1520 lecture on color images 

% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% Author: Thomas Serre 
% Data source: Images can be downloaded at
% Brown University
% CLPS Department
% email: Thomas_Serre@Brown.edu
% Website: http://serre-lab.clps.brown.edu
% February 2014; 

%%
% Load the image in the ../Data folder named 'Landscape-image.jpg'
% the image is then stored in a variable called img
% Look at the help for the 'imread' function

img = imread('../Data/Landscape-image.jpg');


%% Display the image on screen
imagesc(img); axis image; axis off;
% you should also check out the help for imshow and image


%% Convert images to gray values
gray_img = rgb2gray(img);
imagesc(gray_img); axis image; axis off; colormap gray;
colorbar;

%%
% let's do a little arithmetic using images
boat1 = imread('../Data/boat1.jpg');
boat2 = imread('../Data/boat2.jpg');

% let's resize boat2 so that it is the same size as boat1
[h, w, n] = size(boat1);
boat2  = imresize(boat2, [h w]);

% let's convert images to double
boat1 = double(boat1)/255;
boat2 = double(boat2)/255;

% sum between images
img  = (boat1+boat2)/2;

figure(1)
imagesc(boat1);  axis image; axis off;
figure(2)
imagesc(boat2);  axis image; axis off;
figure(3)
imagesc(img); axis image; axis off;

%% product of scalar between image and scalara    = 1;
img  = gray_img*1;


figure(3)
imshow(img);  axis image; axis off; colormap gray; colorbar;

%% weighted sum between images
a = .8;
img  = (1-a)*boat1+a*boat2;

figure(1)
imagesc(boat1);  axis image; axis off;
figure(2)
imagesc(boat2);  axis image; axis off;
figure(3)
imagesc(img); axis image; axis off;



%% Color images: RGB channels
img = imread('../Data/speelgoed.tif');
close all

R = squeeze(img(:,:,1));
G = squeeze(img(:,:,2));
B = squeeze(img(:,:,3));

figure(1)
imagesc(R, [0 255]);  axis image; axis off; colormap gray; title('R channel'); colorbar;
figure(2)
imagesc(G, [0 255]);  axis image; axis off; colormap gray; title('G channel'); colorbar;
figure(3)
imagesc(B, [0 255]); axis image; axis off; colormap gray; title('B channel'); colorbar;
figure(4)
imagesc(img); axis image; axis off; 

%% swap colors
swap_img = cat(3, B, R, G);
close all
figure(1)
imagesc(img); axis image; axis off; 
figure(2)
imagesc(swap_img); axis image; axis off; 


%% Use a for loop to do the color swap on all jpeg images in the directory
d    = dir('../Data/*.jpg'); % the dir command retruns an M-by-1 structure with 
                     % the filename of the files contained in the 'name' field.
                     % d(1).name returns the nam?e of the first file etc
                     % filenames are organized in alphanumerical order
       
nImg = length(d); % 'length' is like the 'size' command but for vectors

for ii = 1:nImg
    img = imread(d(ii).name);
    
    
    R = squeeze(img(:,:,1));
    G = squeeze(img(:,:,2));
    B = squeeze(img(:,:,3));
   
    % swap colors
    swap_img = cat(3, G, B, R);
    figure(1)
    imagesc(img); axis image; axis off;
    figure(2)
    imagesc(swap_img); axis image; axis off;
    pause; % the pause command expects a keyboard input for the program to resume
end

