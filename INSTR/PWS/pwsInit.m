function hPWS = pwsInit( addr )
% pwsInit.m
%	PWSINIT Initialize an instrument handler for Agilent U2002H
%	Power Sensor.
%	
%	g_hPWS	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:11 $


globalADDR;

global g_hPWS;
global g_addr_usb_PWS;

if nargin == 1
    addr_PWS = addr;
else
    addr_PWS = g_addr_usb_PWS;  % Default 
end
pwsDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'USB')>0 & strfind(char(vf(ivf)), num2str(addr_PWS))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hPWS = ', strAddr]);
set(g_hPWS,'InputBufferSize', 200000);
fopen(g_hPWS);
if strcmp (g_hPWS.Status, 'closed') == 1
    fopen(g_hPWS);
end

hPWS = g_hPWS;
