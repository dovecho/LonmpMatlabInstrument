function hNA = naInit( addr )
% naInit.m
%	NAINIT Initialize an instrument handler for Agilent 8510C
%	Network Analyzer.
%	
%	g_hNA	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:09 $


globalADDR;

global g_hNA;
global g_addr_NA;

if nargin == 1
    addr_NA = addr;
else
    addr_NA = g_addr_NA;  % Default 
end
naDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_NA))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hNA = ', strAddr]);
set(g_hNA,'InputBufferSize', 200000);
fopen(g_hNA);
if strcmp (g_hNA.Status, 'closed') == 1
    fopen(g_hNA);
end

hNA = g_hNA;
