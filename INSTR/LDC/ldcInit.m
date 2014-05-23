function hLDC = ldcInit( addr )
% ldcInit.m
%	LDCINIT Initialize an instrument handler for ILX Lightwave LDC-3724B
%	Laser Diode Controller.
%	
%	g_hLDC	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:10 $


globalADDR;

global g_hLDC;
global g_addr_LDC;

if nargin == 1
    addr_LDC = addr;
else
    addr_LDC = g_addr_LDC;  % Default 
end
ldcDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_LDC))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hLDC = ', strAddr]);
set(g_hLDC,'InputBufferSize', 200000);
fopen(g_hLDC);
if strcmp (g_hLDC.Status, 'closed') == 1
    fopen(g_hLDC);
end

hLDC = g_hLDC;
