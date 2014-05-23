function hVXIMWSW = vximwswDestroy()
% vximwswDestroy.m
%	VXIMWSWDESTROY Destroy an instrument handler for Agilent E1368A
%	Microwave Switch & Driver Module.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-28 13:42:06 $

global g_hVXIMWSW;

if ~isreal( g_hVXIMWSW )
    if strcmp( g_hVXIMWSW.status, 'open' )
        fclose(g_hVXIMWSW);
    end
    g_hVXIMWSW = [];
end
