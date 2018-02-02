%% image processing test
close all;
clear;
clc;
test=imread('FrameB377.jpg');% read original image
figure 
imshow(test)
HSV=rgb2hsv(test);
K1 =HSV(:,:,1);% brightness correction
figure
imshow(K1);
K2 =HSV(:,:,2);% brightness correction
figure
imshow(K2);
K3 =HSV(:,:,3);% brightness correction
figure
imshow(K3);
K = imadjust(K3,[0.1 0.6],[]);%
figure
imshow(K);
% K = imadjust(test,[0.1 0.6],[]);% brightness correction
% figure
% imshow(K);
% M=rgb2gray(K);
% figure
% imshow(M);
% K1 = K(:,:,1);% brightness correction
% figure
% imshow(K1);
% K2 = K(:,:,2);% brightness correction
% figure
% imshow(K2);
% K3 = K(:,:,1);% brightness correction
% figure
% imshow(K3);
% img_n=3.1*uint16(K(:,:,3))-0.5*uint16(K(:,:,2))-0.5*uint16(K(:,:,1));
% img=uint8(img_n*255/max(img_n(:)));
% figure
% imshow(img)
% img=edge(img,'sobel');
% figure
% imshow(img)
 