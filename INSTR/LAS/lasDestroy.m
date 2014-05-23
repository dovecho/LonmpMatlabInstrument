function hLAS = lasDestroy()
% lasDestroy.m
%	LASDESTROY Destroy an instrument handler for Agilent 8164A
%	Lightwave Mainframe.
%	
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Generation of this file
%	$Version: 1.0.0.1 $	$Date: 2012-10-10 14:50:09 $

global g_hLAS;

if ~isreal( g_hLAS )
    if strcmp( g_hLAS.status, 'open' )
        fclose(g_hLAS);
    end
    g_hLAS = [];
end
