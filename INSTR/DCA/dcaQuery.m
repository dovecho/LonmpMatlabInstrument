function [data c msg]  = dcaQuery( strCommand )
% dcaQuery.m
%	DCAQUERY Query char/string from Agilent 86100C
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:09 $

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
fprintf(g_hDCA, strCommand);
[data c msg] = fread(g_hDCA);
data = char(data)';
 
% Destroy the instrument 
if isDestroy == 1
    dcaDestroy;
end

