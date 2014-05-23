function hPSA = psaInit( addr )
% psaInit.m
%	PSAINIT Initialize an instrument handler for Agilent E4446A
%	PSA Series Spectrum Analyzer.
%	
%	g_hPSA	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:08 $


globalADDR;

global g_hPSA;
global g_addr_PSA;

if nargin == 1
    addr_PSA = addr;
else
    addr_PSA = g_addr_PSA;  % Default 
end
psaDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_PSA))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hPSA = ', strAddr]);
set(g_hPSA,'InputBufferSize', 200000);
fopen(g_hPSA);
if strcmp (g_hPSA.Status, 'closed') == 1
    fopen(g_hPSA);
end

hPSA = g_hPSA;
