function varargout = testguide(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testguide_OpeningFcn, ...
                   'gui_OutputFcn',  @testguide_OutputFcn, ...
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


% --- Executes just before testguide is made visible.
%ch??ng trình kh?i t?o ban ??u
function testguide_OpeningFcn(hObject, eventdata, handles, varargin)
movegui(gcf,'center');
LogoPtit = imread('images.png')
axis(handles.axes1);
imagesc(LogoPtit);
axis off;

handles.output = hObject;
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = testguide_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
close
run Nhan_dien_BSX


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
choice = questdlg('Thoat chuong trinh?',...
    'warning dialog',...,
    'Co','Khong','Co');
switch choice
    case 'Co'
        close
    case 'Khong'
end  
