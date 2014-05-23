function hDSO = dsoDestroy()
% dsoDestroy.m
%	DSODESTROY Destroy an instrument handler for Agilent 81204B
%	Digital Sample Oscilloscope.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:08 $

global g_hDSO;

if ~isreal( g_hDSO )
    if strcmp( g_hDSO.status, 'open' )
        fclose(g_hDSO);
    end
    g_hDSO = [];
end
