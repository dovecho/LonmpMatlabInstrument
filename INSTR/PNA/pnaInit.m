function hPNA = pnaInit( addr )
% pnaInit.m
%	PNAINIT Initialize an instrument handler for Agilent E8364B
%	PNA Network Analyzer.
%	
%	g_hPNA	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:09 $


globalADDR;

global g_hPNA;
global g_addr_PNA;

if nargin == 1
    addr_PNA = addr;
else
    addr_PNA = g_addr_PNA;  % Default 
end
pnaDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_PNA))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hPNA = ', strAddr]);
set(g_hPNA,'InputBufferSize', 200000);
fopen(g_hPNA);
if strcmp (g_hPNA.Status, 'closed') == 1
    fopen(g_hPNA);
end

hPNA = g_hPNA;
