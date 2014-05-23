function hVSG = vsgInit( addr )
% vsgInit.m
%	VSGINIT Initialize an instrument handler for Agilent E8267D
%	PSG Vector Signal Generator.
%	
%	g_hVSG	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:07 $


globalADDR;

global g_hVSG;
global g_addr_VSG;

if nargin == 1
    addr_VSG = addr;
else
    addr_VSG = g_addr_VSG;  % Default 
end
vsgDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_VSG))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hVSG = ', strAddr]);
set(g_hVSG,'InputBufferSize', 200000);
fopen(g_hVSG);
if strcmp (g_hVSG.Status, 'closed') == 1
    fopen(g_hVSG);
end

hVSG = g_hVSG;
