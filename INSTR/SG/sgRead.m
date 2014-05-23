function [data c msg] = sgRead()
% sgRead.m
%	SGREAD Read char/string from Agilent E8257D
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:07 $

global g_hSG;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hSG)
    % if not, init the instrument and prepare to destroy;
    sgInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hSG.status, 'closed' )
    fopen(g_hSG);
end
 
% Core operation
[data c msg] = fread(g_hSG);
data = char(data)';
 
% Destroy the instrument 
if isDestroy == 1
    sgDestroy;
end

