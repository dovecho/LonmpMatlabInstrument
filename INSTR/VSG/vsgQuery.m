function [data c msg]  = vsgQuery( strCommand )
% vsgQuery.m
%	VSGQUERY Query char/string from Agilent E8267D
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:07 $

global g_hVSG;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hVSG)
    % if not, init the instrument and prepare to destroy;
    vsgInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hVSG.status, 'closed' )
    fopen(g_hVSG);
end
 
% Core operation
fprintf(g_hVSG, strCommand);
[data c msg] = fread(g_hVSG);
data = char(data)';
 
% Destroy the instrument 
if isDestroy == 1
    vsgDestroy;
end

