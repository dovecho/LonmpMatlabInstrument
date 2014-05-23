function [data c msg] = dcaReadData()
% dcaReadData.m
%	DCAREADDATA Read data from Agilent 86100C
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:08 $

global g_hDCA;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hDCA)
    % if not, init the instrument and prepare to destroy;
    dcaInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hDCA.status, 'closed' )
    fopen(g_hDCA);
end
 
% Core operation
[data c msg] = fscanf(g_hDCA, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    dcaDestroy;
end

