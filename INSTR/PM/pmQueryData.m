function [data c msg]  = pmQueryData( strCommand )
% pmQueryData.m
%	PMQUERYDATA Query data from Agilent 437B
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:12 $

global g_hPM;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hPM)
    % if not, init the instrument and prepare to destroy;
    pmInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hPM.status, 'closed' )
    fopen(g_hPM);
end
 
% Core operation
fprintf(g_hPM, strCommand);
[data c msg] = fscanf(g_hPM, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    pmDestroy;
end

