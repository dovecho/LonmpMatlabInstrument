function sfdr = PlotSFDR(x, y1, y3, p, inRange1, inRange3, Nmeas)
% PlotSFDR
% To plot SFDR data and fit the SFDR curve, in given conditions
%   X           x-axis, input power (dBm)
%   Y1          first order harmonics response
%   Y3          Third (maybe fifth) order IMD response
%   p           Optical power, 
%   inRange1    fitting Y1 within this range for Y1
%   inRange3    fitting Y3 within this range for Y3
%   Nmeas       ??

%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Version Contron, and comments
%	$Version: 1.0.0.1 $	$Date: 2012-05-29 14:31:43 $

clf;
f = fittype({'x','1'},'coefficients',{'a','b'});

if nargin == 5
    subRange1 = inRange1;
    subRange3 = inRange1;
else
    subRange1 = inRange1;
    subRange3 = inRange3;
end

if nargin == 7
	nth = Nmeas;
else
	nth = 10 * log10( 2*50*0.6*1.6e-19*10^(p/10)+1.6e-22+1.66e-17);
end

%% Plot measured data
hold off;
% plot(x, y1, x, y3);
% hold on;
hold on;

%% Curve fitting
[c1,gof1] = fit(x(subRange1)', y1(subRange1)',f);   % 1st order
[c2,gof2] = fit(x(subRange3)', y3(subRange3)',f);   % 3rd order

sfdr = c1((nth - c2.b)/c2.a)-nth;
nz1 = (nth - c1.b)/c1.a;
nz2 = (nth - c2.b)/c2.a;

IIP3 = (c2.b-c1.b)/(c1.a-c2.a);
y2 = c2(IIP3);


%% Plotting
hp0 = plot(x(subRange1), y1(subRange1), 'bs', x(subRange3), y3(subRange3), 'k^');
try
% 	xlim([5*floor((nz1 - 5)/5), 5*ceil((IIP3+ 5)/5)]);
			xlim([-125 42]);
catch
	fprintf('Error..\n');
	return;
end
set(gcf, 'PaperPosition', [2 1 12 8]);

ylim([5*floor((nth - 5)/5), 5*ceil((y2 + 5)/5)]);

hp1 = plot(fit([0;1], [nth;nth], f), 'k--'); % noise
hp2 = plot(c1, 'b');
hp3 = plot(c2, 'r');

set ([hp1 hp2 hp3], 'linewidth', 1.5);
set (hp0(1), 'MarkerFaceColor',[0.5,0.5,1],'MarkerSize',8);
set (hp0(2), 'MarkerFaceColor',[1,0.5,0.5],'MarkerSize',8);
set (gca, 'Box', 'On');
%% Annotation
xlabel('Input power (dBm)');
ylabel('Output power (dBm)');

[x1,y1] = dsxy2figxy(gca, nz2, nth);
[x2,y2] = dsxy2figxy(gca, nz2, nth+sfdr);
try
	hda = annotation('doublearrow',[x1, x2], [y1, y2]);
	set(hda, 'HeadStyle', 'cback2', 'Head1Length', 5, 'Head2Length', 5, ...
		'Head1Width', 5, 'Head2Width', 5, 'linewidth', 1.5 );
catch
	;
end

text((nz1+nz2)/2, nth+sfdr/2-10, sprintf('SFDR = %.1f dB.Hz^{2/3}', sfdr),...
    'FontSize',12);
text((nz1+nz2)/2-35, nth+8, sprintf('Noise Floor = %.1f dBm', nth),...
    'FontSize',12);

legend('Fundemental', '3rd order intermoduation distortion',...
    'Location', 'NorthWest');

hold off
% hold on
% legend('Location', 'NorthWest')
fprintf('sfdr: %.3f, c1.a: %.3f, c1.b: %.3f, c2.a: %.3f, c2.b: %.3f\n', sfdr, c1.a, c1.b, c2.a, c2.b);
