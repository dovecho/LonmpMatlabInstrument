% initInstLibrary
%   INITINSTLIBRARY Generate basic instrument I/O functions for all 
%   instrument listed.
%
%
%	Copyright 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-05-19 10:52:24 $

%% Processing Function body
[a b M] = xlsread('..\globalADDR.xlsx');
instType = {'GPIB';'LAN';'VXI';'ASRL';'USB';};

for i = 23 : size(M,1)
    initInstrument(M(i,:));
end