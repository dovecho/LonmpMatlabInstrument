function hTDCM = tdcmDestroy()
% tdcmDestroy.m
%	TDCMDESTROY Destroy an instrument handler for TeraXion TDCM30
%	Tunable Dispersion Compensator Module.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:11 $

global g_hTDCM;

if ~isreal( g_hTDCM )
    if strcmp( g_hTDCM.status, 'open' )
        fclose(g_hTDCM);
    end
    g_hTDCM = [];
end
