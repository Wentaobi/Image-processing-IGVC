%% wen test
% test trial
function trial_image=wen_nayan(name)
%% Clear all
%close all;
%clear;
%clc;
%% read image
%name={'img_in0000.png'};
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
range=[350 50];% code example
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
% figure
% imshow(image_hsv_3)
%% exchange 0 and 1
mask = imcomplement(image_hsv_3);
% figure
% imshow(mask)
%% clear some small noise
mask=medfilt2(mask);
% figure
% imshow(mask)
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
index=find([stats.Area]>250);% this parameter depends on which image you deal with
BW=ismember(labelmatrix(CC),index);% check labelmatrix(CC) position in index
nayan=BW;
% complement
wen=imcomplement(BW);
% figure
% imshow(BW)
%% dilation,make some barrel together
% dilate to make some close barrels as one group
element=strel('disk',10);
dilation=imdilate(BW,element);
%nayan=dilation;
% figure
% imshow(dilation)
%% figure out how many pixels in each area again
square=regionprops(dilation,'BoundingBox');
%% mask all of barrel
% %http://www.ilovematlab.cn/thread-81572-1-1.html
% for i=1:length(square)
%     ind=square(i).BoundingBox;
%     rectangle('Position',ind(1:end),'Edgecolor','r','LineWidth',2)
% end
% close;
%% lane detection
test_img=imread(name{1});
% figure 
% imshow(test_img)
test_img=im2double(test_img);
% do some math as project 2 solutions
math_img=2*test_img(:,:,3)-test_img(:,:,2);%-test_img(:,:,1);
% figure 
% imshow(math_img)
math_imgno=math_img;
% math_img(math_img<0.8)=0;
% figure 
% imshow(math_img)
% check ramp image
math_imgno(math_imgno>0.22)=1;% 0.12
% figure 
% imshow(math_imgno)%improved
%% if ramp; else not
avg=mean(mean(math_imgno));
if (avg>0.046)%ramp image
    math_img(math_img<0.8)=0;
%     figure 
%     imshow(math_img)
else
    math_img=math_imgno;
end 
% im2bw
level=0.6;
BW = im2bw(math_img, level);
BW(1:40,:)=0;
BW(340:494,252:385)=0;% mask vehivle area
CC = bwconncomp(BW,8);
stats=regionprops(CC,'Area');
%% this parameter should be varibale
% get lane
index=find([stats.Area]>250);% this parameter depends on which image you deal with
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
% nayan=imsubtract(BW,imcomplement(wen));
% figure 
% imshow(nayan)

%  figure 
%  imshow(BW)
% Extract Hough Transform
%E16=HoughExtract(BW,4,4,1);;%HoughExtract(BW,4,4,1);
% BW = edge(BW,'sobel');
% figure 
% imshow(BW)
% se = strel('disk',5);
% %BW=imcomplement(BW);
% BW = imclose(BW,se);
clear all;
clc;
end

 


