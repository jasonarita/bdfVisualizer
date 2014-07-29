
%% Step 1 - CREATE EVENTLIST DISPLAY GUI
%
% Input:
%   - EVENTLIST data structure
%
% Output:
%   - none
%
% Side effects:
%   - Window displaying the event list data EVENTLIST.EVENTINFO
%   - (optional) Display of the input BDF-file

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

%% Display EVENTLIST to GUI
hUITableELIST               = handle(handles.uitableELIST);
hUITableELIST.data          = squeeze(struct2cell(EVENTLIST.eventinfo))';
hUITableELIST.columnWidth   = 'auto';
hUITableELIST.columnName    = fieldnames(EVENTLIST.eventinfo);



%% Step 2 - CREATE BDF-FILE + ELIST-FILE TEXT INPUT
%
%

% Load in an ELIST-file & parse it into an ELIST-structure & display it to
% the GUI
[fileName, pathName] = uigetfile('*.txt', 'Select an event list file');
ELISTfilename       = fullfile(pathName,fileName);

% Load file into ELIST-structure via READEVENTLIST
% ELISTfilename   = fullfile(pwd,'testData','ELIST-test.txt');
[~, eventList]  = readeventlist([], ELISTfilename);

% Display ELIST-struct to GUI
hUITableELIST               = handle(handles.uitableELIST);
hUITableELIST.data          = squeeze(struct2cell(eventList.eventinfo))';
hUITableELIST.columnWidth   = 'auto';
hUITableELIST.columnName    = fieldnames(eventList.eventinfo);


%% Step 3 - ADD BINLISTER FUNCTIONALITY
%
% BINLISTER just needs an input BDF-file and an input ELIST-file

BDFfilename     = fullfile(pwd,'testData','BDF-test.txt');
ELISTfilename   = fullfile(pwd,'testData','ELIST-test.txt');
tmpEEG = pop_binlister( [] ...
    , 'BDF'         , BDFfilename       ...
    , 'ImportEL'    , ELISTfilename     ...
    , 'SendEL2'     , 'EEG'       ...
    ...
    , 'ExportEL'    , 'none'            ...
    , 'Forbidden'   ,  []               ...
    , 'Ignore'      ,  []               ...
    , 'Saveas'      , 'off'             ...
    , 'UpdateEEG'   , 'off'             ...
    , 'Warning'     , 'on');




%% Notes



%% Example: read text file lines as cell array of strings
fid = fopen( fullfile(pwd,'testData','BDF-test.txt') );
str = textscan(fid, '%s', 'Delimiter','\n'); str = str{1};
fclose(fid);

%# GUI with multi-line editbox
hFig = figure('Menubar','none', 'Toolbar','none');
hPan = uipanel(hFig, 'Title','Display window', ...
    'Units','normalized', 'Position',[0.05 0.05 0.9 0.9]);
hEdit = uicontrol(hPan ...
    , 'Style'               ,'edit' ...
    , 'FontSize'            ,9 ...
    , 'Min'                 ,0 ...
    , 'Max'                 ,2 ...
    , 'HorizontalAlignment' ,'left' ...
    , 'Units'               ,'normalized' ...
    , 'Position'            ,[0 0 1 1] ...
    , 'String'              ,str);

% # enable horizontal scrolling
jEdit       = findjobj(hEdit);
jEditbox    = jEdit.getViewport().getComponent(0);
jEditbox.setWrapping(false);                %# turn off word-wrapping
jEditbox.setEditable(false);                %# non-editable
set(jEdit,'HorizontalScrollBarPolicy',30);  %# HORIZONTAL_SCROLLBAR_AS_NEEDED

%# maintain horizontal scrollbar policy which reverts back on component resize 
hjEdit = handle(jEdit,'CallbackProperties');
set(hjEdit, 'ComponentResizedCallback',...
    'set(gcbo,''HorizontalScrollBarPolicy'',30)')



%% Testing UITABLE
tableTest       = uitable;
hTableTest      = handle(tableTest);
hTableTest.data = squeeze(struct2cell(EVENTLIST.eventinfo))';


hTableTest.columnWidth = 'auto';
hTableTest.columnName = fieldnames(EVENTLIST.eventinfo);