function [data c msg]  = mxgQueryData( strCommand )
% mxgQueryData.m
%	MXGQUERYDATA Query data from Agilent N5183A
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:08 $

global g_hMXG;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hMXG)
    % if not, init the instrument and prepare to destroy;
    mxgInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hMXG.status, 'closed' )
    fopen(g_hMXG);
end
 
% Core operation
fprintf(g_hMXG, strCommand);
[data c msg] = fscanf(g_hMXG, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    mxgDestroy;
end

