function hAFG = afgDestroy()
% afgDestroy.m
%	AFGDESTROY Destroy an instrument handler for Tektronix AFG320
%	Arbitrary Function Generator.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:12 $

global g_hAFG;

if ~isreal( g_hAFG )
    if strcmp( g_hAFG.status, 'open' )
        fclose(g_hAFG);
    end
    g_hAFG = [];
end
