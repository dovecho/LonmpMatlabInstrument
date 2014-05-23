function hVXIDAC = vxidacInit( addr )
% vxidacInit.m
%	VXIDACINIT Initialize an instrument handler for Agilent E1418A
%	Digital to Analog Converter.
%	
%	g_hVXIDAC	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-28 13:42:06 $


globalADDR;

global g_hVXIDAC;
global g_addr_VXIDAC;

if nargin == 1
    addr_VXIDAC = addr;
else
    addr_VXIDAC = g_addr_VXIDAC;  % Default 
end
vxidacDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'VXI')>0 & strfind(char(vf(ivf)), num2str(addr_VXIDAC))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hVXIDAC = ', strAddr]);
set(g_hVXIDAC,'InputBufferSize', 200000);
fopen(g_hVXIDAC);
if strcmp (g_hVXIDAC.Status, 'closed') == 1
    fopen(g_hVXIDAC);
end

hVXIDAC = g_hVXIDAC;
