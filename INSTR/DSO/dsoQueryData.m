function [data c msg]  = dsoQueryData( strCommand )
% dsoQueryData.m
%	DSOQUERYDATA Query data from Agilent 81204B
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:08 $

global g_hDSO;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hDSO)
    % if not, init the instrument and prepare to destroy;
    dsoInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hDSO.status, 'closed' )
    fopen(g_hDSO);
end
 
% Core operation
fprintf(g_hDSO, strCommand);
[data c msg] = fscanf(g_hDSO, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    dsoDestroy;
end

