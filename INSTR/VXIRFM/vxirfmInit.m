function hVXIRFM = vxirfmInit( addr )
% vxirfmInit.m
%	VXIRFMINIT Initialize an instrument handler for Agilent E1472A
%	RF Multiplexer.
%	
%	g_hVXIRFM	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-28 13:42:07 $


globalADDR;

global g_hVXIRFM;
global g_addr_VXIRFM;

if nargin == 1
    addr_VXIRFM = addr;
else
    addr_VXIRFM = g_addr_VXIRFM;  % Default 
end
vxirfmDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'VXI')>0 & strfind(char(vf(ivf)), num2str(addr_VXIRFM))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hVXIRFM = ', strAddr]);
set(g_hVXIRFM,'InputBufferSize', 200000);
fopen(g_hVXIRFM);
if strcmp (g_hVXIRFM.Status, 'closed') == 1
    fopen(g_hVXIRFM);
end

hVXIRFM = g_hVXIRFM;
