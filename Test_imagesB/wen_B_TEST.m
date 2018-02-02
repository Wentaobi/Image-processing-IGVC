close all;
clear;
clc;
I=imread('FrameB5.jpg');
%q=q+20;
figure
imshow(I)%1
  
h=fspecial('sobel'); %h = fspecial(type) creates a two-dimensional filter h of the specified type. fspecial returns h as  
                     %a correlation kernel, which is the appropriate form to use with imfilter. type is a string having one of these values.   
fd=double(I);%double使数据变成双精度  
g=sqrt(imfilter(fd,h,'replicate').^2+imfilter(fd,h','replicate').^2);  
figure;  
imshow(g);  
g2=imclose(imopen(g,ones(3,3)),ones(3,3));  
figure;  
imshow(g2);  
im=imextendedmin(g2,10);   %  
Lim=watershed(bwdist(im)); %watershed分水岭算法 Lim的值greater than or equal to 0，等于0是分水岭脊像素  
em=Lim==0;  
g3=imimposemin(g2,im|em);  
g4=watershed(g3);  
figure;  
imshow(g4);  
g5=I;  
g5(g4==0)=255;  
figure;  
imshow(g5); 


% HSV=rgb2hsv(test);
% K1 =HSV(:,:,1);% H brightness correction
% figure
% imshow(K1);
% K2 =HSV(:,:,2);% S brightness correction
% figure
% imshow(K2);
% K3 =HSV(:,:,3);% V brightness correction
% figure
% imshow(K3);
% K = imadjust(K3,[0.1 0.5],[]);%
% figure
% imshow(K);
% M=hsv2rgb(K);
% figure
% imshow(M);