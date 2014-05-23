function hAFG = afgInit( addr )
% afgInit.m
%	AFGINIT Initialize an instrument handler for Tektronix AFG320
%	Arbitrary Function Generator.
%	
%	g_hAFG	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:12 $


globalADDR;

global g_hAFG;
global g_addr_AFG;

if nargin == 1
    addr_AFG = addr;
else
    addr_AFG = g_addr_AFG;  % Default 
end
afgDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_AFG))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hAFG = ', strAddr]);
set(g_hAFG,'InputBufferSize', 200000);
fopen(g_hAFG);
if strcmp (g_hAFG.Status, 'closed') == 1
    fopen(g_hAFG);
end

hAFG = g_hAFG;
