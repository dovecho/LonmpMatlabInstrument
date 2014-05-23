function [data c msg] = vxirfmRead()
% vxirfmRead.m
%	VXIRFMREAD Read char/string from Agilent E1472A
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-28 13:42:07 $

global g_hVXIRFM;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hVXIRFM)
    % if not, init the instrument and prepare to destroy;
    vxirfmInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hVXIRFM.status, 'closed' )
    fopen(g_hVXIRFM);
end
 
% Core operation
[data c msg] = fread(g_hVXIRFM);
data = char(data)';
 
% Destroy the instrument 
if isDestroy == 1
    vxirfmDestroy;
end

