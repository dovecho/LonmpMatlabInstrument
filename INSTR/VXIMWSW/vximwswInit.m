function hVXIMWSW = vximwswInit( addr )
% vximwswInit.m
%	VXIMWSWINIT Initialize an instrument handler for Agilent E1368A
%	Microwave Switch & Driver Module.
%	
%	g_hVXIMWSW	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-28 13:42:06 $


globalADDR;

global g_hVXIMWSW;
global g_addr_VXIMWSW;

if nargin == 1
    addr_VXIMWSW = addr;
else
    addr_VXIMWSW = g_addr_VXIMWSW;  % Default 
end
vximwswDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'VXI')>0 & strfind(char(vf(ivf)), num2str(addr_VXIMWSW))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hVXIMWSW = ', strAddr]);
set(g_hVXIMWSW,'InputBufferSize', 200000);
fopen(g_hVXIMWSW);
if strcmp (g_hVXIMWSW.Status, 'closed') == 1
    fopen(g_hVXIMWSW);
end

hVXIMWSW = g_hVXIMWSW;
