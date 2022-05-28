function varargout = guntur(varargin)
% GUNTUR MATLAB code for guntur.fig
%      GUNTUR, by itself, creates a new GUNTUR or raises the existing
%      singleton*.
%
%      H = GUNTUR returns the handle to a new GUNTUR or the handle to
%      the existing singleton*.
%
%      GUNTUR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUNTUR.M with the given input arguments.
%
%      GUNTUR('Property','Value',...) creates a new GUNTUR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guntur_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guntur_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guntur

% Last Modified by GUIDE v2.5 28-May-2022 17:12:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guntur_OpeningFcn, ...
                   'gui_OutputFcn',  @guntur_OutputFcn, ...
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


% --- Executes just before guntur is made visible.
function guntur_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guntur (see VARARGIN)

% Choose default command line output for guntur
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guntur wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guntur_OutputFcn(hObject, eventdata, handles) 
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
[filename,pathname] = uigetfile({'*.*'});
 
if ~isequal(filename,0)
    Info = imfinfo(fullfile(pathname,filename));
    if Info.BitDepth == 1
        msgbox('Citra masukan harus citra RGB atau Grayscale');
        return
    elseif Info.BitDepth == 8
        Img = imread(fullfile(pathname,filename));
        axes(handles.axes1)
        cla('reset')
        imshow(Img)
        title('Grayscale Image')
    else
        Img = rgb2gray(imread(fullfile(pathname,filename)));
        axes(handles.axes1)
        cla('reset')
        imshow(Img)
        title('Grayscale Image')
    end
else
    return
end
 
handles.Img = Img;
guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
pixel_dist = 1;
GLCM = graycomatrix(Img,'Offset',[0 pixel_dist; -pixel_dist pixel_dist; -pixel_dist 0; -pixel_dist -pixel_dist]);
stats = graycoprops(GLCM,{'contrast','correlation','energy','homogeneity'});

Contrast = stats.Contrast;
Correlation = stats.Correlation;
Energy = stats.Energy;
Homogeneity = stats.Homogeneity;


 
data{1,1} = num2str(Correlation(1));
data{1,2} = num2str(Correlation(2));
data{1,3} = num2str(Correlation(3));
data{1,4} = num2str(Correlation(4));
data{1,5} = num2str(mean(Correlation));
 
data{2,1} = num2str(Energy(1));
data{2,2} = num2str(Energy(2));
data{2,3} = num2str(Energy(3));
data{2,4} = num2str(Energy(4));
data{2,5} = num2str(mean(Energy));

data{3,1} = num2str(Homogeneity(1));
data{3,2} = num2str(Homogeneity(2));
data{3,3} = num2str(Homogeneity(3));
data{3,4} = num2str(Homogeneity(4));
data{3,5} = num2str(mean(Homogeneity));

data{4,1} = num2str(Contrast(1));
data{4,2} = num2str(Contrast(2));
data{4,3} = num2str(Contrast(3));
data{4,4} = num2str(Contrast(4));
data{4,5} = num2str(mean(Contrast));
 
set(handles.uitable1,'Data',data,'ForegroundColor',[0 0 0]);
