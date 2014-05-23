function hTDCM = tdcmInit( addr )
% tdcmInit.m
%	TDCMINIT Initialize an instrument handler for TeraXion TDCM30
%	Tunable Dispersion Compensator Module.
%	
%	g_hTDCM	 Handle of this instrument
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generating this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 14:50:11 $


globalADDR;

global g_hTDCM;
global g_addr_asrl_TDCM;

if nargin == 1
    addr_TDCM = addr;
else
    addr_TDCM = g_addr_asrl_TDCM;  % Default 
end
tdcmDestroy;

%Check connected visa instrument to determine RSRCNAMEs
vinfo = instrhwinfo('visa','agilent');
vf = vinfo.ObjectConstructorName;
for ivf = 1 : length(vf)
    if strfind(char(vf(ivf)), 'ASRL')>0 & strfind(char(vf(ivf)), num2str(addr_TDCM))>0
        strAddr = char(vf(ivf));
        break;
    end
end

%Connect to the instrument
eval(['g_hTDCM = ', strAddr]);
set(g_hTDCM,'InputBufferSize', 200000);
pause(0.1);
set(g_hTDCM,'BaudRate',baud_TDCM);
fopen(g_hTDCM);
if strcmp (g_hTDCM.Status, 'closed') == 1
    fopen(g_hTDCM);
end

hTDCM = g_hTDCM;
