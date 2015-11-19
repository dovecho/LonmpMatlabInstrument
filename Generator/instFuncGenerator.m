function [cnt] = instFuncGenerator ( str_inst, str_func, str_note)
% instFuncGenerator
%   INSTFUNCGENERATOR build the functioning I/O operations for a 
%   specific initrument, normally needs aditional editing.
%
% 	str_inst,	% Instrument String, e.g. 'las' for Laser
%	str_func,	% Name of the funciton
%	str_note,	% Note for the function
%
%   Copyright (c) 2012 - 2015, LONMP, Tsinghua University,
%   Written by Shangyuan Li,
%
%   Revision Note: New function to generate function generator
%   $Version: 1.0 $	$Date: 2015-11-19 22:44:51 $


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
		fprintf(fid, 'function [%s] = %s_%s (  )\n', rst, str_inst, str_func);
	case 1 % parameters
		fprintf(fid, 'function [%s] = %s_%s ( %s )\n', rst, str_inst, str_func, rst);
	case 2 % control
		fprintf(fid, 'function %s_%s ( isRemind )\n', str_inst, str_func);
end

% Notes
fprintf(fid, '%% %s_%s\t%s\n%%\n', str_inst, str_func, str_note);

if cmdType == 2
	fprintf(fid, '%%\t%-8s :\t%s\n%%\n', 'isRemind', '1 for remind' );
else
	fprintf(fid, '%%\t%-8s :\t%s (%s)\n%%\n', rst, str_note, str_unit );
end

myStamp(fid, 'Initialize of this function', '1.0');

% Main Function 
fclose(fid);

fprintf('Function %s generation completed!\n', fileName);

