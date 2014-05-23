function hPSA = psaDestroy()
% psaDestroy.m
%	PSADESTROY Destroy an instrument handler for Agilent E4446A
%	PSA Series Spectrum Analyzer.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:08 $

global g_hPSA;

if ~isreal( g_hPSA )
    if strcmp( g_hPSA.status, 'open' )
        fclose(g_hPSA);
    end
    g_hPSA = [];
end
