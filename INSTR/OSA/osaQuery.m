function [data c msg]  = osaQuery( strCommand )
% osaQuery.m
%	OSAQUERY Query char/string from Advantest Q8384
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:11 $

global g_hOSA;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hOSA)
    % if not, init the instrument and prepare to destroy;
    osaInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hOSA.status, 'closed' )
    fopen(g_hOSA);
end
 
% Core operation
fprintf(g_hOSA, strCommand);
[data c msg] = fread(g_hOSA);
data = char(data)';
 
% Destroy the instrument 
if isDestroy == 1
    osaDestroy;
end

