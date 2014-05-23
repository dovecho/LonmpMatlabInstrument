% initGlobalADDR
%   To build the GLOBALADDR file for instrument control
%   The source library is 'globalADDR.csv' file.
%   Each line of the '.csv' file is for ONE instrument.
%
%   Abbr    Brand   Model   Vendor    Type     Addr   Info   BaudRate
%
%   e.g. for VSG E8267D, the information is
%   VSG,Agilent,E8267D,AGILENT,GPIB,22,Vector Signal Generator
%
%
%	Copyright 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Add Baud-rate to this file
%	$Version: 1.1.0.1 $	$Date: 2012-05-19 11:21:11 $
%
%% Create file
fileName = '..\globalADDR.m';
fid = fopen(fileName);
if (fid < 0)
	fid = fopen(fileName, 'w+');
else
	reply = input('File exist, overwrite? Y/N [Y]: ', 's');
	if isempty(reply)
		reply = 'Y';
	end
	if (reply == 'Y' || reply == 'y')
		fclose(fid);
		fid = fopen(fileName, 'w');
		display('File Overwritten.');
	else
		display('Processing Terminated!');
		return;	
	end
end

%% Export function head
fprintf(fid, '%% globalADDR.m\n');
fprintf(fid, '%%\tGLOBALADDR Predefines ADDR for all GPIB instruments in our lab\n');
myStamp(fid, 'Add baud_rate for COM', '1.1.0.1');

%% Processing Function body
[a b M] = xlsread('..\globalADDR.xlsx');
instType = {'GPIB';'LAN';'VXI';'ASRL';'USB';};

% Write instrument handler, dealing with 'Abbr'
fprintf(fid,'%% Instrument Handler\n\n');
for i = 2 : size(M,1)
    % instrument handler
    for iType = 1 : length(instType)
        strType = char(instType(iType));
        if strfind(char(M(i,5)), strType)>0
            switch strType
                case 'LAN'
                    sHandle = sprintf('g_addr_lan_%s', char(M(i,1)));
                case 'USB'
                    sHandle = sprintf('g_addr_usb_%s', char(M(i,1)));
                case 'ASRL'
                    sHandle = sprintf('g_addr_asrl_%s', char(M(i,1)));
                case 'VXI'
                    sHandle = sprintf('g_addr_%s', char(M(i,1)));
                otherwise
        %         case 'GPIB'
                    sHandle = sprintf('g_addr_%s', char(M(i,1)));
            end % switch
            fprintf(fid,'global %20s;  \t\t%% %s %s %s\n', sHandle,...
                char(M(i,2)),char(M(i,3)),char(M(i,7)));
        end % if
    end % iType
    
end % i
fprintf(fid,'\n');

% Write instrument address, dealing with 'Addr'

fprintf(fid,'%% Instrument Address\n\n');


% for different type of instrument
for iType = 1 : length(instType)
    strType = char(instType(iType));
    fprintf(fid, '%% %s Instrument\n', strType);
    % with different process
    for i = 2 : size(M,1)
        if strfind(char(M(i,5)), strType)>0
            switch strType
                case 'LAN'
                    sHandle = sprintf('g_addr_lan_%s', char(M(i,1)));
                    fprintf(fid,'%20s = %2d;', sHandle, 0);
                case 'USB'
                    sHandle = sprintf('g_addr_usb_%s', char(M(i,1)));
                    fprintf(fid,'%20s = %2d;', sHandle, 0);
                case 'ASRL'
                    fprintf(fid, '%20s = %d;\n', ['baud_',char(M(i,1))], cell2mat(M(i,8)));
                    sHandle = sprintf('g_addr_asrl_%s', char(M(i,1)));
                    fprintf(fid,'%20s = %2d;', sHandle, 0);
                case 'VXI'
                    sHandle = sprintf('g_addr_%s', char(M(i,1)));
                    fprintf(fid,'%20s = %2d;', sHandle, 0);
                otherwise
%                 case 'GPIB'
                    sHandle = sprintf('g_addr_%s', char(M(i,1)));
                    fprintf(fid,'%20s = %2d;', sHandle, cell2mat(M(i,6)));
            end % switch
            
            fprintf(fid, '\t\t%% %s %s %s\n', char(M(i,2)),char(M(i,3)),char(M(i,7)));
        end % if
    end % i
    fprintf(fid, '\n');
end % iType
fprintf(fid,'\n');

%%
fclose(fid);
fprintf('Function %s generation completed!\n', fileName);
