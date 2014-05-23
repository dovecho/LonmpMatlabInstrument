function hED = edInit( addr )
% edInit.m
%	EDINIT Initialize an instrument handler for Anritsu MP1762A
%	Error Detector.
%	
%	g_hED	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:10 $


globalADDR;

global g_hED;
global g_addr_ED;

if nargin == 1
    addr_ED = addr;
else
    addr_ED = g_addr_ED;  % Default 
end
edDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_ED))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hED = ', strAddr]);
set(g_hED,'InputBufferSize', 200000);
fopen(g_hED);
if strcmp (g_hED.Status, 'closed') == 1
    fopen(g_hED);
end

hED = g_hED;
