function y = dbmean(x,dim)
%DBMEAN   Average or mean values in dB.
%   For vectors, DBMEAN(X) is the mean value of the elements in X of dB. 
%   For matrices, DBMEAN(X) is a row vector containing the mean value of
%   each column.  For N-D arrays, DBMEAN(X) is the mean value of the
%   elements along the first non-singleton dimension of X.
%
%   DBMEAN(X,DIM) takes the mean along the dimension DIM of X. 
%
% % %   Example: If X = [1 2 3; 3 3 6; 4 6 8; 4 7 7];
% % %
% % %   then mean(X,1) is [3.0000 4.5000 6.0000] and 
% % %   mean(X,2) is [2.0000 4.0000 6.0000 6.0000].'
%
%   Class support for input X:
%      float: double, single
%
%   See also MEAN, MEDIAN, STD, MIN, MAX, VAR, COV, MODE.

%   Copyright 1984-2009 The MathWorks, Inc. 
%   $Revision: 5.17.4.5 $  $Date: 2010/09/02 13:35:22 $

%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Amend from system function MEAN
%	$Version: 1.0.0.1 $	$Date: 2013-01-19 16:18:59 $


if nargin==1, 
    % Determine which dimension SUM will use
    dim = find(size(x)~=1, 1 );
    if isempty(dim), dim = 1; end
end
    
y = pow2db(mean(db2pow(x), dim));
