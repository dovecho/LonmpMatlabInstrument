function hDCA = dcaDestroy()
% dcaDestroy.m
%	DCADESTROY Destroy an instrument handler for Agilent 86100C
%	Digital Communication Analyzer.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:08 $

global g_hDCA;

if ~isreal( g_hDCA )
    if strcmp( g_hDCA.status, 'open' )
        fclose(g_hDCA);
    end
    g_hDCA = [];
end
