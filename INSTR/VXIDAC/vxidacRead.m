function [data c msg] = vxidacRead()
% vxidacRead.m
%	VXIDACREAD Read char/string from Agilent E1418A
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-28 13:42:06 $

global g_hVXIDAC;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hVXIDAC)
    % if not, init the instrument and prepare to destroy;
    vxidacInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hVXIDAC.status, 'closed' )
    fopen(g_hVXIDAC);
end
 
% Core operation
[data c msg] = fread(g_hVXIDAC);
data = char(data)';
 
% Destroy the instrument 
if isDestroy == 1
    vxidacDestroy;
end

