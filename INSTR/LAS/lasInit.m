function hLAS = lasInit( addr )
% lasInit.m
%	LASINIT Initialize an instrument handler for Agilent 8164A
%	Lightwave Mainframe.
%	
%	g_hLAS	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:09 $


globalADDR;

global g_hLAS;
global g_addr_LAS;

if nargin == 1
    addr_LAS = addr;
else
    addr_LAS = g_addr_LAS;  % Default 
end
lasDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_LAS))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hLAS = ', strAddr]);
set(g_hLAS,'InputBufferSize', 200000);
fopen(g_hLAS);
if strcmp (g_hLAS.Status, 'closed') == 1
    fopen(g_hLAS);
end

hLAS = g_hLAS;
