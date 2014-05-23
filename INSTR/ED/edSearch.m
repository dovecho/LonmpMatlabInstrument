function [rst_Search] = edSearch ( rst_Search )
% edSearch	Auto Search
%
%	rst_Search :	Auto Search (1 Error, 0 No Error)
%
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Update of this file
%	$Version: 2.1.0.1 $	$Date: 2012-10-10 11:15:40 $

% Define global object of ED
global g_hED;

% Initialize and open GPIB of ED
if isempty(g_hED)
	edInit;
end

if strcmp( g_hED.status, 'closed' )
	fopen(g_hED);
end

% Setting and Reading
if nargin > 0
    edWrite(sprintf('SRH %f', rst_Search));
end

edWrite('SRH?');
rst_Search = edReadData;
