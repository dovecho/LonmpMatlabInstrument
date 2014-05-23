function hVXIDAC = vxidacDestroy()
% vxidacDestroy.m
%	VXIDACDESTROY Destroy an instrument handler for Agilent E1418A
%	Digital to Analog Converter.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-28 13:42:06 $

global g_hVXIDAC;

if ~isreal( g_hVXIDAC )
    if strcmp( g_hVXIDAC.status, 'open' )
        fclose(g_hVXIDAC);
    end
    g_hVXIDAC = [];
end
