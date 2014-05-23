function hESG = esgDestroy()
% esgDestroy.m
%	ESGDESTROY Destroy an instrument handler for Agilent E4433B
%	ESG-D Series Signal Generator.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:10 $

global g_hESG;

if ~isreal( g_hESG )
    if strcmp( g_hESG.status, 'open' )
        fclose(g_hESG);
    end
    g_hESG = [];
end
