function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 14-May-2018 17:51:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
global camera;
camera = webcam; 


%//////////////////////////////////////////////////////////////////////////
% HARRIS
%//////////////////////////////////////////////////////////////////////////
function Harris_Callback(hObject, eventdata, handles)
% hObject    handle to Harris (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camera;
global harris_running;
global brisk_running;
global fast_running;
global min_eigen_running;
global surf_running;
global mser_running;
harris_running = true;
brisk_running = false;
fast_running = false;
min_eigen_running = false;
surf_running = false;
mser_running = false;
h1 = figure(1);
set(h1,'name','HARRIS');
while harris_running   
    picture = camera.snapshot;      
    corners = detectHarrisFeatures(rgb2gray(picture));   
    set(0,'currentfigure',h1)
    imshow(picture); hold on;
    set(0,'currentfigure',h1)
    plot(corners.selectStrongest(150)); 
end

%//////////////////////////////////////////////////////////////////////////
% BRISK
%//////////////////////////////////////////////////////////////////////////
function BRISK_Callback(hObject, eventdata, handles)
% hObject    handle to BRISK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camera;
global harris_running;
global brisk_running;
global fast_running;
global min_eigen_running;
global surf_running;
global mser_running;
harris_running = false;
brisk_running = true;
fast_running = false;
min_eigen_running = false;
surf_running = false;
mser_running = false;
h1 = figure(1);
set(h1,'name','BRISK');
while brisk_running   
    picture = camera.snapshot;              
    corners = detectBRISKFeatures(rgb2gray(picture));   
    set(0,'CurrentFigure',h1)
    imshow(picture); hold on;
    set(0,'CurrentFigure',h1)
    plot(corners.selectStrongest(150));
end

%//////////////////////////////////////////////////////////////////////////
% FAST
%//////////////////////////////////////////////////////////////////////////
function FAST_Callback(hObject, eventdata, handles)
% hObject    handle to FAST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camera;
global harris_running;
global brisk_running;
global fast_running;
global min_eigen_running;
global surf_running;
global mser_running;
harris_running = false;
brisk_running = false;
fast_running = true;
min_eigen_running = false;
surf_running = false;
mser_running = false;
h1 = figure(1);
set(h1,'name','FAST');
while fast_running   
    picture = camera.snapshot;              
    corners = detectFASTFeatures(rgb2gray(picture));   
    set(0,'CurrentFigure',h1)
    imshow(picture); hold on;
    set(0,'CurrentFigure',h1)
    plot(corners);
end


%//////////////////////////////////////////////////////////////////////////
% MSER
%//////////////////////////////////////////////////////////////////////////
% --- Executes on button press in MSER.
function MSER_Callback(hObject, eventdata, handles)
% hObject    handle to MSER (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camera;
global harris_running;
global brisk_running;
global fast_running;
global min_eigen_running;
global surf_running;
global mser_running;
harris_running = false;
brisk_running = false;
fast_running = false;
min_eigen_running = false;
surf_running = false;
mser_running = true;
h1 = figure(1);
set(h1,'name','MSER');
while mser_running   
    picture = camera.snapshot;              
    corners = detectMSERFeatures(rgb2gray(picture));   
    set(0,'CurrentFigure',h1)
    imshow(picture); hold on;
    set(0,'CurrentFigure',h1)
    plot(corners);
end


%//////////////////////////////////////////////////////////////////////////
% SURF
%//////////////////////////////////////////////////////////////////////////
% --- Executes on button press in SURF.
function SURF_Callback(hObject, eventdata, handles)
% hObject    handle to SURF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camera;
global harris_running;
global brisk_running;
global fast_running;
global min_eigen_running;
global surf_running;
global mser_running;
harris_running = false;
brisk_running = false;
fast_running = false;
min_eigen_running = false;
surf_running = true;
mser_running = false;
h1 = figure(1);
set(h1,'name','SURF');
while surf_running   
    picture = camera.snapshot;              
    corners = detectSURFFeatures(rgb2gray(picture));   
    set(0,'CurrentFigure',h1)
    imshow(picture); hold on;
    set(0,'CurrentFigure',h1)
    plot(corners);
end
 

%//////////////////////////////////////////////////////////////////////////
% EIGEN
%//////////////////////////////////////////////////////////////////////////
% --- Executes on button press in MinEigen.
function MinEigen_Callback(hObject, eventdata, handles)
% hObject    handle to MinEigen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camera;
global harris_running;
global brisk_running;
global fast_running;
global min_eigen_running;
global surf_running;
global mser_running;
harris_running = false;
brisk_running = false;
fast_running = false;
min_eigen_running = true;
surf_running = false;
mser_running = false;
h1 = figure(1);
set(h1,'name','Min Eigen');
while min_eigen_running   
    picture = camera.snapshot;              
    corners = detectMinEigenFeatures(rgb2gray(picture));   
    set(0,'CurrentFigure',h1)
    imshow(picture); hold on;
    set(0,'CurrentFigure',h1)
    plot(corners.selectStrongest(1000));
end


 
