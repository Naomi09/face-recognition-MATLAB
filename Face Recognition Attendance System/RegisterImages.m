function varargout = RegisterImages(varargin)
% REGISTERIMAGES MATLAB code for RegisterImages.fig
%      REGISTERIMAGES, by itself, creates a new REGISTERIMAGES or raises the existing
%      singleton*.
%
%      H = REGISTERIMAGES returns the handle to a new REGISTERIMAGES or the handle to
%      the existing singleton*.
%
%      REGISTERIMAGES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTERIMAGES.M with the given input arguments.
%
%      REGISTERIMAGES('Property','Value',...) creates a new REGISTERIMAGES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RegisterImages_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RegisterImages_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RegisterImages

% Last Modified by GUIDE v2.5 10-Dec-2017 14:38:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RegisterImages_OpeningFcn, ...
                   'gui_OutputFcn',  @RegisterImages_OutputFcn, ...
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


% --- Executes just before RegisterImages is made visible.
function RegisterImages_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RegisterImages (see VARARGIN)

% Choose default command line output for RegisterImages
handles.output = hObject;
imshow('C:\Users\naomi\Desktop\UPDATED\Face Recognition Attendance System\images\camera.png', 'Parent', handles.axes3);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RegisterImages wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RegisterImages_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in on_button.
function on_button_Callback(hObject, eventdata, handles)
% hObject    handle to on_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IAHI= imaqhwinfo;
IA= (IAHI.InstalledAdaptors);
D= menu ('Select Video Input Device:',IA);

if isempty(IA)||D==0
    msgbox({'You dont have any Video Input Installed Adaptors',IA})
    return
end

IA=char(IA);
IA=IA(D,:);
IA(IA==' ')=[];
x=imaqhwinfo(IA);
try
DeviceID=menu('Select Device ID',x.DeviceIDs);
F=x.DeviceInfo(DeviceID).SupportedFormats;
nF=menu('Select FORMAT',F);
Format=F{nF};
catch 
   warndlg({'Try Another Device or ID ';...
            'You Donot Have Installed This Device(VideoInputDevice)'})
    return
end

VidObj=videoinput(IA,DeviceID,Format);
handles.VidObj=VidObj;
vidRes = get(handles.VidObj,'VideoResolution');
nBands = get(handles.VidObj,'NumberofBands');
axes(handles.axes1)
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
preview(handles.VidObj,hImage)

set(VidObj, 'ReturnedColorSpace', 'RGB');
guidata(hObject,handles);

% --- Executes on button press in capture_button.
function capture_button_Callback(hObject, eventdata, handles)
% hObject    handle to capture_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rn;
global p;
counter  = 1;

try
    VidObj=handles.VidObj;
    i= getsnapshot(VidObj);
     axes(handles.axes2)
    imshow(i);
end
faceDetector = vision.CascadeObjectDetector; 
bbox = step(faceDetector, i); 
IFaces = insertObjectAnnotation(i, 'rectangle', bbox, 'face');
imshow(IFaces); 


for f = 1:size(bbox,1)
 J= imcrop(IFaces,bbox(f,:));
  baseDir  = p;
newName  = [baseDir num2str(counter) '.pgm'];
while exist(newName,'file')
    counter = counter + 1;
    newName = [baseDir num2str(counter) '.pgm'];
end    
I2 = rgb2gray(J);

I2 = imresize(I2, [130 80]);
imwrite(I2, newName);
end

% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all

% --- Executes on button press in home.
function home_Callback(hObject, eventdata, handles)
% hObject    handle to home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


fig2 = RegisterImages;
Home
close(fig2)
% --- Executes on button press in addresgister.
function addresgister_Callback(hObject, eventdata, handles)
% hObject    handle to addresgister (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig2 = RegisterImages;
RegisterationForm
close(fig2)

