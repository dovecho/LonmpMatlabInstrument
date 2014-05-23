function hPWS = pwsDestroy()
% pwsDestroy.m
%	PWSDESTROY Destroy an instrument handler for Agilent U2002H
%	Power Sensor.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:11 $

global g_hPWS;

if ~isreal( g_hPWS )
    if strcmp( g_hPWS.status, 'open' )
        fclose(g_hPWS);
    end
    g_hPWS = [];
end
