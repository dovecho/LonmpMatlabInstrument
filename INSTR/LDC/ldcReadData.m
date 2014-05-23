function [data c msg] = ldcReadData()
% ldcReadData.m
%	LDCREADDATA Read data from ILX Lightwave LDC-3724B
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:10 $

global g_hLDC;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hLDC)
    % if not, init the instrument and prepare to destroy;
    ldcInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hLDC.status, 'closed' )
    fopen(g_hLDC);
end
 
% Core operation
[data c msg] = fscanf(g_hLDC, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    ldcDestroy;
end

