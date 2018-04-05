function varargout = RegisterationForm(varargin)
% REGISTERATIONFORM MATLAB code for RegisterationForm.fig
%      REGISTERATIONFORM, by itself, creates a new REGISTERATIONFORM or raises the existing
%      singleton*.
%
%      H = REGISTERATIONFORM returns the handle to a new REGISTERATIONFORM or the handle to
%      the existing singleton*.
%
%      REGISTERATIONFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTERATIONFORM.M with the given input arguments.
%
%      REGISTERATIONFORM('Property','Value',...) creates a new REGISTERATIONFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RegisterationForm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RegisterationForm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RegisterationForm

% Last Modified by GUIDE v2.5 10-Dec-2017 13:57:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RegisterationForm_OpeningFcn, ...
                   'gui_OutputFcn',  @RegisterationForm_OutputFcn, ...
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


% --- Executes just before RegisterationForm is made visible.
function RegisterationForm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RegisterationForm (see VARARGIN)

% Choose default command line output for RegisterationForm
handles.output = hObject;
imshow('C:\Users\naomi\Desktop\UPDATED\Face Recognition Attendance System\images\form.png', 'Parent', handles.axes2);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RegisterationForm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RegisterationForm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function sname_Callback(hObject, eventdata, handles)
% hObject    handle to sname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sname as text
%        str2double(get(hObject,'String')) returns contents of sname as a double


% --- Executes during object creation, after setting all properties.
function sname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rollno_Callback(hObject, eventdata, handles)
% hObject    handle to rollno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rollno as text
%        str2double(get(hObject,'String')) returns contents of rollno as a double


% --- Executes during object creation, after setting all properties.
function rollno_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rollno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global r;
global a;
global p;
global d;
global checkroll;
global rn;

 r = str2double(get(handles.rollno,'String'));
 a = get(handles.sname,'String'); %THIS IS LINE 162
 rn=get(handles.rollno,'String');
 p = 'C:\Users\naomi\Desktop\UPDATED\Face Recognition Attendance System\Training set\';
% rr=num2str(r);
 d = [p  rn '\'];
 %----------------------------excel file ---------------------------------
  filename='C:\Users\naomi\Desktop\UPDATED\Face Recognition Attendance System\attendancesheet.xlsx';
  n=size(xlsread(filename,'Sheet1'),1);
  fprintf(' No of Registered Students : %d\n\n' , n);
  check_roll = sprintf('A%s',num2str(r));
%----------------------------excel file ---------------------------------

  
    if (isempty(a) || isnan(r)) 
        
        errordlg('ENTER FIELDS PROPERLY','Error')
        
  

        return
    end
    
       
%         if exist(d) | check_roll==r
%         warndlg('EXIST');
%            return
class(r)
class(rn)
A = xlsread(filename,'A:A');
% x='93';
y=str2num(rn);
class(y)
b=ismember(A,y)
if b
    warndlg('exisst');
return
        else
%             mkdir(d)
      
 %----------------------------excel file ---------------------------------

              if n == 0
                             xlswrite(filename,{r},'Sheet1','A2');
                             xlswrite(filename,{a},'Sheet1','B2');
            
              else
                         data = xlsread(filename,'Sheet1','A:A');
                         row = length(data)+1;
                     
                         for k = row+1
                             my_roll = sprintf('A%s',num2str(k));
                             xlswrite(filename, {r} ,'Sheet1', my_roll);
          
                             my_name = sprintf('B%s',num2str(k));
                             xlswrite(filename, {a} ,'Sheet1', my_name);
                         end
      
              end
        
    end
    
  
    
fig2 = RegisterationForm;
       run('C:\Users\naomi\Desktop\UPDATED\Face Recognition Attendance System\RegisterImages.m');
close(fig2)
       