function [status, status_description] = agt_waveformload(connection, IQData, ArbFileName, sample_rate, play_flag, normscale_flag, markers)
% PSG/ESG Download Assistant, Version 2.0
% Copyright (C) 2003,2005 Agilent Technologies, Inc.
%
% function [status, status_description] = agt_waveformload(connection, IQData, ArbFileName, sample_rate, play_flag,
%                                                          normscale_flag, markers)
%
% The function downloads, and optionally plays, IQ data on the signal generator
%
% Output:
%   status              integer     status of download. 0:download succeeded, -1:download failed
%   status_description  string      if status is < 0, status_description contains an error message.
%
% Input:
%   connection     A structure generated by the agt_newconnection function.
%   IQData         IQ data array. This should be a 1D complex array. I+jQ.
%   ArbFileName    Optional parameter.  The Arb file name (string).  If nothing is specified
%                  the default is 'Untitled'
%   sample_rate    Optional parameter.  If nothing is specified, the default sample rate is what
%                  the signal generator is currently set to.
%   play_flag      Optional parameter.  This parameter either plays or does not play a
%                  waveform on the signal generator.  If a waveform shouldn't be played
%                  specify 'no_play'.  Default is 'play'.
%   normscale_flag Optional parameter.  Specify 'normscale' if the data is to be normalized to +/- 1 and
%                  scaled at 70%.  Specify 'no_normscale' if the data will not be normalized and scaled
%                  within this function.
%   Markers        Optional parameter.  Marker is a 2D array with the size of nMarker x nIQDataLenth. Each
%                  marker can be either 0 or 1. Default is that no markers will be set.
if(nargin) < 2
    error('at least three input parameter is needed');
end

if (nargin < 7) markers = []; end;
if (nargin < 6) normscale_flag = 'normscale'; end;
if (nargin < 5) play_flag = 'play'; end;
if (nargin < 4) sample_rate = 0; end;
if (nargin < 3) ArbFileName = 'Untitled'; end;

if (~ischar(ArbFileName))
    error('ArbFileName should be a string');
end

if (strcmpi( normscale_flag, 'no_normscale' ) )
    maxval = max(abs([real(IQData) imag(IQData)]));
    if ( maxval > 1)
        error('IQData must be in the range [ -1:1 ]' );
    end
end

% make sure IQ data is a 1xN array.
[m,n] = size(IQData);
if (m ~= 1)
    error('IQData should be an 1xN complex array ');
end
IQDataLen = length(IQData);

% Check for invalid input
if (~isempty(markers))
    markerDim = size(markers);
    if (length(markerDim) ~= 2)
        error('markers should be a 2 D array');
    end
    
    [rowMarker,colMarker] = size(markers);
    if (rowMarker == IQDataLen)
        markers = markers';
        [rowMarker,colMarker] = size(markers);
    end
    
    if (colMarker ~= IQDataLen)
        error('markers should have the same length as IQData');
    end
    %  Create the markers
    for i = 1:IQDataLen
        tmp = markers(:,i);
        if isequal(tmp(:),[1;1])
            markers(1,i) = uint8(char(3));
        elseif isequal(tmp(:),[0;1])
            markers(1,i) = uint8(char(2));
        elseif isequal(tmp(:),[1;0])
            markers(1,i) = uint8(char(1));
        else
            markers(1,i) = uint8(char(0));
        end
    end
    markers = uint8(markers(1,:));
else
    % Default markers are all zeros
    markers = uint8(zeros(1,IQDataLen));
end

if (~ischar(play_flag))
    error('play_flag should be a string');
end

% Turn off the ARB so we don't damage it
[status, status_description] = agt_sendcommand(connection,':SOURce:RADio:ARB:STATE OFF');
if (status < 0)
    return;
end

wave = [real(IQData);imag(IQData)]; % get the real and imaginary parts
wave = wave(:)';    % transpose and interleave the waveform

tmp = 1; % default normalization factor = 1
if (strcmpi( normscale_flag, 'normscale' ) )
    %select the normalization factor
    tmp = max(abs([max(wave) min(wave)]));
    if (tmp == 0)
        tmp = 1;
    end
end
% ARB binary range is 2's Compliment -32768 to + 32767
% So scale the waveform to +/- 32767 not 32768
modval = 2^16;
scale = 2^15-1;
scale = scale/tmp;
wave = round(wave * scale);
%  Get it from double to unsigned int and let the driver take care of Big
%  Endian to Little Endian for you  Look at ESG in Workspace.  It is
%  property of the VISA driver (at least Agilent's
%  if your waveform is skrewy, suspect the NI driver of not changeing
%  BIG ENDIAN to LITTLE ENDIAN.  The PC is BIG ENDIAN.  ESG is LITTLE
wave = uint16(mod(modval + wave, modval));

% write the waveform data
binblockwrite(connection,wave,'uint16',[':MEMory:DATa:UNProtected "WFM1:' ArbFileName '", ']);
fprintf(connection,'\n');

% query for instrument error
[status, status_description, query_result] = agt_query(connection,':SYSTEM:ERROR?');
if status<0
    return;
end

% write the marker data
binblockwrite(connection,markers,'uint8',[':MEMory:DATa:UNProtected "MKR1:' ArbFileName '",']);
fprintf(connection,'\n');

% query for instrument error
[status, status_description, query_result] = agt_query(connection,':SYSTEM:ERROR?');
if status<0
    return;
end

% Set the sample rate
if ( sample_rate ~= 0 )
    [status, status_description] = agt_sendcommand(connection, [':SOURce:RADio:ARB:CLOCk:SRATe ' num2str(sample_rate) ] );
    if (status < 0)
        return;
    end
end

% select the source file
playcommand = [':SOURce:RAD:ARB:WAV "ARBI:' ArbFileName '"'];
if ( strcmpi(play_flag, 'play') )
    [status, status_description] = agt_sendcommand(connection,playcommand);
    if (status < 0)
        return;
    end
    % turn on the ARB
    [status, status_description] = agt_sendcommand(connection,':SOURce:RADio:ARB:STATE ON');
    if (status < 0)
        return;
    end
end

status = 0;
status_description = 'succeeded';
return