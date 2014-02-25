% This is a MATLAB script for the 
% CLPS1520 demo on the Gist

% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
% Author: Thomas Serre 
% Brown University
% CLPS Department
% email: Thomas_Serre@Brown.edu
% Website: http://serre-lab.clps.brown.edu
% February 2014; 

% This demo assumes that you already have Sminocelli's toolbox
% already installed on your computer.
% http://www.cns.nyu.edu/~lcv/software.php

addpath('../Lib/matlabPyrTools') %% add the path to the toolbox here

% img = imread('../Data/cat.jpg');
img = imread('../Data/MonaLisaSmile.jpg');
img = imresize(rgb2gray(double(img)/255), .99);
imshow(img);

[pyr, ind] = buildSpyr(img);

showSpyr(pyr, ind)