function [cnt] = instFuncGenerator ( str_inst, str_func, str_cmd, str_note,...
	str_unit, cmdType, str_par )
% instFuncGenerator
%   INSTFUNCGENERATOR build the functioning I/O operation for a specific
%   Initrument, according to the specified parameters
%
% 	str_inst,	% Instrument String, e.g. 'las' for Laser
%	str_func,	% Name of the function
%	str_note,	% Note for the function
%	str_cmd,	% Command String
%	cmdType		% 0 for ATTRIBUTE, 1 for PARAMETERS, 2 for CONTROL
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Second review of this file
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 11:10:32 $


% instFuncGenerator
% try to open file
fileName = ['..\INSTR\', str_inst, '\', lower(str_inst), str_func, '.m'];
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

rst = sprintf('rst_%s', str_func);

% function name
% e.g. ''function [er] = edER()''
switch cmdType 
	case 0 % Attribute
		fprintf(fid, 'function [%s] = %s%s (  )\n', rst, str_inst, str_func);
	case 1 % parameters
		fprintf(fid, 'function [%s] = %s%s ( %s )\n', rst, str_inst, str_func, rst);
	case 2 % control
		fprintf(fid, 'function %s%s ( isRemind )\n', str_inst, str_func);
end

% Notes
fprintf(fid, '%% %s%s\t%s\n%%\n', str_inst, str_func, str_note);

if cmdType == 2
	fprintf(fid, '%%\t%-8s :\t%s\n%%\n', 'isRemind', '1 for remind' );
else
	fprintf(fid, '%%\t%-8s :\t%s (%s)\n%%\n', rst, str_note, str_unit );
end

myStamp(fid, 'Update of this file', '2.1.0.1');

% % GPIB Check
% fprintf(fid, '%% Define global object of %s\n', upper(str_inst));
% fprintf(fid, 'global g_h%s;\n\n', upper(str_inst));
% 
% fprintf(fid, '%% Initialize and open GPIB of %s\n', upper(str_inst));
% fprintf(fid, 'if isempty(g_h%s)\n\t%sInit;\nend\n\n', upper(str_inst), str_inst);
% 
% fprintf(fid, 'if strcmp( g_h%s.status, \''closed\'' )\n\tfopen(g_h%s);\nend\n\n',upper(str_inst), upper(str_inst));

% Main Function 

switch cmdType
	case 2
		fprintf(fid, 'if nargin > 0\n');
		fprintf(fid, '	if isRemind == 1\n');
		fprintf(fid, '		reply = input(\''Really %s? [Y]\'');\n', str_note);
		fprintf(fid, '		beep;\n');
		fprintf(fid, '		if isempty(reply) || reply == \''y\'' || reply == \''Y\'' || reply == \''1\'' || reply == 1\n');
		fprintf(fid, '			%sWrite(\''%s\'');\n', str_inst, str_cmd);
		fprintf(fid, '		end\n');
		fprintf(fid, '	end\n');
		fprintf(fid, 'else\n');
		fprintf(fid, '	%sWrite(\''%s\'');\n', str_inst, str_cmd);
		fprintf(fid, 'end\n');
	case 1
		fprintf(fid, '%% Setting and Reading\n');
		fprintf(fid, 'if nargin > 0\n');
		if nargin == 7
			fprintf(fid, '    %sWrite(sprintf(\''%s %s\'', %s));\n', lower(str_inst), upper(str_cmd), str_par, rst );
		else
			fprintf(fid, '    %sWrite(sprintf(\''%s %%f\'', %s));\n', lower(str_inst), upper(str_cmd), rst );
		end
		fprintf(fid, 'end\n\n');
		fprintf(fid, '%sWrite(\''%s?\'');\n', str_inst, upper(str_cmd) );
		fprintf(fid, '%s = %sReadData;\n', rst, str_inst);
	case 0
		fprintf(fid, '%sWrite(\''%s?\'');\n', str_inst, upper(str_cmd) );
		fprintf(fid, '%s = %sReadData;\n', rst, str_inst);
end

fclose(fid);

fprintf('Function %s generation completed!\n', fileName);

