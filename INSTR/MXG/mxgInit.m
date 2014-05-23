function hMXG = mxgInit( addr )
% mxgInit.m
%	MXGINIT Initialize an instrument handler for Agilent N5183A
%	MXG Signal Generator.
%	
%	g_hMXG	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:08 $


globalADDR;

global g_hMXG;
global g_addr_MXG;

if nargin == 1
    addr_MXG = addr;
else
    addr_MXG = g_addr_MXG;  % Default 
end
mxgDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_MXG))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hMXG = ', strAddr]);
set(g_hMXG,'InputBufferSize', 200000);
fopen(g_hMXG);
if strcmp (g_hMXG.Status, 'closed') == 1
    fopen(g_hMXG);
end

hMXG = g_hMXG;
