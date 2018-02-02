% set B test
close all;
clear;
clc;
img=imread('FrameB2.jpg');
figure
imshow(img)
img=imadjust(img,[])
img=rgb2hsv(img);
figure
imshow(img)
img_h=img(:,:,1);
figure
imshow(img_h)
img_s=img(:,:,2);
figure
imshow(img_s)
img_v=img(:,:,3);
figure
imshow(img_v)
imregionalmax