function hED = edDestroy()
% edDestroy.m
%	EDDESTROY Destroy an instrument handler for Anritsu MP1762A
%	Error Detector.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:10 $

global g_hED;

if ~isreal( g_hED )
    if strcmp( g_hED.status, 'open' )
        fclose(g_hED);
    end
    g_hED = [];
end
