function hDMM = dmmDestroy()
% dmmDestroy.m
%	DMMDESTROY Destroy an instrument handler for Fluke 8840A
%	Digital Multimeter.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:11 $

global g_hDMM;

if ~isreal( g_hDMM )
    if strcmp( g_hDMM.status, 'open' )
        fclose(g_hDMM);
    end
    g_hDMM = [];
end
