close all;
clear;
clc;
x=imread('FrameB2.jpg');
x = im2double(x);
x=rgb2gray(x);
clf; imshow(x)  
%%


%Next lets regenerate the lowpass filter we used earlier:

Hd = zeros(11,11);  
Hd (4:8,4:8) = ones(5,5);  
Hd = ifftshift(Hd);  
h= ifft2(Hd);  
h = real(h);  
h = fftshift(h);  
w= hamming(11);  
ww = w*w';  
h = h.*ww;  

%Now, we can either flip the response appropriately (h=rot90(h,2)) so that 
%we can use a correlation-based function like imfilter, or we can use 'imfilter' 
%with the 'conv' property added to the command line.  Of course, if our 
%filter mask is known to be symmetric, we do not need to worry about this issue.

%we can form the filtered output as
%profile on  
a=cputime
fx=imfilter(x,h); 
b=cputime
b-a
% This gives 0.02 seconds on a I7 processor (my 2012 mac)  

%or 

fx = filter2(h,x);  

%filter2 implements a convolution operation directly; it properly flips the 
%filter kernel and then calls conv2.

imshow(fx)  