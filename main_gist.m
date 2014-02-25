% This is a MATLAB script for the 
% CLPS1520 demo on the Gist
% Adapted from source code by Aude Oliva

% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% Author: Thomas Serre 
% Data source: Images can be downloaded at https://www.dropbox.com/sh/2pga3leyhklri20/pSAtZKoAW1
% Brown University
% CLPS Department
% email: Thomas_Serre@Brown.edu
% Website: http://serre-lab.clps.brown.edu
% February 2014; 

% This demo assumes that you already have the LabelMe toolbox
% already installed on your computer.
% A description of the toolbox is available here
% http://labelme.csail.mit.edu/LabelMeToolbox/index.html

addpath('../Lib/LabelMeToolbox')

HOMEIMAGES = '../Data';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEMO 1: calculate the GIST feature on one image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load image
img = imread(fullfile(HOMEIMAGES,'demo1.jpg'));
% img = imread(fullfile(HOMEIMAGES,'Federal_Building_Hamilton.jpg'));
% img = imread(fullfile(HOMEIMAGES,'texture2.jpg'));
% img = imread(fullfile(HOMEIMAGES,'building.jpg'));
% img = imread(fullfile(HOMEIMAGES,'ocean.jpg'));
% img = imread(fullfile(HOMEIMAGES,'opentree.jpg'));

% Parameters:
clear param
param.imageSize = 256; % size of the normalized image on which gist will be computed
param.orientationsPerScale = [8 8 8 8]; % default is [8 8 8 8], from High to Low
param.numberBlocks = 8; % change for 8 and 16
param.fc_prefilt = 4; % remove LOW SF lower than 4 cycles/images for instance

% Computing gist requires 1) prefilter image, 2) filter image and collect
% output energies
[gist, param] = LMgist(img, '', param);

% Visualization
figure
subplot(121)
imshow(img)
title('Input image')
subplot(122)
showGist(gist, param)
title('Descriptor')

% showGist(gist.^3, param) % to enhance the visualization
 
return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEMO 2: gist for a database and computing similarities between images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
HOMEIMAGES = '../Data/scenes';
close all;

% build an index database (it gets all the images in a folder. If there are
% multiple folders it reads all of them recursively.)
D = LMdatabase(HOMEIMAGES,HOMEIMAGES);
param.numberBlocks = 4; % change for 8 and 16

% get gist for all images in the database (~1 sec/image)
gist = LMgist(D, HOMEIMAGES, param);

%% query using gist (sorts the images using euclidian distance between gist vectors)
gistQuery = gist(20,:); % for example, use first image and look for similar ones. CHANGE THIS!
[j, dist] = LMgistquery(gistQuery, gist);

% show retrieved images. The first image (top-left) is the query image.
%LMdbshowscenes(D(j(1:30)), HOMEIMAGES)
LMdbshowscenes(D(j(1:9)), HOMEIMAGES, [3 3]);

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEMO 3: the space of images according to gist
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Compute PCA 
N = 2; % number of pca components, for instance the two first
pc = pca(gist, N);
close all;

% Project gist in first 2 PC
gist_pca = gist*pc;

% Plot distribution of images (one dot per image)
figure
plot(gist_pca(:,1), gist_pca(:,2), '.'); % here change for pc3, or 4 etc
xlabel('1st component')
ylabel('2nd component')
title('Images organized by pca')

% Now, let's do the same, but plot the image instead of a dot
% read all images
img = zeros([64 64 3 length(D)], 'uint8'); % reduce images to 64 x 64 pixels in figure
for i = 1:length(D)
    im = LMimread(D, i, HOMEIMAGES);
    img(:,:,:,i) = imresize(im, [64 64], 'bilinear');
end
showSpaceImages(img, gist_pca(:,1), gist_pca(:,2))

