function [data c msg]  = pwsQueryData( strCommand )
% pwsQueryData.m
%	PWSQUERYDATA Query data from Agilent U2002H
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:11 $

global g_hPWS;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hPWS)
    % if not, init the instrument and prepare to destroy;
    pwsInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hPWS.status, 'closed' )
    fopen(g_hPWS);
end
 
% Core operation
fprintf(g_hPWS, strCommand);
[data c msg] = fscanf(g_hPWS, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    pwsDestroy;
end

