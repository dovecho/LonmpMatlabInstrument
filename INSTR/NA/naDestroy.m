function hNA = naDestroy()
% naDestroy.m
%	NADESTROY Destroy an instrument handler for Agilent 8510C
%	Network Analyzer.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:09 $

global g_hNA;

if ~isreal( g_hNA )
    if strcmp( g_hNA.status, 'open' )
        fclose(g_hNA);
    end
    g_hNA = [];
end
