function [data c msg] = osaReadData()
% osaReadData.m
%	OSAREADDATA Read data from Advantest Q8384
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
[data c msg] = fscanf(g_hOSA, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    osaDestroy;
end

