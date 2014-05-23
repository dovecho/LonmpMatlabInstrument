function edWrite( strCommand )
% edWrite.m
%	EDWRITE Write command to Anritsu MP1762A
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:10 $

global g_hED;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hED)
    % if not, init the instrument and prepare to destroy;
    edInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hED.status, 'closed' )
    fopen(g_hED);
end
 
% Core operation
fprintf(g_hED, strCommand);
 
% Destroy the instrument 
if isDestroy == 1
    edDestroy;
end

