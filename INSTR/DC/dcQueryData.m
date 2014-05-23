function [data c msg]  = dcQueryData( strCommand )
% dcQueryData.m
%	DCQUERYDATA Query data from Itech IT6322
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:11 $

global g_hDC;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hDC)
    % if not, init the instrument and prepare to destroy;
    dcInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hDC.status, 'closed' )
    fopen(g_hDC);
end
 
% Core operation
fprintf(g_hDC, strCommand);
[data c msg] = fscanf(g_hDC, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    dcDestroy;
end

