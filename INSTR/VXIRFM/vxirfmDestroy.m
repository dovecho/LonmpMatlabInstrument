function hVXIRFM = vxirfmDestroy()
% vxirfmDestroy.m
%	VXIRFMDESTROY Destroy an instrument handler for Agilent E1472A
%	RF Multiplexer.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-28 13:42:07 $

global g_hVXIRFM;

if ~isreal( g_hVXIRFM )
    if strcmp( g_hVXIRFM.status, 'open' )
        fclose(g_hVXIRFM);
    end
    g_hVXIRFM = [];
end
