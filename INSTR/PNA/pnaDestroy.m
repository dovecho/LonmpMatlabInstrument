function hPNA = pnaDestroy()
% pnaDestroy.m
%	PNADESTROY Destroy an instrument handler for Agilent E8364B
%	PNA Network Analyzer.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:09 $

global g_hPNA;

if ~isreal( g_hPNA )
    if strcmp( g_hPNA.status, 'open' )
        fclose(g_hPNA);
    end
    g_hPNA = [];
end
