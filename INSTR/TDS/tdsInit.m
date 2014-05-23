function hTDS = tdsInit( addr )
% tdsInit.m
%	TDSINIT Initialize an instrument handler for Tektronix TDS220
%	Digital Real-time Oscilloscope.
%	
%	g_hTDS	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:09 $


globalADDR;

global g_hTDS;
global g_addr_TDS;

if nargin == 1
    addr_TDS = addr;
else
    addr_TDS = g_addr_TDS;  % Default 
end
tdsDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_TDS))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hTDS = ', strAddr]);
set(g_hTDS,'InputBufferSize', 200000);
fopen(g_hTDS);
if strcmp (g_hTDS.Status, 'closed') == 1
    fopen(g_hTDS);
end

hTDS = g_hTDS;
