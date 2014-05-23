function hPM = pmInit( addr )
% pmInit.m
%	PMINIT Initialize an instrument handler for Agilent 437B
%	Power Meter.
%	
%	g_hPM	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:12 $


globalADDR;

global g_hPM;
global g_addr_PM;

if nargin == 1
    addr_PM = addr;
else
    addr_PM = g_addr_PM;  % Default 
end
pmDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'GPIB')>0 & strfind(char(vf(ivf)), num2str(addr_PM))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hPM = ', strAddr]);
set(g_hPM,'InputBufferSize', 200000);
fopen(g_hPM);
if strcmp (g_hPM.Status, 'closed') == 1
    fopen(g_hPM);
end

hPM = g_hPM;
