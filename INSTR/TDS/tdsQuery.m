function [data c msg]  = tdsQuery( strCommand )
% tdsQuery.m
%	TDSQUERY Query char/string from Tektronix TDS220
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:09 $

global g_hTDS;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hTDS)
    % if not, init the instrument and prepare to destroy;
    tdsInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hTDS.status, 'closed' )
    fopen(g_hTDS);
end
 
% Core operation
fprintf(g_hTDS, strCommand);
[data c msg] = fread(g_hTDS);
data = char(data)';
 
% Destroy the instrument 
if isDestroy == 1
    tdsDestroy;
end

