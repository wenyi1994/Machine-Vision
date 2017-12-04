function varargout = ImageOpera(varargin)
% IMAGEOPERA MATLAB code for ImageOpera.fig
%      IMAGEOPERA, by itself, creates a new IMAGEOPERA or raises the existing
%      singleton*.
%
%      H = IMAGEOPERA returns the handle to a new IMAGEOPERA or the handle to
%      the existing singleton*.
%
%      IMAGEOPERA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEOPERA.M with the given input arguments.
%
%      IMAGEOPERA('Property','Value',...) creates a new IMAGEOPERA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageOpera_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageOpera_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageOpera

% Last Modified by GUIDE v2.5 04-Dec-2017 11:02:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageOpera_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageOpera_OutputFcn, ...
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


% --- Executes just before ImageOpera is made visible.
function ImageOpera_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageOpera (see VARARGIN)

% Choose default command line output for ImageOpera
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global S1;
global S2;
global S3;
global S4;
S1 = [0,1,0;1,1,1;0,1,0];
S2 = [1,1,1;1,1,1;1,1,1];
S3 = [1,1,1,1,1; 1,0,0,0,1; 1,0,0,0,1; 1,0,0,0,1; 1,1,1,1,1];
S4 = [1,0,0,0,1; 0,1,0,1,0; 0,0,1,0,0; 0,1,0,1,0; 1,0,0,0,1];
global S1_im;
global S2_im;
global S3_im;
global S4_im;
S1_im = bimat2im(S1,75);
S2_im = bimat2im(S2,75);
S3_im = bimat2im(S3,75);
S4_im = bimat2im(S4,75);

axes(handles.axes1);
axis off;

global namestr;
namestr = ['Image Opera'];

% UIWAIT makes ImageOpera wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageOpera_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_ori;
global im_output;
global namestr;
[filename,pathname,filterindex] = uigetfile({'*.png';'*.jpg';'*.bmp';'*.gif'},'Select Image');
if filename == 0
    return;
else
    str = [pathname filename]; 
    im_int = imread(str);
    im_ori = im2double(im_int);
    im_output = im_ori;
    axes(handles.axes1);
    str = [filename, ' - ', namestr];
    set(handles.figure1,'name',str);
    imshow(im_output);
end


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_output;
if im_output == 0
    return;
end
[filename,pathname] = uiputfile({'*.png';'*.jpg';'*.bmp';'*.gif'},'Save Image','untitled');
if filename==0  
    return;  
else  
    imwrite(im_output,[pathname,filename]);
end


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_output;
global im_ori;
im_output = 0;
im_ori = 0;
global S5;
S5 = 0;
close(CCL);
close(KM);
close(MO);



% --------------------------------------------------------------------
function uipushtool3_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global handle_CCL;
close(KM);
close(MO);
handle_CCL = guihandles(CCL);
size_CCL = get(handle_CCL.figure1,'position');
size_Main = get(handles.figure1,'position');
set(handle_CCL.figure1,'pos',[size_Main(1)+size_Main(3),size_Main(2)+size_Main(4)-size_CCL(4),size_CCL(3),size_CCL(4)]);


% --------------------------------------------------------------------
function uipushtool4_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_ori;
global im_output;
if im_ori == 0
    return
else
    im_output = im_ori;
    axes(handles.axes1);
    imshow(im_output);
end


% --------------------------------------------------------------------
function uipushtool5_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global handle_KM;
close(CCL);
close(MO);
handle_KM = guihandles(KM);
size_KM = get(handle_KM.figure1,'position');
size_Main = get(handles.figure1,'position');
set(handle_KM.figure1,'pos',[size_Main(1)+size_Main(3),size_Main(2)+size_Main(4)-size_KM(4),size_KM(3),size_KM(4)]);


% --------------------------------------------------------------------
function uipushtool6_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global handle_MO;
close(CCL);
close(KM);
handle_MO = guihandles(MO);
size_MO = get(handle_MO.figure1,'position');
size_Main = get(handles.figure1,'position');
set(handle_MO.figure1,'pos',[size_Main(1)+size_Main(3),size_Main(2)+size_Main(4)-size_MO(4),size_MO(3),size_MO(4)]);
