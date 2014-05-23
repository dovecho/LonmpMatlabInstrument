function [data c msg] = dmmRead()
% dmmRead.m
%	DMMREAD Read char/string from Fluke 8840A
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:11 $

global g_hDMM;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hDMM)
    % if not, init the instrument and prepare to destroy;
    dmmInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hDMM.status, 'closed' )
    fopen(g_hDMM);
end
 
% Core operation
[data c msg] = fread(g_hDMM);
data = char(data)';
 
% Destroy the instrument 
if isDestroy == 1
    dmmDestroy;
end

