function hESG = esgInit( addr )
% esgInit.m
%	ESGINIT Initialize an instrument handler for Agilent E4433B
%	ESG-D Series Signal Generator.
%	
%	g_hESG	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:10 $


globalADDR;

global g_hESG;
global g_addr_ESG;

if nargin == 1
    addr_ESG = addr;
else
    addr_ESG = g_addr_ESG;  % Default 
end
esgDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_ESG))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hESG = ', strAddr]);
set(g_hESG,'InputBufferSize', 200000);
fopen(g_hESG);
if strcmp (g_hESG.Status, 'closed') == 1
    fopen(g_hESG);
end

hESG = g_hESG;
