function [data c msg] = afgReadData()
% afgReadData.m
%	AFGREADDATA Read data from Tektronix AFG320
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:12 $

global g_hAFG;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hAFG)
    % if not, init the instrument and prepare to destroy;
    afgInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hAFG.status, 'closed' )
    fopen(g_hAFG);
end
 
% Core operation
[data c msg] = fscanf(g_hAFG, '%f');
 
% Destroy the instrument 
if isDestroy == 1
    afgDestroy;
end

