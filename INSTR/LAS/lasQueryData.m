function [data c msg]  = lasQueryData( strCommand )
% lasQueryData.m
%	LASQUERYDATA Query data from Agilent 8164A
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:09 $

global g_hLAS;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hLAS)
    % if not, init the instrument and prepare to destroy;
    lasInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hLAS.status, 'closed' )
    fopen(g_hLAS);
end
 
% Core operation
fprintf(g_hLAS, strCommand);
[data c msg] = fscanf(g_hLAS, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    lasDestroy;
end

