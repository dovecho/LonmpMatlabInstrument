function hMXG = mxgDestroy()
% mxgDestroy.m
%	MXGDESTROY Destroy an instrument handler for Agilent N5183A
%	MXG Signal Generator.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:08 $

global g_hMXG;

if ~isreal( g_hMXG )
    if strcmp( g_hMXG.status, 'open' )
        fclose(g_hMXG);
    end
    g_hMXG = [];
end
