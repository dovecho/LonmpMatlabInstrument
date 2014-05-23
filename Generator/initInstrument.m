function initInstrument(MM)
% initInstrument
%   INITINSTRUMENT build the basic I/O and initialization functions 
%   for a Initrument, which contains (ii for Abbr of a instrument)
%
%   iiInit, iiDestroy, iiRead, iiWrite, iiQuery
%   iiReadData, iiQueryData
%   
%	Copyright 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Change Directory dealing
%	$Version: 1.0.1.2 $	$Date: 2012-05-19 09:07:55 $

%% Create Directory
abbr = char(MM(1));
DIR = sprintf('..\\INSTR\\%s', abbr);
system(['md ', DIR]);

%% Create iiInit File
funcName = sprintf('%sInit', lower(abbr));
fileName = [DIR, sprintf('\\%s.m', funcName)];
fid = createFile(fileName);

% Export function head
fprintf(fid, 'function h%s = %s( addr )\n', upper(abbr), funcName); % function header
fprintf(fid, '%% %s.m\n', funcName);
fprintf(fid, '%%\t%s Initialize an instrument handler for %s %s\n', upper(funcName), char(MM(2)), char (MM(3)));
fprintf(fid, '%%\t%s.\n', char(MM(7)));
fprintf(fid, '%%\t\n');
fprintf(fid, '%%\tg_h%s\t Handle of this instrument\n', upper(abbr));
myStamp(fid, 'Generating this file', '2.1.0.1');

% process sHandle according to instrument type
% Error control for opened instrument

% LAN is not supported in this file rightnow
instType = {'GPIB';'VXI';'ASRL';'USB';};
for iType = 1 : length(instType)
    strType = char(instType(iType));
    if strfind(char(MM(5)), strType)>0
        switch strType
            case 'USB'
                sHandle = sprintf('g_addr_usb_%s', upper(abbr));
                sType = strType;
            case 'ASRL'
%                 fprintf(fid, 'if ~isempty(instrfind(''Type'',''visa-serial'', ''Status'', ''open''))\n');
%                 fprintf(fid, '\tfclose(instrfind(''Type'',''visa-serial'', ''Status'', ''open''));\n');
%                 fprintf(fid, 'end\n');
                sHandle = sprintf('g_addr_asrl_%s', upper(abbr));
                sType = strType;
            case 'VXI'
%                 fprintf(fid, 'if ~isempty(instrfind(''Type'',''visa-vxi'', ''Status'', ''open''))\n');
%                 fprintf(fid, '\tfclose(instrfind(''Type'',''visa-vxi'', ''Status'', ''open''));\n');
%                 fprintf(fid, 'end\n');
                sHandle = sprintf('g_addr_%s', upper(abbr));
                sType = strType;
            case 'GPIB'
%                 fprintf(fid, 'if ~isempty(instrfind(''Type'',''visa-gpib'', ''Status'', ''open''))\n');
%                 fprintf(fid, '\tfclose(instrfind(''Type'',''visa-gpib'', ''Status'', ''open''));\n');
%                 fprintf(fid, 'end\n');
                sHandle = sprintf('g_addr_%s', upper(abbr));
                sType = strType;
            otherwise
                error('Inst type is not supported in this generator!\n');
        end % switch
    end % if
end % iType
fprintf(fid, '\n');

% Export Definition;
fprintf(fid, 'globalADDR;\n\n');
fprintf(fid, 'global g_h%s;\n', upper(abbr));
fprintf(fid, 'global %s;\n\n', sHandle);
% End of definition

% Get address
fprintf(fid, 'if nargin == 1\n');
fprintf(fid, '    addr_%s = addr;\n', upper(abbr));
fprintf(fid, 'else\n');
fprintf(fid, '    addr_%s = %s;  %% Default \n', upper(abbr), sHandle);
fprintf(fid, 'end\n');
fprintf(fid, '%sDestroy;\n', lower(abbr));
fprintf(fid, '\n');

% get the address with VISA RSRCNAMEs
fprintf(fid, '%%Check connected visa instrument to determine RSRCNAMEs\n');
fprintf(fid, 'vinfo = instrhwinfo(''visa'',''agilent'');\n');
fprintf(fid, 'vf = vinfo.ObjectConstructorName;\n');
fprintf(fid, 'for ivf = 1 : length(vf)\n');
fprintf(fid, '    if strfind(char(vf(ivf)), ''%s'')>0 & strfind(char(vf(ivf)), num2str(addr_%s))>0\n', sType, upper(abbr));
fprintf(fid, '        strAddr = char(vf(ivf));\n');
fprintf(fid, '        break;\n');
fprintf(fid, '    end\n');
fprintf(fid, 'end\n');

fprintf(fid, '\n%%Connect to the instrument\n');
fprintf(fid, 'eval([''g_h%s = '', strAddr]);\n', upper(abbr));
fprintf(fid, 'set(g_h%s,''InputBufferSize'', 200000);\n', upper(abbr));

if strcmp(sType, 'ASRL')>0
    fprintf(fid, 'pause(0.1);\n');
    fprintf(fid, 'set(g_h%s,''BaudRate'',baud_%s);\n', upper(abbr), upper(abbr)); 
end
fprintf(fid, 'fopen(g_h%s);\n', upper(abbr));

fprintf(fid, 'if strcmp (g_h%s.Status, ''closed'') == 1\n', upper(abbr));
fprintf(fid, '    fopen(g_h%s);\n', upper(abbr));
fprintf(fid, 'end\n');

fprintf(fid, '\nh%s = g_h%s;\n', upper(abbr), upper(abbr));

fclose(fid);
fprintf('Function %s generation is completed!\n', fileName);


%% Create iiDestroy File
funcName = sprintf('%sDestroy', lower(abbr));
fileName = [DIR, sprintf('\\%s.m', funcName)];
fid = createFile(fileName);

% Export function head
fprintf(fid, 'function h%s = %s()\n', upper(abbr), funcName); % function header
fprintf(fid, '%% %s.m\n', funcName);
fprintf(fid, '%%\t%s Destroy an instrument handler for %s %s\n', upper(funcName), char(MM(2)), char (MM(3)));
fprintf(fid, '%%\t%s.\n', char(MM(7)));
fprintf(fid, '%%\t\n');
myStamp(fid, 'Generation of this file', '1.0.0.1');

% Export Definition;
fprintf(fid, 'global g_h%s;\n', upper(abbr));
fprintf(fid, '\n');
fprintf(fid, 'if ~isreal( g_h%s )\n', upper(abbr));
fprintf(fid, '    if strcmp( g_h%s.status, ''open'' )\n', upper(abbr));
fprintf(fid, '        fclose(g_h%s);\n', upper(abbr));
fprintf(fid, '    end\n');
fprintf(fid, '    g_h%s = [];\n', upper(abbr));
fprintf(fid, 'end\n');

fclose(fid);
fprintf('Function %s generation is completed!\n', fileName);


%% Create iiRead File
funcName = sprintf('%sRead', lower(abbr));
fileName = [DIR, sprintf('\\%s.m', funcName)];
fid = createFile(fileName);

% Export function head
fprintf(fid, 'function [data c msg] = %s()\n', funcName); % function header
fprintf(fid, '%% %s.m\n', funcName);
fprintf(fid, '%%\t%s Read char/string from %s %s\n', upper(funcName), char(MM(2)), char (MM(3)));
fprintf(fid, '%%\t\n');
myStamp(fid, 'Forward reading errors', '1.1.0.1');

% Export Definition;
fprintf(fid, 'global g_h%s;\n', upper(abbr));
fprintf(fid, '\n');

fprintf(fid, '%% Check if the instrument has been initialized\n');
fprintf(fid, 'isDestroy = 0;\n');
fprintf(fid, 'if isempty(g_h%s)\n', upper(abbr));
fprintf(fid, '    %% if not, init the instrument and prepare to destroy;\n');
fprintf(fid, '    %sInit;\n', lower(abbr));
fprintf(fid, '    isDestroy = 1; \n');
fprintf(fid, 'end\n');
fprintf(fid, '%% Check if the instrument is opened\n');
fprintf(fid, 'if strcmp( g_h%s.status, ''closed'' )\n', upper(abbr));
fprintf(fid, '    fopen(g_h%s);\n', upper(abbr));
fprintf(fid, 'end\n');
fprintf(fid, ' \n');

fprintf(fid, '%% Core operation\n');
fprintf(fid, '[data c msg] = fread(g_h%s);\n', upper(abbr));
fprintf(fid, 'data = char(data)'';\n');

fprintf(fid, ' \n');
fprintf(fid, '%% Destroy the instrument \n');
fprintf(fid, 'if isDestroy == 1\n');
fprintf(fid, '    %sDestroy;\n', lower(abbr));
fprintf(fid, 'end\n');
fprintf(fid, '\n');

fclose(fid);
fprintf('Function %s generation is completed!\n', fileName);



%% Create iiReadData File
funcName = sprintf('%sReadData', lower(abbr));
fileName = [DIR, sprintf('\\%s.m', funcName)];
fid = createFile(fileName);

% Export function head
fprintf(fid, 'function [data c msg] = %s()\n', funcName); % function header
fprintf(fid, '%% %s.m\n', funcName);
fprintf(fid, '%%\t%s Read data from %s %s\n', upper(funcName), char(MM(2)), char (MM(3)));
fprintf(fid, '%%\t\n');
myStamp(fid, 'Forward reading errors', '1.1.0.1');

% Export Definition;
fprintf(fid, 'global g_h%s;\n', upper(abbr));
fprintf(fid, '\n');

fprintf(fid, '%% Check if the instrument has been initialized\n');
fprintf(fid, 'isDestroy = 0;\n');
fprintf(fid, 'if isempty(g_h%s)\n', upper(abbr));
fprintf(fid, '    %% if not, init the instrument and prepare to destroy;\n');
fprintf(fid, '    %sInit;\n', lower(abbr));
fprintf(fid, '    isDestroy = 1; \n');
fprintf(fid, 'end\n');
fprintf(fid, '%% Check if the instrument is opened\n');
fprintf(fid, 'if strcmp( g_h%s.status, ''closed'' )\n', upper(abbr));
fprintf(fid, '    fopen(g_h%s);\n', upper(abbr));
fprintf(fid, 'end\n');
fprintf(fid, ' \n');

fprintf(fid, '%% Core operation\n');
fprintf(fid, '[data c msg] = fscanf(g_h%s, ''%%f'');\n', upper(abbr));

fprintf(fid, ' \n');
fprintf(fid, '%% Destroy the instrument \n');
fprintf(fid, 'if isDestroy == 1\n');
fprintf(fid, '    %sDestroy;\n', lower(abbr));
fprintf(fid, 'end\n');
fprintf(fid, '\n');

fclose(fid);
fprintf('Function %s generation is completed!\n', fileName);


%% Create iiWrite File
funcName = sprintf('%sWrite', lower(abbr));
fileName = [DIR, sprintf('\\%s.m', funcName)];
fid = createFile(fileName);

% Export function head
fprintf(fid, 'function %s( strCommand )\n', funcName); % function header
fprintf(fid, '%% %s.m\n', funcName);
fprintf(fid, '%%\t%s Write command to %s %s\n', upper(funcName), char(MM(2)), char (MM(3)));
fprintf(fid, '%%\t\n');
myStamp(fid, 'Forward reading errors', '1.1.0.1');

% Export Definition;
fprintf(fid, 'global g_h%s;\n', upper(abbr));
fprintf(fid, '\n');

fprintf(fid, '%% Check if the instrument has been initialized\n');
fprintf(fid, 'isDestroy = 0;\n');
fprintf(fid, 'if isempty(g_h%s)\n', upper(abbr));
fprintf(fid, '    %% if not, init the instrument and prepare to destroy;\n');
fprintf(fid, '    %sInit;\n', lower(abbr));
fprintf(fid, '    isDestroy = 1; \n');
fprintf(fid, 'end\n');
fprintf(fid, '%% Check if the instrument is opened\n');
fprintf(fid, 'if strcmp( g_h%s.status, ''closed'' )\n', upper(abbr));
fprintf(fid, '    fopen(g_h%s);\n', upper(abbr));
fprintf(fid, 'end\n');
fprintf(fid, ' \n');

fprintf(fid, '%% Core operation\n');
fprintf(fid, 'fprintf(g_h%s, strCommand);\n', upper(abbr));

fprintf(fid, ' \n');
fprintf(fid, '%% Destroy the instrument \n');
fprintf(fid, 'if isDestroy == 1\n');
fprintf(fid, '    %sDestroy;\n', lower(abbr));
fprintf(fid, 'end\n');
fprintf(fid, '\n');

fclose(fid);
fprintf('Function %s generation is completed!\n', fileName);

%% Create iiQuery File
funcName = sprintf('%sQuery', lower(abbr));
fileName = [DIR, sprintf('\\%s.m', funcName)];
fid = createFile(fileName);

% Export function head
fprintf(fid, 'function [data c msg]  = %s( strCommand )\n', funcName); % function header
fprintf(fid, '%% %s.m\n', funcName);
fprintf(fid, '%%\t%s Query char/string from %s %s\n', upper(funcName), char(MM(2)), char (MM(3)));
fprintf(fid, '%%\t\n');
myStamp(fid, 'Forward reading errors', '1.1.0.1');

% Export Definition;
fprintf(fid, 'global g_h%s;\n', upper(abbr));
fprintf(fid, '\n');

fprintf(fid, '%% Check if the instrument has been initialized\n');
fprintf(fid, 'isDestroy = 0;\n');
fprintf(fid, 'if isempty(g_h%s)\n', upper(abbr));
fprintf(fid, '    %% if not, init the instrument and prepare to destroy;\n');
fprintf(fid, '    %sInit;\n', lower(abbr));
fprintf(fid, '    isDestroy = 1; \n');
fprintf(fid, 'end\n');
fprintf(fid, '%% Check if the instrument is opened\n');
fprintf(fid, 'if strcmp( g_h%s.status, ''closed'' )\n', upper(abbr));
fprintf(fid, '    fopen(g_h%s);\n', upper(abbr));
fprintf(fid, 'end\n');
fprintf(fid, ' \n');

fprintf(fid, '%% Core operation\n');
fprintf(fid, 'fprintf(g_h%s, strCommand);\n', upper(abbr));
fprintf(fid, '[data c msg] = fread(g_h%s);\n', upper(abbr));
fprintf(fid, 'data = char(data)'';\n');

fprintf(fid, ' \n');
fprintf(fid, '%% Destroy the instrument \n');
fprintf(fid, 'if isDestroy == 1\n');
fprintf(fid, '    %sDestroy;\n', lower(abbr));
fprintf(fid, 'end\n');
fprintf(fid, '\n');

fclose(fid);
fprintf('Function %s generation is completed!\n', fileName);

%% Create iiQueryData File
funcName = sprintf('%sQueryData', lower(abbr));
fileName = [DIR, sprintf('\\%s.m', funcName)];
fid = createFile(fileName);

% Export function head
fprintf(fid, 'function [data c msg]  = %s( strCommand )\n', funcName); % function header
fprintf(fid, '%% %s.m\n', funcName);
fprintf(fid, '%%\t%s Query data from %s %s\n', upper(funcName), char(MM(2)), char (MM(3)));
fprintf(fid, '%%\t\n');
myStamp(fid, 'Forward reading errors', '1.1.0.1');

% Export Definition;
fprintf(fid, 'global g_h%s;\n', upper(abbr));
fprintf(fid, '\n');

fprintf(fid, '%% Check if the instrument has been initialized\n');
fprintf(fid, 'isDestroy = 0;\n');
fprintf(fid, 'if isempty(g_h%s)\n', upper(abbr));
fprintf(fid, '    %% if not, init the instrument and prepare to destroy;\n');
fprintf(fid, '    %sInit;\n', lower(abbr));
fprintf(fid, '    isDestroy = 1; \n');
fprintf(fid, 'end\n');
fprintf(fid, '%% Check if the instrument is opened\n');
fprintf(fid, 'if strcmp( g_h%s.status, ''closed'' )\n', upper(abbr));
fprintf(fid, '    fopen(g_h%s);\n', upper(abbr));
fprintf(fid, 'end\n');
fprintf(fid, ' \n');

fprintf(fid, '%% Core operation\n');
fprintf(fid, 'fprintf(g_h%s, strCommand);\n', upper(abbr));
fprintf(fid, '[data c msg] = fscanf(g_h%s, ''%%f'');\n', upper(abbr));

fprintf(fid, ' \n');
fprintf(fid, '%% Destroy the instrument \n');
fprintf(fid, 'if isDestroy == 1\n');
fprintf(fid, '    %sDestroy;\n', lower(abbr));
fprintf(fid, 'end\n');
fprintf(fid, '\n');

fclose(fid);
fprintf('Function %s generation is completed!\n', fileName);


%   iiInit, iiDestroy, iiRead, iiWrite, iiQuery
%   iiReadData, iiQueryData


%% VXI content

if strfind(char(MM(5)), 'VXI')>0
    %% Create iiMemRead File
    funcName = sprintf('%sMemRead', lower(abbr));
    fileName = [DIR, sprintf('\\%s.m', funcName)];
    fid = createFile(fileName);

    % Export function head
    fprintf(fid, 'function [data] = %s(varargin)\n', funcName); % function header
    fprintf(fid, '%% %s.m\n', funcName);
    fprintf(fid, '%%\t%s Read register from %s %s\n', upper(funcName), char(MM(2)), char (MM(3)));
    fprintf(fid, '%%\tFor reference, please view memread\n');
    fprintf(fid, '%%\t\n');
    myStamp(fid, 'Create of this file', '1.0.0.1');

    % Export Definition;
    fprintf(fid, 'global g_h%s;\n', upper(abbr));
    fprintf(fid, '\n');

    fprintf(fid, '%% Check if the instrument has been initialized\n');
    fprintf(fid, 'isDestroy = 0;\n');
    fprintf(fid, 'if isempty(g_h%s)\n', upper(abbr));
    fprintf(fid, '    %% if not, init the instrument and prepare to destroy;\n');
    fprintf(fid, '    %sInit;\n', lower(abbr));
    fprintf(fid, '    isDestroy = 1; \n');
    fprintf(fid, 'end\n');
    fprintf(fid, '%% Check if the instrument is opened\n');
    fprintf(fid, 'if strcmp( g_h%s.status, ''closed'' )\n', upper(abbr));
    fprintf(fid, '    fopen(g_h%s);\n', upper(abbr));
    fprintf(fid, 'end\n');
    fprintf(fid, ' \n');
    
    fprintf(fid, '%% Core operation\n');
    fprintf(fid, 'data = memread(g_h%s, varargin);\n', upper(abbr));
    
    fprintf(fid, ' \n');
    fprintf(fid, '%% Destroy the instrument \n');
    fprintf(fid, 'if isDestroy == 1\n');
    fprintf(fid, '    %sDestroy;\n', lower(abbr));
    fprintf(fid, 'end\n');
    fprintf(fid, '\n');

    fclose(fid);
    fprintf('Function %s generation is completed!\n', fileName);
    
    
    %% Create iiMemWrite File
    funcName = sprintf('%sMemWrite', lower(abbr));
    fileName = [DIR, sprintf('\\%s.m', funcName)];
    fid = createFile(fileName);

    % Export function head
    fprintf(fid, 'function %s(varargin)\n', funcName); % function header
    fprintf(fid, '%% %s.m\n', funcName);
    fprintf(fid, '%%\t%s Read register from %s %s\n', upper(funcName), char(MM(2)), char (MM(3)));
    fprintf(fid, '%%\tFor reference, please view memwrite\n');
    fprintf(fid, '%%\t\n');
    myStamp(fid, 'Create of this file', '1.0.0.1');

    % Export Definition;
    fprintf(fid, 'global g_h%s;\n', upper(abbr));
    fprintf(fid, '\n');

    fprintf(fid, '%% Check if the instrument has been initialized\n');
    fprintf(fid, 'isDestroy = 0;\n');
    fprintf(fid, 'if isempty(g_h%s)\n', upper(abbr));
    fprintf(fid, '    %% if not, init the instrument and prepare to destroy;\n');
    fprintf(fid, '    %sInit;\n', lower(abbr));
    fprintf(fid, '    isDestroy = 1; \n');
    fprintf(fid, 'end\n');
    fprintf(fid, '%% Check if the instrument is opened\n');
    fprintf(fid, 'if strcmp( g_h%s.status, ''closed'' )\n', upper(abbr));
    fprintf(fid, '    fopen(g_h%s);\n', upper(abbr));
    fprintf(fid, 'end\n');
    fprintf(fid, ' \n');
    
    fprintf(fid, '%% Core operation\n');
    fprintf(fid, 'memwrite(g_h%s, varargin);\n', upper(abbr));
    
    fprintf(fid, ' \n');
    fprintf(fid, '%% Destroy the instrument \n');
    fprintf(fid, 'if isDestroy == 1\n');
    fprintf(fid, '    %sDestroy;\n', lower(abbr));
    fprintf(fid, 'end\n');
    fprintf(fid, '\n');

    fclose(fid);
    fprintf('Function %s generation is completed!\n', fileName);    
    
    
end

