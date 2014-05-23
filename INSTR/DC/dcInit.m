function hDC = dcInit( addr )
% dcInit.m
%	DCINIT Initialize an instrument handler for Itech IT6322
%	DC Power Supply.
%	
%	g_hDC	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:11 $


globalADDR;

global g_hDC;
global g_addr_asrl_DC;

if nargin == 1
    addr_DC = addr;
else
    addr_DC = g_addr_asrl_DC;  % Default 
end
dcDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'ASRL')>0 & strfind(char(vf(ivf)), num2str(addr_DC))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hDC = ', strAddr]);
set(g_hDC,'InputBufferSize', 200000);
pause(0.1);
set(g_hDC,'BaudRate',baud_DC);
fopen(g_hDC);
if strcmp (g_hDC.Status, 'closed') == 1
    fopen(g_hDC);
end

hDC = g_hDC;
