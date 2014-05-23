function [data c msg] = pnaRead()
% pnaRead.m
%	PNAREAD Read char/string from Agilent E8364B
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:09 $

global g_hPNA;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hPNA)
    % if not, init the instrument and prepare to destroy;
    pnaInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hPNA.status, 'closed' )
    fopen(g_hPNA);
end
 
% Core operation
[data c msg] = fread(g_hPNA);
data = char(data)';
 
% Destroy the instrument 
if isDestroy == 1
    pnaDestroy;
end

