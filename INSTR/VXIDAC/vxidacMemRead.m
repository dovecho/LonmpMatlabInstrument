function [data] = vxidacMemRead(varargin)
% vxidacMemRead.m
%	VXIDACMEMREAD Read register from Agilent E1418A
%	For reference, please view memread
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Create of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-28 13:42:07 $

global g_hVXIDAC;

% Check if the instrument has been initialized
isDestroy = 0;
if isempty(g_hVXIDAC)
    % if not, init the instrument and prepare to destroy;
    vxidacInit;
    isDestroy = 1; 
end
% Check if the instrument is opened
if strcmp( g_hVXIDAC.status, 'closed' )
    fopen(g_hVXIDAC);
end
 
% Core operation
data = memread(g_hVXIDAC, varargin);
 
% Destroy the instrument 
if isDestroy == 1
    vxidacDestroy;
end

