function lasOn ( isRemind )
% lasOn	Turn on the laser
%
%	isRemind :	1 for remind
%
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Update of this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 11:16:38 $

% Define global object of LAS
global g_hLAS;

% Initialize and open GPIB of LAS
if isempty(g_hLAS)
	lasInit;
end

if strcmp( g_hLAS.status, 'closed' )
	fopen(g_hLAS);
end

if nargin > 0
	if isRemind == 1
		reply = input('Really Turn on the laser? [Y]');
		beep;
		if isempty(reply) || reply == 'y' || reply == 'Y' || reply == '1' || reply == 1
			lasWrite('outp on');
		end
	end
else
	lasWrite('outp on');
end
