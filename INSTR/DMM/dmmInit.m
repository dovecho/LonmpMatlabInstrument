function hDMM = dmmInit( addr )
% dmmInit.m
%	DMMINIT Initialize an instrument handler for Fluke 8840A
%	Digital Multimeter.
%	
%	g_hDMM	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:11 $


globalADDR;

global g_hDMM;
global g_addr_DMM;

if nargin == 1
    addr_DMM = addr;
else
    addr_DMM = g_addr_DMM;  % Default 
end
dmmDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_DMM))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hDMM = ', strAddr]);
set(g_hDMM,'InputBufferSize', 200000);
fopen(g_hDMM);
if strcmp (g_hDMM.Status, 'closed') == 1
    fopen(g_hDMM);
end

hDMM = g_hDMM;
