function strStamp = myStamp(varargin)
%myStamp   To generate editing and revising information
%   myStamp(revSTR, VER) print revision string revSTR and version number
%   VER to screen with default author name.
%
%   myStamp(revSTR, VER, fid) print revision string revSTR and version number
%   VER to a file handled by FID, with default author name.
%
%   myStamp(revSTR, VER, fid, authorName) print revision string revSTR and version number
%   VER to a file handled by FID, with specified author name.
%
%   revSTR STRing that contains revising information
%   VER Version in 'x.x.x.x' format
%
%	Copyright (c) 2012 - 2014, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Altered the return value to string, change the argument order
%	$Version: 1.2.0.1 $	$Date: 2014-05-23 14:21:03 $

if nargin == 2
    revSTR = varargin{1};
    ver = varargin{2};
    fid = 1;
    strAuthorName = 'Shangyuan Li';
elseif nargin == 3
    revSTR = varargin{1};
    ver = varargin{2};
    fid = varargin{3};
    strAuthorName = varargin{3};
elseif nargin == 3
    revSTR = varargin{1};
    ver = varargin{2};
    fid = varargin{3};
    strAuthorName = varargin{4};
else
    error('Please refer to function usage!');
end


strStamp = sprintf('%%\n');
strStamp = [strStamp sprintf('%%\tCopyright (c) 2012 - %d, LONMP, Tsinghua University,\n', year(now))];
strStamp = [strStamp sprintf('%%\tWritten by %s,\n', strAuthorName)];
strStamp = [strStamp sprintf('%%\n')];

strStamp = [strStamp sprintf('%%\tRevision Note: %s\n', revSTR)];
strStamp = [strStamp sprintf('%%\t$Version: %s $\t', ver)];
strStamp = [strStamp sprintf('$Date: %s $\n', datestr(now, 'yyyy-mm-dd HH:MM:SS'))];
strStamp = [strStamp sprintf('\n')];

fprintf(fid, '%s', strStamp);
