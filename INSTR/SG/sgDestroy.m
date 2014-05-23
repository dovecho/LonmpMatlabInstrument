function hSG = sgDestroy()
% sgDestroy.m
%	SGDESTROY Destroy an instrument handler for Agilent E8257D
%	PSG Signal Generator.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:07 $

global g_hSG;

if ~isreal( g_hSG )
    if strcmp( g_hSG.status, 'open' )
        fclose(g_hSG);
    end
    g_hSG = [];
end
