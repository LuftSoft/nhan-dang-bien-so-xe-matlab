function varargout = testguide(varargin)
% TESTGUIDE MATLAB code for testguide.fig
%      TESTGUIDE, by itself, creates a new TESTGUIDE or raises the existing
%      singleton*.
%
%      H = TESTGUIDE returns the handle to a new TESTGUIDE or the handle to
%      the existing singleton*.
%
%      TESTGUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTGUIDE.M with the given input arguments.
%
%      TESTGUIDE('Property','Value',...) creates a new TESTGUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testguide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testguide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testguide

% Last Modified by GUIDE v2.5 26-Sep-2022 21:22:47

% Begin initialization code - DO NOT EDIT
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
LogoPtit = imread('C:\Users\Admin\Videos\HK1_NAM4\XULYANH\output-onlinepngtools - Copy.jpg')
axis(handles.axes1);
imagesc(LogoPtit);
axis off;
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testguide (see VARARGIN)

% Choose default command line output for testguide
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testguide wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testguide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
close
run Nhan_dien_BSX

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


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
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
