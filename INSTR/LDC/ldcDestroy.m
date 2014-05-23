function hLDC = ldcDestroy()
% ldcDestroy.m
%	LDCDESTROY Destroy an instrument handler for ILX Lightwave LDC-3724B
%	Laser Diode Controller.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:10 $

global g_hLDC;

if ~isreal( g_hLDC )
    if strcmp( g_hLDC.status, 'open' )
        fclose(g_hLDC);
    end
    g_hLDC = [];
end
