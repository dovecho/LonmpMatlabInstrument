function hTDS = tdsDestroy()
% tdsDestroy.m
%	TDSDESTROY Destroy an instrument handler for Tektronix TDS220
%	Digital Real-time Oscilloscope.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:09 $

global g_hTDS;

if ~isreal( g_hTDS )
    if strcmp( g_hTDS.status, 'open' )
        fclose(g_hTDS);
    end
    g_hTDS = [];
end
