function vximwswMemWrite(varargin)
% vximwswMemWrite.m
%	VXIMWSWMEMWRITE Read register from Agilent E1368A
%	For reference, please view memwrite
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Create of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-28 13:42:06 $

global g_hVXIMWSW;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hVXIMWSW)
    % if not, init the instrument and prepare to destroy;
    vximwswInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hVXIMWSW.status, 'closed' )
    fopen(g_hVXIMWSW);
end
 
% Core operation
memwrite(g_hVXIMWSW, varargin);
 
% Destroy the instrument 
if isDestroy == 1
    vximwswDestroy;
end

