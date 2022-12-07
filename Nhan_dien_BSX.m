function varargout = Nhan_dien_BSX(varargin)


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Nhan_dien_BSX_OpeningFcn, ...
                   'gui_OutputFcn',  @Nhan_dien_BSX_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Nhan_dien_BSX is made visible.
%
%-------------HAM KHOI TAO
function Nhan_dien_BSX_OpeningFcn(hObject, ~, handles, varargin)
axis off;
movegui(gcf,'center');
filename = "data.xlsx";
data = readExcel(filename);
set(handles.resultTable,"Data",data);
handles.output = hObject;
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = Nhan_dien_BSX_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
close
run testguide



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
choice = questdlg('Thoat chuong trinh?',...
    'warning dialog',...,
    'Co','Khong','Co');
switch choice
    case 'Co'
        try
            f = rmfield(load('data.mat'),'flagChoose');
            save('data.mat','-struct','f')
            f = rmfield(load('data.mat'),'frame');
            save('data.mat','-struct','f')
        catch
        end
        close
    case 'Khong'
end        


% --- Executes on button press in browseImage.
function browseImage_Callback(hObject, eventdata, handles)
try
    [filename,filepath] = uigetfile({'*.*';'*.jpg';'*.png';'*.bmp'},...
    'Search image to display');
    %[file,path] = uigetfile({'*.m';'*.slx';'*.mat';'*.*'},...
     %                         'File Selector');
     flagChoose = 1;
     save('data.mat','-append','flagChoose')
    %merge to full image path
    fullname = [filepath filename];
    %read that image
    global fullPath
    fullPath = fullname;
    %save('data.mat','-append','fullPath')
    frame = imread(fullname);
    save('data.mat','-append','frame')
    %display image
    cla(handles.axes1,'reset')
    set(handles.axes1,'XTick',[], 'YTick', [])
    axes(handles.axes1);
    imagesc(frame);
    axis off;
catch e
    disp(e)
    msgbox("Khong the chon anh tu thu vien!!","Error")
end

% --- Executes on button press in openCamera.
function openCamera_Callback(hObject, eventdata, handles)
global vid;
try 
    flagChoose = 0;
    save data.mat flagChoose
    %axes1 = findobj(0, 'tag', 'axes1');
    axes(handles.axes1);
    vid = videoinput('winvideo',1);
    %set(axes1, 'string', vid);
    %a = webcam();
    %frame = snapshot(a);
    frame = getsnapshot(vid);
    himage = image(zeros(size(frame),'uint8'),'parent',handles.axes1);
    preview(vid,himage);
catch e
    disp(e)
    msgbox("Khong the mo camera","Error")
end




% --- Executes on button press in btnRun.
function btnRun_Callback(hObject, eventdata, handles)
cla(handles.tren1,'reset');cla(handles.tren2,'reset');cla(handles.tren3,'reset');cla(handles.tren4,'reset')
cla(handles.duoi1,'reset');cla(handles.duoi2,'reset');cla(handles.duoi3,'reset');cla(handles.duoi4,'reset');
cla(handles.duoi5,'reset');
set(handles.tren1,'XTick',[], 'YTick', []);set(handles.tren2,'XTick',[], 'YTick', [])
set(handles.tren3,'XTick',[], 'YTick', []);set(handles.tren4,'XTick',[], 'YTick', [])
set(handles.duoi1,'XTick',[], 'YTick', []);set(handles.duoi2,'XTick',[], 'YTick', [])
set(handles.duoi3,'XTick',[], 'YTick', []);set(handles.duoi4,'XTick',[], 'YTick', [])
set(handles.duoi5,'XTick',[], 'YTick', [])
cla(handles.axes3,'reset')
set(handles.axes3,'XTick',[], 'YTick', [])
global vid
load('data.mat','flagChoose')
try
    if flagChoose == 0
    try
        frame = getsnapshot(vid)
        save('data.mat','-append','frame')
    catch e
        msgbox('Khong the chup anh tu camera','Error')
    end
    end
catch e
    msgbox('Ban chua chon anh tu camera hoac anh tu thu vien',"Error")
    return
end
try
    number_plate_det(hObject, eventdata, handles);
    filename = 'data.xlsx';
    data = readExcel(filename);
    set(handles.resultTable,"Data",data);
catch exception
    disp(exception)
    msgbox("Da co loi!!! "+getReport(exception,'basic'),"Error")
    return
end
% hObject    handle to btnRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in closeCamera.
function closeCamera_Callback(hObject, eventdata, handles)
clear camObject;
% hObject    handle to closeCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function finalOutput_Callback(hObject, eventdata, handles)
% hObject    handle to finalOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of finalOutput as text
%        str2double(get(hObject,'String')) returns contents of finalOutput as a double


% --- Executes during object creation, after setting all properties.
function finalOutput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to finalOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
filename = 'data.xlsx';
winopen(filename)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
