function x = number_plate_det(hObject, eventdata, handles)
load imgfildata;
load('data.mat','frame')
picture=frame;
picture = picture+20;
try
    %picture = inputanh(picture)
    %picture = angle(picture)
catch e
end
axes(handles.axes3);
imagesc(picture);
axis off;
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

picture2=picture-picture1;

picture2=bwareaopen(picture2,200);

imcr = imcrop(picture2,[0 0 500 150]);
[Lcr,Necr]=bwlabel(imcr);
idx=1; % bien dem de gan anh vao axes
if Necr<9  
    imcr1 = imcrop(picture2,[0 0 500 150]);
    imcr2 = imcrop(picture2,[0 151 500 300]);
    final_output=[];
    t=[];
    %----------NHAN DIEN HANG TREN BIEN SO-----------
    [Lcr,Necr]=bwlabel(imcr1);
    propied=regionprops(Lcr,'BoundingBox');
    hold on
    pause(1);
    %{
    for n=1:size(propied,1)
        rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    end
    %}
    for n=1:Necr
      [r,c] = find(Lcr==n);
      n1=picture(min(r):max(r),min(c):max(c));
      [x y] = size(n1)
      if x < 42 
          continue
      end
      n1=imresize(n1,[42,24]);
      %imshow(n1)
      %pause(0.2)
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
        n1 = imresize(n1,[200 100])
        switch idx
            case 1
                axes(handles.tren1);
                imagesc(n1);
                
                axis off;
            case 2
                axes(handles.tren2);
                imagesc(n1);
                axis off;
            case 3
                 axes(handles.tren3);
                imagesc(n1);
                axis off;
            case 4
                axes(handles.tren4);
                imagesc(n1);
                axis off;
                
        end
        idx = idx+1;
        final_output=[final_output out];
      end
    end
    hold off
    %----------NHAN DIEN HANG TREN BIEN SO-----------
    final_output=[final_output '-']
    idx  = 1;
    %----------NHAN DIEN HANG DUOI BIEN SO-----------
    [Lcr,Necr]=bwlabel(imcr2);
    propied=regionprops(Lcr,'BoundingBox');
    hold on
    pause(1)
    %{
    for n=1:size(propied,1)
      rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    end
    %}
    for n=1:Necr
      [r,c] = find(Lcr==n);
      n1=imcr2(min(r):max(r),min(c):max(c));
      [x y] = size(n1)
      if x < 42 
          continue
      end
      n1=imresize(n1,[42,24]);
      %imshow(n1)
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
        n1 = imresize(n1,[200 100])
        switch idx
            case 1
                axes(handles.duoi1);
                imagesc(n1);
                axis off;
            case 2
                axes(handles.duoi2);
                imagesc(n1);
                axis off;
            case 3
                 axes(handles.duoi3);
                imagesc(n1);
                axis off;
            case 4
                axes(handles.duoi4);
                imagesc(n1);
                axis off;
            case 5
                axes(handles.duoi5);
                imagesc(n1);
                axis off;
                
        end
        final_output=[final_output out];
        idx = idx+1;
      end
    end
    hold off
    set(handles.finalOutput,'string',final_output)
    %------------------VIET VAO FILE EXCEL--------------
    filename = 'data.xlsx';
    data = readtable(filename)
    [row col] = size(data)
    STT=row+1;
    NGAY = datestr(datetime("today"));
    NGAY = string(NGAY);
    [h,m,s] = hms(datetime("now"));
    if h<10
        h ="0"+ num2str(h);
    end
    if m<10
        m ="0"+ num2str(m);
    end
    if s<10
        s ="0"+ num2str(floor(s));
    end
    h = num2str(h);
    m = num2str(m);
    s = num2str(floor(s));
    GIO = strcat(h,":",m,":",s);
    BIENSOXE = string(final_output);
    tmp = table(STT,NGAY,GIO,BIENSOXE);
    data = [data;tmp];
    writetable(data,filename);
    %------------------VIET VAO FILE EXCEL--------------
    msgbox('Nhan dien anh thanh cong!','SS')
    %----------NHAN DIEN HANG DUOI BIEN SO-----------
else
    [L,Ne]=bwlabel(picture2);
    propied=regionprops(L,'BoundingBox');
    hold on
    pause(1)
    %{
    for n=1:size(propied,1)
      rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    end
    %}
    hold off
    final_output=[];
    t=[];
    for n=1:Ne
        [r,c] = find(L==n);
        n1=picture(min(r):max(r),min(c):max(c));
        [x y] = size(n1)
        if x < 42
            continue
        end
        n1=imresize(n1,[42,24]);
        %imshow(n1)
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
            n1 = imresize(n1,[200 100])
            switch idx
            case 1
                axes(handles.tren1);
                imagesc(n1);
                axis off;
            case 2
                axes(handles.tren2);
                imagesc(n1);
                axis off;
            case 3
                 axes(handles.tren3);
                imagesc(n1);
                axis off;
            case 4
                axes(handles.duoi1);
                imagesc(n1);
                axis off;
            case 5
                axes(handles.duoi2);
                imagesc(n1);
                axis off;
            case 6
                axes(handles.duoi3);
                imagesc(n1);
                axis off;
            case 7
                axes(handles.duoi4);
                imagesc(n1);
                axis off;
            case 8
                axes(handles.duoi5);
                imagesc(n1);
                axis off;
            end
            final_output=[final_output out];
            if idx == 3
                final_output=[final_output '-'];
            end
            idx = idx+1;
        end
    end
    set(handles.finalOutput,'string',final_output)    
    %------------------VIET KET QUA--------------
    %------------------VIET KET QUA--------------
    
    %------------------VIET VAO FILE EXCEL--------------
    filename = 'data.xlsx';
    data = readtable(filename)
    [row col] = size(data)
    STT=row+1;
    NGAY = datestr(datetime("today"));
    NGAY = string(NGAY);
    [h,m,s] = hms(datetime("now"));
    if h<10
        h ="0"+ num2str(h);
    end
    if m<10
        m ="0"+ num2str(m);
    end
    if s<10
        s ="0"+ num2str(floor(s));
    end
    h = num2str(h);
    m = num2str(m);
    s = num2str(floor(s));
    GIO = strcat(h,":",m,":",s);
    BIENSOXE = string(final_output);
    tmp = table(STT,NGAY,GIO,BIENSOXE);
    data = [data;tmp];
    writetable(data,filename);
    disp('viet vao file thanh cong')    
    %------------------VIET VAO FILE EXCEL--------------
    msgbox('Nhan dien anh thanh cong!','SS')
end

end
%-----------------GHI THÔNG TIN VÀO FILE-----------------

%{
file = fopen('number_Plate.txt', 'wt');
    fprintf(file,'%s\n',final_output);
    fclose(file);                     
    winopen('number_Plate.txt')
%}