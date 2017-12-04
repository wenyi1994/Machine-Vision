function varargout = MO(varargin)
% MO MATLAB code for MO.fig
%      MO, by itself, creates a new MO or raises the existing
%      singleton*.
%
%      H = MO returns the handle to a new MO or the handle to
%      the existing singleton*.
%
%      MO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MO.M with the given input arguments.
%
%      MO('Property','Value',...) creates a new MO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MO

% Last Modified by GUIDE v2.5 04-Dec-2017 14:03:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MO_OpeningFcn, ...
                   'gui_OutputFcn',  @MO_OutputFcn, ...
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


% --- Executes just before MO is made visible.
function MO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MO (see VARARGIN)

% Choose default command line output for MO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global S;
global S1;
S = S1;

global S1_im;
global S2_im;
global S3_im;
global S4_im;
axes(handles.axes1);
axis off;
imshow(S1_im);
axes(handles.axes2);
axis off;
imshow(S2_im);
axes(handles.axes3);
axis off;
imshow(S3_im);
axes(handles.axes4);
axis off;
imshow(S4_im);
axes(handles.axes5);
axis off;


% UIWAIT makes MO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_output;
global S;
if im_output == 0
    return
else
    im_temp = imerode(im_output, S);
    im_output = im_temp;
    handle_Main = guihandles(ImageOpera);
    imshow(im_output);
end



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
global S5_im;
global S5;
global S;
input_str = inputdlg({'Set a binary matrix'});
eval(['S5 = ',input_str{1},';']);
S5_im = bimat2im(S5,75);
axes(handles.axes5);
imshow(S5_im);
S = S5;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_output;
global S;
if im_output == 0
    return
else
    im_temp = imdilate(im_output, S);
    im_output = im_temp;
    handle_Main = guihandles(ImageOpera);
    imshow(im_output);
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_output;
global S;
if im_output == 0
    return
else
    im_temp = imclose(im_output, S);
    im_output = im_temp;
    handle_Main = guihandles(ImageOpera);
    imshow(im_output);
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_output;
global S;
if im_output == 0
    return
else
    im_temp = imopen(im_output, S);
    im_output = im_temp;
    handle_Main = guihandles(ImageOpera);
    imshow(im_output);
end

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
global S;
global S1;
S = S1;


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
global S;
global S2;
S = S2;


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
global S;
global S3;
S = S3;


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
global S;
global S4;
S = S4;
