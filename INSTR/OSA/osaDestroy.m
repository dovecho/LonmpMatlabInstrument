function hOSA = osaDestroy()
% osaDestroy.m
%	OSADESTROY Destroy an instrument handler for Advantest Q8384
%	Optical Spectrum Analyzer.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:11 $

global g_hOSA;

if ~isreal( g_hOSA )
    if strcmp( g_hOSA.status, 'open' )
        fclose(g_hOSA);
    end
    g_hOSA = [];
end
