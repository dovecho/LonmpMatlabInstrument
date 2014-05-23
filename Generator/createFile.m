function fid = createFile(fileName)
%createFile.m
%   createFile create a file, and check if it is exist
%
%	Copyright 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Change to Function type
%	$Version: 1.1.0.1 $	$Date: 2012-05-19 10:14:01 $


fid = fopen(fileName);
if (fid < 0)
	fid = fopen(fileName, 'w+');
else
	reply = input(sprintf('File ''%s'' exist, overwrite? Y/N [Y]: ', upper(fileName)), 's');
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
