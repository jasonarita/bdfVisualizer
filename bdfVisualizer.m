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

% Last Modified by GUIDE v2.5 22-Jul-2014 15:47:45

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
function bdfVisualizer_OpeningFcn(hObject, ~, handles, varargin)
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
% uiwait(handles.windowBDFVisualizer);


%% Load default ELIST
ELISTfilename               = fullfile(pwd,'testData','defaultELIST.txt');          % set default EVENTLIST filename
[~, handles.eventList]      = readeventlist([], ELISTfilename);                     % read EVENTLIST from file
guidata(hObject, handles);                                                          % save EVENTLIST to HANDLES

hUITableELIST               = handle(handles.uitableELIST);
hUITableELIST.data          = squeeze(struct2cell(handles.eventList.eventinfo))';   % Display ELIST-struct to GUI
hUITableELIST.columnName    = fieldnames(handles.eventList.eventinfo);
% hUITableELIST.columnWidth   = 'auto';


%% Load default BDF
fileID                  = fopen(fullfile(pwd,'testData','defaultBDF.txt') );                % Read in the default BDF-file
fileString              = textscan(fileID, '%s', 'Delimiter','\n');                         % Read BDF-file text into string
handles.bdf             = fileString{1};                                                    % load the text-string into HANDLES
fclose(fileID);                                                                     % clean up the loaded BDF-file

hEditBDF               = handle(handles.editBDF);                   
hEditBDF.string        = handles.bdf;                                               % Display BDF to GUI


%% Initiate default BDF Feedback Window
hUITableBinlisterFeedback         = handle(handles.uitableBinlisterFeedback);   
hUITableBinlisterFeedback.rowName = { 'Total Event Codes', 'Bin 1'  };          
hUITableBinlisterFeedback.data    = [0         , 0        ]';                   


handles.lastPath = pwd;
% Update handles structure
guidata(hObject, handles);                                                          % save HANDLES structure to GUI


% --- Outputs from this function are returned to the command line.
function varargout = bdfVisualizer_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonLoadELIST.
function pushbuttonLoadELIST_Callback(hObject, ~, handles) %#ok<*DEFNU>
% hObject    handle to pushbuttonLoadELIST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Load in an ELIST-file & parse it into an ELIST-structure & display it to
% the GUI
[fileName, pathName]        = uigetfile({'*.txt', 'Event List File (.txt)'}, 'Select an event list file (ELIST)', handles.lastPath);

%% Default EventList Window
if(~isequal(fileName,0) || ~isequal(pathName,0))
    ELISTfilename               = fullfile(pathName,fileName);                          % Load file into ELIST-structure via READEVENTLIST
    [~, handles.eventList]      = readeventlist([], ELISTfilename);
    handles.lastPath            = pathName;                                             % Update the last directory in HANDLES

    % Default ELIST-struct to GUI
    hUITableELIST               = handle(handles.uitableELIST);
    hUITableELIST.data          = squeeze(struct2cell(handles.eventList.eventinfo))';
    
    guidata(hObject,handles);                                                           % Update the HANDLES data-structure

else
    display('User selected cancel');  % User selected Cancel
end





% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbuttonLoadELIST.
function pushbuttonLoadELIST_ButtonDownFcn(~, ~, ~)
% hObject    handle to pushbuttonLoadELIST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editBDF_Callback(~, ~, ~)
% hObject    handle to editBDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBDF as text
%        str2double(get(hObject,'String')) returns contents of editBDF as a double


% --- Executes during object creation, after setting all properties.
function editBDF_CreateFcn(hObject, ~, ~)
% hObject    handle to editBDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonAnalyzeBDF.
function pushbuttonAnalyzeBDF_Callback(~, ~, handles)
% hObject    handle to pushbuttonAnalyzeBDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
% We turn the interface off for processing.
InterfaceObj=findobj(handle(handles.windowBDFVisualizer),'Enable','on');
set(InterfaceObj,'Enable','off');


% Load BDF
hEditBDF        = handle(handles.editBDF);              % Retrieve BDF data from the GUI
BDFfilename     = fullfile(pwd,'BDF-tmp.txt');          % Create temporary BDF-file
fileID          = fopen(BDFfilename, 'wt');             % 
fprintf(fileID,'%s\n', hEditBDF.string{:});             %
fclose( fileID);

% Load ELIST
objELIST                    = handle(handles.uitableELIST);         % Get the current Event List from the GUI
handles.eventList.eventinfo = cell2struct(objELIST.Data, fieldnames(handles.eventList.eventinfo), 2);
ELISTfilename               = fullfile(pwd,'ELIST-tmp.txt');        % Create temporary ELIST-file
creaeventlist([],handles.eventList,ELISTfilename,1);                % Write eventlist to file

%% RUN BINLISTER
[~, handles.eventList]  = binlister( [] ... % emptyEEG
    , BDFfilename       ...         % inputBinDescriptorFile
    , ELISTfilename     ...         % inputEventList
    , 'none'            ...         % outputEventList
    ,  []               ...         % forbbideCodeArray
    ,  []               ...         % ignoreCodeArray
    ,  0                );          % reportable


%% Display updated ELIST-struct to GUI
hUITableELIST                     = handle(handles.uitableELIST);
hUITableELIST.data                = squeeze(struct2cell(handles.eventList.eventinfo))';
% hUITableELIST.columnWidth         = 'auto';
hUITableELIST.columnName          = fieldnames(handles.eventList.eventinfo);

%% Display updated BDF Feedback window
totalEvents                       = length(handles.eventList.eventinfo);
hUITableBinlisterFeedback         = handle(handles.uitableBinlisterFeedback);
hUITableBinlisterFeedback.rowName = { 'Total Event Codes', handles.eventList.bdf.namebin };
hUITableBinlisterFeedback.data    = [totalEvents handles.eventList.trialsperbin]';

%% Cleanup
delete(BDFfilename);                                    % Delete temporary BDF-file
delete(ELISTfilename);                                  % Delete temporary ELIST-file
set( findall(handles.windowBDFVisualizer, '-property', 'Enable'), 'Enable', 'on')


% We turn back on the interface
set(InterfaceObj,'Enable','on');


catch errorObj
    % If there is a problem, we display the error message
    errordlg(getReport(errorObj,'extended','hyperlinks','off'),'Error');
end

% --- Executes on button press in pushbuttonLoadBDF.
function pushbuttonLoadBDF_Callback(hObject, ~, handles)
% hObject    handle to pushbuttonLoadBDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% BDF LOAD
[fileName, pathName]            = uigetfile('*.txt', 'Select a bin descriptor file (BDF)', handles.lastPath);

if(~isequal(fileName,0) || ~isequal(fileName,0))
    % Load file into ELIST-structure via READEVENTLIST
    BDFfilename                 = fullfile(pathName,fileName);
    fileID                      = fopen(BDFfilename);
    fileString                  = textscan(fileID, '%s', 'Delimiter','\n'); 
    fclose(fileID);

    handles.bdf                 = fileString{1};    % Update the BDF variable in HANDLES
    handles.lastPath            = pathName;         % Update the last directory in HANDLES
    guidata(hObject,handles);                       % Update the HANDLES data-structure
    
    %% DISPLAY LOADED BDF TO GUI
    hEditBDF               = handle(handles.editBDF);
    hEditBDF.string        = handles.bdf;
else
    % User-selected Cancel
    display('User selected cancel');
end
