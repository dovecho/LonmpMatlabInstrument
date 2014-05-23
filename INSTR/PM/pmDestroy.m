function hPM = pmDestroy()
% pmDestroy.m
%	PMDESTROY Destroy an instrument handler for Agilent 437B
%	Power Meter.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:12 $

global g_hPM;

if ~isreal( g_hPM )
    if strcmp( g_hPM.status, 'open' )
        fclose(g_hPM);
    end
    g_hPM = [];
end
