function hPPG = ppgInit( addr )
% ppgInit.m
%	PPGINIT Initialize an instrument handler for Anritsu MP1761B
%	Pulse Pattern Generator.
%	
%	g_hPPG	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:10 $


globalADDR;

global g_hPPG;
global g_addr_PPG;

if nargin == 1
    addr_PPG = addr;
else
    addr_PPG = g_addr_PPG;  % Default 
end
ppgDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_PPG))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hPPG = ', strAddr]);
set(g_hPPG,'InputBufferSize', 200000);
fopen(g_hPPG);
if strcmp (g_hPPG.Status, 'closed') == 1
    fopen(g_hPPG);
end

hPPG = g_hPPG;
