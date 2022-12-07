clc
close all;
clear;
load imgfildata;
[img,cmap] = imread('C:\Users\Admin\Videos\HK1_NAM4\XULYANH\Bien_so_xe\81H1_09005.jpg')
y=inputanh(img);
y=angle(y);
[im1, im2]=tach1(y);
x = [];t = [];
final_output=[];
%----------testting-----------
%{
[L,Ne]=bwlabel(im1);
[L2,Ne2]=bwlabel(im2);
propied=regionprops(L,'BoundingBox');
hold on
pause(1)
for n=1:size(propied,1)
  rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off
for n=1:Ne
  [r,c] = find(L==n);
  n1=picture(min(r):max(r),min(c):max(c));
  n1=imresize(n1,[42,24]);
  imshow(n1)
  pause(0.2)
  x=[ ];
  
totalLetters=size(imgfile,2);
 for k=1:totalLetters
    
    y=corr2(imgfile{1,k},n1);
    x=[x y];
    
 end
 t=[t max(x)];
 if max(x)>.40
 z=find(x==max(x));
 out=cell2mat(imgfile(2,z));

final_output=[final_output out];
end
end
%}
%-----------testing-----------
for n=1:length(im1)
    im1{n} = imresize(im1{n},[42 24]);
    totalLetters=size(imgfile,2);
    imshow(im1{n});
    pause(0.5);
    disp(totalLetters)
 x=[]
 for k=1:totalLetters
    y=corr2(imgfile{1,k},im1{n});
    x=[x y];
 end
t=[t max(x)];
if max(x)>.40
    z=find(x==max(x));
    out=cell2mat(imgfile(2,z));
    final_output=[final_output out];
end
end
   