function hDSO = dsoInit( addr )
% dsoInit.m
%	DSOINIT Initialize an instrument handler for Agilent 81204B
%	Digital Sample Oscilloscope.
%	
%	g_hDSO	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:08 $


globalADDR;

global g_hDSO;
global g_addr_DSO;

if nargin == 1
    addr_DSO = addr;
else
    addr_DSO = g_addr_DSO;  % Default 
end
dsoDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_DSO))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hDSO = ', strAddr]);
set(g_hDSO,'InputBufferSize', 200000);
fopen(g_hDSO);
if strcmp (g_hDSO.Status, 'closed') == 1
    fopen(g_hDSO);
end

hDSO = g_hDSO;
