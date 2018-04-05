function varargout = AttendanceTime(varargin)
% ATTENDANCETIME MATLAB code for AttendanceTime.fig
%      ATTENDANCETIME, by itself, creates a new ATTENDANCETIME or raises the existing
%      singleton*.
%
%      H = ATTENDANCETIME returns the handle to a new ATTENDANCETIME or the handle to
%      the existing singleton*.
%
%      ATTENDANCETIME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATTENDANCETIME.M with the given input arguments.
%
%      ATTENDANCETIME('Property','Value',...) creates a new ATTENDANCETIME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AttendanceTime_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AttendanceTime_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AttendanceTime

% Last Modified by GUIDE v2.5 27-Dec-2017 02:46:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AttendanceTime_OpeningFcn, ...
                   'gui_OutputFcn',  @AttendanceTime_OutputFcn, ...
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


% --- Executes just before AttendanceTime is made visible.
function AttendanceTime_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AttendanceTime (see VARARGIN)

% Choose default command line output for AttendanceTime
handles.output = hObject;
imshow('C:\Users\naomi\Desktop\UPDATED\Face Recognition Attendance System\images\camera.png', 'Parent', handles.axes5);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AttendanceTime wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AttendanceTime_OutputFcn(hObject, eventdata, handles) 
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
global dt;
global dt2;
global baseDir;
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

baseDir  = 'C:\Users\naomi\Desktop\UPDATED\Face Recognition Attendance System\Testing set\';
dt=date;
dt2=[baseDir dt '\'];

if exist(dt2)
    
        
dinfo = dir(dt2);
dinfo([dinfo.isdir]) = [];   %skip directories
filenames = fullfile(dt2, {dinfo.name});

if length(filenames)~=0
delete( filenames{:} )
end       
else
    mkdir(dt2);
   
end

% --- Executes on button press in capture_button.
function capture_button_Callback(hObject, eventdata, handles)
% hObject    handle to capture_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global r;
global dt2;
counter  = 1;
try
    VidObj=handles.VidObj;
    i= getsnapshot(VidObj);
    
    %n=str2double(get(handles.edit1,'String'))++1;
    %set(handles.edit1,'String',num2str(n));
 
    axes(handles.axes2)
    imshow(i);
    
end
faceDetector = vision.CascadeObjectDetector; 
%a = imread(i);

bbox = step(faceDetector, i); 
IFaces = insertObjectAnnotation(i, 'rectangle', bbox, 'face');
imshow(IFaces); 
for f = 1:size(bbox,1)
 J= imcrop(IFaces,bbox(f,:));
   %figure(3),imshow(J);

   
   

   
% baseName = 'image_';
newName  = [dt2 num2str(counter) '.pgm'];
while exist(newName,'file')
    counter = counter + 1;
    newName = [dt2 num2str(counter) '.pgm'];
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
fig2 = AttendanceTime;
Home
close(fig2)
% --- Executes on button press in generateattendance.
function generateattendance_Callback(hObject, eventdata, handles)
% hObject    handle to generateattendance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% A sample script, which shows the usage of functions, included in
% PCA-based face recognition system (Eigenface method)
%
% See also: CREATEDATABASE, EIGENFACECORE, RECOGNITION

% Original version by Amir Hossein Omidvarnia, October 2007
%                     Email: aomidvar@ece.ut.ac.ir                  

% clear all
% clc
% close all
global dt2;
% You can customize and fix initial directory paths
TrainDatabasePath = 'C:\Users\naomi\Desktop\UPDATED\Face Recognition Attendance System\Training set';
% TestDatabasePath = 'C:\Users\naomi\Desktop\UPDATED\Face Recognition Attendance System\Testing set';
TestDatabasePath = dt2;

% prompt = {'Enter test image name (a number between 1 to 10):'};
% dlg_title = 'Input of PCA-Based Face Recognition System';
% num_lines= 1;
% def = {'1'};
%-------------------------------------------------------------------------------------------------
allSubFolders = genpath(dt2);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
	[singleSubFolder, remain] = strtok(remain, ';');
	if isempty(singleSubFolder)
		break;
	end
	listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames);


for k = 1 : numberOfFolders

	thisFolder = listOfFolderNames{k};
	fprintf('Processing folder %s\n', thisFolder);
	
	filePattern = sprintf('%s/*.pgm', thisFolder);
	baseFileNames = dir(filePattern);
	
	numberOfImageFiles = length(baseFileNames);
	
	
	if numberOfImageFiles >= 1
	
		for f = 1 : numberOfImageFiles
			fullFileName = fullfile(thisFolder, baseFileNames(f).name);
			fprintf('     Processing image file %s\n', fullFileName);
            
		end
	else
		fprintf('     Folder %s has no image files in it.\n', thisFolder);
	end
end
%---------------------------------------------------------------------------


dh=[dt2 '/*.pgm'];
pt=[dt2 '/'];
srfile=dir(dh);
for i=1:length(srfile)
    prompt=strcat(pt,srfile(i).name);
im = imread(prompt);

T = CreateDatabase(TrainDatabasePath);
[m, A, Eigenfaces] = EigenfaceCore(T);
OutputName = Recognition(prompt, m, A, Eigenfaces);

SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
SelectedImage = imread(SelectedImage);
figure,
subplot(2,2,1)
imshow(im)
title('Test Image');
subplot(2,2,2);
imshow(SelectedImage)
title('Equivalent Image');

end

function pushbutton10_Callback(hObject, eventdata, handles)

 winopen('C:\Users\naomi\Desktop\UPDATED\Face Recognition Attendance System\attendancesheet.xlsx')