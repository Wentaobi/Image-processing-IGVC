%% wen test
% test trial
 
%% Clear all
close all;
clear;
clc;
%% read image
 name={'Frame65.jpg'};
test=imread(name{1});
% figure
%% 0-255 -> over 255 ->0-1
% imshow(test)
image=im2double(test);
% figure
% imshow(image)
%% Author:  Vctor Martnez Cagigal
%% Google from Mathworks forum
%https://www.mathworks.com/matlabcentral/fileexchange...
%/49898-image-color-filtering?focused=3863982&tab=function
range=[350 40];% code example
image_hsv=colorfilter(image, range);
%% get r g b plane,and obstacles are more
%% and more obvious from r to b
image_hsv_3=image_hsv(:,:,3);
% figure
% imshow(image_hsv_3)
image_hsv_2=image_hsv(:,:,2);
% figure
% imshow(image_hsv_2)
image_hsv_1=image_hsv(:,:,1);
% figure
% imshow(image_hsv_1)
%% using compare to make obstacles be 0 others be 1
image_hsv_3(image_hsv_3<image_hsv_1|image_hsv_3<image_hsv_2)=0;
image_hsv_3(image_hsv_3~=0)=1;
figure
imshow(image_hsv_3)
%% exchange 0 and 1
mask = imcomplement(image_hsv_3);
figure
imshow(mask)
%% clear some small noise
mask=medfilt2(mask);
figure
imshow(mask)
ele=strel('disk',1);
mask=imdilate(mask,ele);
%% contains labels for the 8-connected objects found in mask
%% which is barrel
%% Chinese blog: http://blog.csdn.net/qing101hua/article/details/45788011
%% connect 8 direction area
CC = bwconncomp(mask,8);

% http://blog.csdn.net/shaoxiaohu1/article/details/40272531
% figure out how many pixels in each area
stats=regionprops(CC,'Area');
%% find each barrel, romove small area which is noise
% delete some error area that is not barrel
index=find([stats.Area]>2000);% this parameter depends on which image you deal with
BW=ismember(labelmatrix(CC),index);% check labelmatrix(CC) position in index
nayan=BW;
% complement
wen=imcomplement(BW);
figure
imshow(BW)
%% dilation,make some barrel together
% dilate to make some close barrels as one group
%nayan=dilation;
% figure
% imshow(dilation)
% figure out how many pixels in each area again
square=regionprops(BW,'BoundingBox');
% lane detection
test_img=imread(name{1});
% figure 
% imshow(test_img)
%test_img=imadjust(test_img,[0.1,0.9],[]);
test_img=im2double(test_img);
% do some math as project 2 solutions
math_img=(3*test_img(:,:,3)-test_img(:,:,2))-1*test_img(:,:,1);
% figure 
% imshow(math_img)
math_imgno=math_img;
% math_img(math_img<0.8)=0;
figure 
imshow(math_img)
% check ramp image
math_imgno(math_imgno>0.15)=1;% 0.12
figure 
imshow(math_imgno)%improved
level=0.1;
BW = im2bw(math_img, level);
figure 
imshow(BW)
se = strel('disk',3);
BW=imdilate(BW,se);
figure 
imshow(BW)
BW(1:120,:)=0;
BW(300:388,194:385)=0;% mask vehivle area
CC = bwconncomp(BW,8);
stats=regionprops(CC,'Area');
%% this parameter should be varibale
% get lane
index=find([stats.Area]>950);% this parameter depends on which image you deal with
wen=ismember(labelmatrix(CC),index);% check labelmatrix(CC) position in index
% figure 
% imshow(wen)
% add lane and barrel 
final=imadd(wen,nayan);
figure 
imshow(final)
for i=1:length(square)
    ind=square(i).BoundingBox;
    rectangle('Position',ind(1:end),'Edgecolor','r','LineWidth',2)
end

 

 


