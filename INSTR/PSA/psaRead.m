function [data c msg] = psaRead()
% psaRead.m
%	PSAREAD Read char/string from Agilent E4446A
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:08 $

global g_hPSA;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hPSA)
    % if not, init the instrument and prepare to destroy;
    psaInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hPSA.status, 'closed' )
    fopen(g_hPSA);
end
 
% Core operation
[data c msg] = fread(g_hPSA);
data = char(data)';
 
% Destroy the instrument 
if isDestroy == 1
    psaDestroy;
end

