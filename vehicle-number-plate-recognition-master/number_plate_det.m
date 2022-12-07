clc
close all;
clear;
load imgfildata;
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
[~,cc]=size(picture);
picture=imresize(picture,[300 500]);
if size(picture,3)==3
  picture=rgb2gray(picture);
end
picture = imadjust(picture);
threshold = graythresh(picture);
picture =~im2bw(picture,threshold);
picture = bwareaopen(picture,30);
picture1=bwareaopen(picture,7000);
%imshow(picture)
%figure,imshow(picture1)
%title('pic 1')
picture2=picture-picture1;
%figure,imshow(picture2)
%title('pic 2')
picture2=bwareaopen(picture2,200);
%figure,imshow(picture2)
%title('pic 2 edit')
imcr = imcrop(picture2,[0 0 500 150]);
[Lcr,Necr]=bwlabel(imcr);
if Necr<9  
    imcr1 = imcrop(picture2,[0 0 500 150]);
    imcr2 = imcrop(picture2,[0 151 500 300]);
    figure
    final_output=[];
    t=[];
    %----------NH?N DI?N HÀNG ?NH D??I-----------
    [Lcr,Necr]=bwlabel(imcr1);
    propied=regionprops(Lcr,'BoundingBox');
    hold on
    pause(1)
    for n=1:size(propied,1)
      rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    end
    for n=1:Necr
      [r,c] = find(Lcr==n);
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
    hold off
    %----------NH?N DI?N HÀNG ?NH TRÊN-----------
    %----------NH?N DI?N HÀNG ?NH D??I-----------
    [Lcr,Necr]=bwlabel(imcr2);
    propied=regionprops(Lcr,'BoundingBox');
    hold on
    pause(1)
    for n=1:size(propied,1)
      rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    end
    for n=1:Necr
      [r,c] = find(Lcr==n);
      n1=imcr2(min(r):max(r),min(c):max(c));
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
    hold off
    %----------NH?N DI?N HÀNG ?NH D??I-----------
else
    [L,Ne]=bwlabel(picture2);
    propied=regionprops(L,'BoundingBox');
    hold on
    pause(1)
    for n=1:size(propied,1)
      rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    end
    hold off
    figure
    final_output=[];
    t=[];
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
end
%-----------------GHI THÔNG TIN VÀO FILE-----------------

%{
file = fopen('number_Plate.txt', 'wt');
    fprintf(file,'%s\n',final_output);
    fclose(file);                     
    winopen('number_Plate.txt')
%}