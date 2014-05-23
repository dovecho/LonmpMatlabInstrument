function hPPG = ppgDestroy()
% ppgDestroy.m
%	PPGDESTROY Destroy an instrument handler for Anritsu MP1761B
%	Pulse Pattern Generator.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:10 $

global g_hPPG;

if ~isreal( g_hPPG )
    if strcmp( g_hPPG.status, 'open' )
        fclose(g_hPPG);
    end
    g_hPPG = [];
end
