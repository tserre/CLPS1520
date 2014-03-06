% This is a MATLAB script for the
% CLPS1520 lecture on sparse coding
% Other m-files required: sparsenet toolbox 
% available at http://redwood.berkeley.edu/bruno/sparsenet/
% MAT-files required: A matrix of images
% Author: Thomas Serre
% Brown University
% CLPS Department
% email: Thomas_Serre@Brown.edu
% Website: http://serre-lab.clps.brown.edu
% March 2014;

% should point to your sparsenet location 
% you should read sparsenet readme for compilation instructions
addpath('../Lib/sparsenet');

A = rand(64)-0.5;
A = A*diag(1./sqrt(sum(A.*A)));

% Download the set of images available with the toolbox
load ../Data/IMAGES

%% Run sparsenet; The algorithm can be started and stopped
% using ctrl c
eta = 5; % start with large eta and reduce gradually
sparsenet;

%%

figure(1); h=display_network(A,S_var); colormap gray;


for ii =1:size(X,2)
    figure(2); colormap gray;
    subplot(3,2,1), imagesc(reshape(X(:,ii), 8, 8), [-.6 .6]);
    title('original'); axis off; axis image;
    subplot(3,2,2), bar(S(:,ii));
    title('sparse coefficients');
    subplot(3,2,4), bar(A'*X(:,ii));
    title('standard feedforward coefficients');
    subplot(3,2,3), imagesc(reshape(A*S(:,ii), 8, 8), [-.6 .6]);
    title('reconstructed'); axis off; axis image
    subplot(3,2,5), imagesc(reshape(X(:,ii)-A*S(:,ii), 8, 8), [-.6 .6]);
    title('residual'); axis off; axis image
    
    pause
end

