function hDC = dcDestroy()
% dcDestroy.m
%	DCDESTROY Destroy an instrument handler for Itech IT6322
%	DC Power Supply.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:11 $

global g_hDC;

if ~isreal( g_hDC )
    if strcmp( g_hDC.status, 'open' )
        fclose(g_hDC);
    end
    g_hDC = [];
end
