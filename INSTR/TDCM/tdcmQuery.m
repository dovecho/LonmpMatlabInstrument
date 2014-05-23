function [data c msg]  = tdcmQuery( strCommand )
% tdcmQuery.m
%	TDCMQUERY Query char/string from TeraXion TDCM30
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:11 $

global g_hTDCM;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hTDCM)
    % if not, init the instrument and prepare to destroy;
    tdcmInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hTDCM.status, 'closed' )
    fopen(g_hTDCM);
end
 
% Core operation
fprintf(g_hTDCM, strCommand);
[data c msg] = fread(g_hTDCM);
data = char(data)';
 
% Destroy the instrument 
if isDestroy == 1
    tdcmDestroy;
end

