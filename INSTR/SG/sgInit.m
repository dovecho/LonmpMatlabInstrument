function hSG = sgInit( addr )
% sgInit.m
%	SGINIT Initialize an instrument handler for Agilent E8257D
%	PSG Signal Generator.
%	
%	g_hSG	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:07 $


globalADDR;

global g_hSG;
global g_addr_SG;

if nargin == 1
    addr_SG = addr;
else
    addr_SG = g_addr_SG;  % Default 
end
sgDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_SG))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hSG = ', strAddr]);
set(g_hSG,'InputBufferSize', 200000);
fopen(g_hSG);
if strcmp (g_hSG.Status, 'closed') == 1
    fopen(g_hSG);
end

hSG = g_hSG;
