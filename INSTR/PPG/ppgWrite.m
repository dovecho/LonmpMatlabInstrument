function ppgWrite( strCommand )
% ppgWrite.m
%	PPGWRITE Write command to Anritsu MP1761B
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Forward reading errors
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:50:10 $

global g_hPPG;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hPPG)
    % if not, init the instrument and prepare to destroy;
    ppgInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hPPG.status, 'closed' )
    fopen(g_hPPG);
end
 
% Core operation
fprintf(g_hPPG, strCommand);
 
% Destroy the instrument 
if isDestroy == 1
    ppgDestroy;
end

