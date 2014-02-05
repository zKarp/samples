%% Image enhancement.
% This is an example of image enhancment.

%% Load and display the initial image. 
% This image is B&W, not color.
clear all; close all;
imGray_uint8 = rgb2gray(imread('theImage1.png'));
figure; imshow(imGray_uint8);  title('Initial (input) image.');

%% Get the background.
% Average over a 15-pixel circle (disk) to estimate the background.
background = imopen(imGray_uint8,strel('disk',14));

% Display the Background Approximation as a Surface
figure; 
surf(double(background(1:5:end,1:5:end)));  zlim([0 255]);
set(gca,'ydir','reverse');

%%  Subtract the background image from original image.
imNormalized = imGray_uint8 - background;
figure;  imshow(imNormalized);  title('Background removed.');

%% Increase the image contrast.
%  This is done using function "imadjust".  This function works as follows:
%  "Imadjust" maps the values in the input image to new values in the output
%  image such that 1% of pixels are saturated at low and high intensities.
%  This increases the contrast of the output image vs the input.
imHighContrast = imadjust(imNormalized);

figure;  imshow(imHighContrast);  title('Contrast increased.');

%% Threshold the image so we can then identify objects.
level = graythresh(imHighContrast);
imBW = im2bw(imHighContrast,level);
figure;  imshow(imBW);  title('Thresholded image.');

%% Remove small pieces from the image.
% This removes all objects with 50 or fewer pixels.  Compare this image to
% the one generated in the previous step.
nPixels=30;
imBW = bwareaopen(imBW, nPixels);
figure;  imshow(imBW);  title('Thresholded image with small objects removed.');

%% Identify the objects in the remaining image.
%  This is done using the function "bwconncomp", which returns all
%  connected components found in the image.  The returned element,
%  "connectedComponents" is a structure with four data fields.
connectedComponents = bwconncomp(imBW, 6);

%% Let's take a look at one of the objects in the image.
grain = false(size(imBW));
grain(connectedComponents.PixelIdxList{10}) = true;
figure;  imshow(grain);  title('One of the components.');

%% Let's take a look at these components.
%  We'll do this by randomly coloring them.  ('hsv' is the colormap)
labeled = labelmatrix(connectedComponents);
RGB_label = label2rgb(labeled, 'spring', 'k', 'shuffle');
figure; imshow(RGB_label);  title('Labeled objects.');

