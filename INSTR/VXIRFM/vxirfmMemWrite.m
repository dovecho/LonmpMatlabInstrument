function vxirfmMemWrite(varargin)
% vxirfmMemWrite.m
%	VXIRFMMEMWRITE Read register from Agilent E1472A
%	For reference, please view memwrite
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Create of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-28 13:42:08 $

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
memwrite(g_hVXIRFM, varargin);
 
% Destroy the instrument 
if isDestroy == 1
    vxirfmDestroy;
end

