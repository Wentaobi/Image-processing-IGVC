% wen
%image test
%% load image
close all;
clear;
clc;
%%
q=imread('FrameB105.jpg');
%q=q+20;
figure
imshow(q)%1
 %% rgb
q1=q(:,:,1);
figure;
imshow(q1)%2
q2=q(:,:,2);
figure;
imshow(q2)%3
q3=q(:,:,3);
figure
imshow(q3)%4
double_img=im2double(q);
%% do some math
img=(2*double_img(:,:,3)-0.5*double_img(:,:,2)-0.5*double_img(:,:,1))*10;
%img=3*double_img(:,:,3)-2*double_img(:,:,2); %-0.5*double_img(:,:,1))*10;
figure
imshow(img)%5
% im2bw
level=0.5;
BW = im2bw(img, level);
figure
imshow(BW)%6
%% med filter
mask=medfilt2(BW);
figure
imshow(mask)%7
%% check grayscale range
avg=mean(mean(mask));%0.5136-50,0.3487-100
if mask<0.4 
     mask(1:123,:)=0;
     mask(246:384,185:336)=0;
     mask(:,512:516)=0;
else 
     mask(1:130,:)=0;
     mask(220:400,170:350)=0;
     mask(:,512:516)=0;
end
%BW = edge(mask,'sobel');
figure
imshow(mask)%8
% close operation
seline0290=strel('rectangle',[120 2]);
seline0500=strel('line',10,135);%close
BW=imclose(mask,seline0500);
figure
imshow(BW)
a = bwconncomp(BW,8);
%% pick up lane 
stats=regionprops(a,'Area');
index=find([stats.Area]>500);
wen=ismember(labelmatrix(a),index);
figure
imshow(wen)
 