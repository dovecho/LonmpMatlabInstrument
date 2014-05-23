function [data c msg]  = naQueryData( strCommand )
% naQueryData.m
%	NAQUERYDATA Query data from Agilent 8510C
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:09 $

global g_hNA;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hNA)
    % if not, init the instrument and prepare to destroy;
    naInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hNA.status, 'closed' )
    fopen(g_hNA);
end
 
% Core operation
fprintf(g_hNA, strCommand);
[data c msg] = fscanf(g_hNA, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    naDestroy;
end

