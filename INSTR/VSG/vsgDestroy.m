function hVSG = vsgDestroy()
% vsgDestroy.m
%	VSGDESTROY Destroy an instrument handler for Agilent E8267D
%	PSG Vector Signal Generator.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:07 $

global g_hVSG;

if ~isreal( g_hVSG )
    if strcmp( g_hVSG.status, 'open' )
        fclose(g_hVSG);
    end
    g_hVSG = [];
end
