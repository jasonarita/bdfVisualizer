function varargout = bdfVisualizer(varargin)
% BDFVISUALIZER MATLAB code for bdfVisualizer.fig
%      BDFVISUALIZER, by itself, creates a new BDFVISUALIZER or raises the existing
%      singleton*.
%
%      H = BDFVISUALIZER returns the handle to a new BDFVISUALIZER or the handle to
%      the existing singleton*.
%
%      BDFVISUALIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BDFVISUALIZER.M with the given input arguments.
%
%      BDFVISUALIZER('Property','Value',...) creates a new BDFVISUALIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bdfVisualizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bdfVisualizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bdfVisualizer

% Last Modified by GUIDE v2.5 21-May-2014 13:11:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bdfVisualizer_OpeningFcn, ...
                   'gui_OutputFcn',  @bdfVisualizer_OutputFcn, ...
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


% --- Executes just before bdfVisualizer is made visible.
function bdfVisualizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bdfVisualizer (see VARARGIN)

% Choose default command line output for bdfVisualizer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bdfVisualizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% CREATE EVENTLIST VARIABLE
BDFfilename     = fullfile(pwd,'testData','BDF-test.txt');
ELISTfilename   = fullfile(pwd,'testData','ELIST-test.txt');

[~, EVENTLIST]  = binlister( [] ... % emptyEEG
    , BDFfilename       ...         % inputBinDescriptorFile
    , ELISTfilename     ...         % inputEventList
    , 'none'            ...         % outputEventList
    ,  []               ...         % forbbideCodeArray
    ,  []               ...         % ignoreCodeArray
    ,  0                );          % reportable


hUITableELIST               = handle(handles.uitableELIST);
hUITableELIST.data          = squeeze(struct2cell(EVENTLIST.eventinfo))';
hUITableELIST.columnWidth   = 'auto';
hUITableELIST.columnName    = fieldnames(EVENTLIST.eventinfo);



% --- Outputs from this function are returned to the command line.
function varargout = bdfVisualizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonLoadFile.
function pushbuttonLoadFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLoadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbuttonLoadFile.
function pushbuttonLoadFile_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbuttonLoadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
