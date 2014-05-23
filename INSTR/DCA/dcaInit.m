function hDCA = dcaInit( addr )
% dcaInit.m
%	DCAINIT Initialize an instrument handler for Agilent 86100C
%	Digital Communication Analyzer.
%	
%	g_hDCA	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:08 $


globalADDR;

global g_hDCA;
global g_addr_DCA;

if nargin == 1
    addr_DCA = addr;
else
    addr_DCA = g_addr_DCA;  % Default 
end
dcaDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_DCA))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hDCA = ', strAddr]);
set(g_hDCA,'InputBufferSize', 200000);
fopen(g_hDCA);
if strcmp (g_hDCA.Status, 'closed') == 1
    fopen(g_hDCA);
end

hDCA = g_hDCA;
