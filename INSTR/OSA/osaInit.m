function hOSA = osaInit( addr )
% osaInit.m
%	OSAINIT Initialize an instrument handler for Advantest Q8384
%	Optical Spectrum Analyzer.
%	
%	g_hOSA	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:11 $


globalADDR;

global g_hOSA;
global g_addr_OSA;

if nargin == 1
    addr_OSA = addr;
else
    addr_OSA = g_addr_OSA;  % Default 
end
osaDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_OSA))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hOSA = ', strAddr]);
set(g_hOSA,'InputBufferSize', 200000);
fopen(g_hOSA);
if strcmp (g_hOSA.Status, 'closed') == 1
    fopen(g_hOSA);
end

hOSA = g_hOSA;
