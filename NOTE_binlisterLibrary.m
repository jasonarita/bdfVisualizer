
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


%% Step 2 - CREATE BDF-FILE + ELIST-FILE TEXT INPUT
%
%

%% Step 3 - ADD BINLISTER FUNCTIONALITY
%
% BINLISTER just needs an input BDF-file and an input ELIST-file
pop_binlister( [] ...
    , 'BDF'         , 'BDF-getFlags.txt'                    ...
    , 'ImportEL'    , 'ELIST-ERN_hpfilt_ref_V1_S3.txt'      ...
    , 'SendEL2'     , 'Workspace'                           ...
    ...
    , 'ExportEL'    , 'none' ...
    , 'Forbidden'   ,  [] ...
    , 'Ignore'      ,  [] ...
    , 'Saveas'      , 'off' ...
    , 'UpdateEEG'   , 'off' ...
    , 'Warning'     , 'on');
