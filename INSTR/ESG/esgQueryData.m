function [data c msg]  = esgQueryData( strCommand )
% esgQueryData.m
%	ESGQUERYDATA Query data from Agilent E4433B
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:10 $

global g_hESG;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hESG)
    % if not, init the instrument and prepare to destroy;
    esgInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hESG.status, 'closed' )
    fopen(g_hESG);
end
 
% Core operation
fprintf(g_hESG, strCommand);
[data c msg] = fscanf(g_hESG, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    esgDestroy;
end

