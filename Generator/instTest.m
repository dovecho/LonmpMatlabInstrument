

% instFuncGenerator('ed', 'Search', 'SRH', 'Auto Search' , '1 Error, 0 No Error', 1);

% instFuncGenerator('ed', 'Error', 'ERS', 'Error indicator' , '1 Error, 0 No Error', 0 );
% instFuncGenerator('ed', 'SyncLoss', 'SLI', 'Sync Loss' , '1 Loss, 0 Normal', 0 );
% instFuncGenerator('ed', 'EC', 'EC', 'Error Count' , '', 0 );
% instFuncGenerator('ed', 'SecErr', 'OSD', 'One Second Error' , '', 0 );
% instFuncGenerator('ed', 'Threshold', 'DTH', 'Threshold' , 'V', 1 );
% instFuncGenerator('ed', 'Delay', 'CPA', 'Delay Time','ps' , 1 );
% instFuncGenerator('ed', 'Time', 'TIM', 'Measure Time','2 Period, 3 Timed, 4 Elapsed' , 1 );
% instFuncGenerator('ed', 'Mode', 'MOD', 'Measurement Mode','0 Repeat, 1 Single, 2 Untimed' , 1 );
% instFuncGenerator('ed', 'CurrData', 'CUR', 'Current data','0 off, 1 on' , 1 );
% instFuncGenerator('ed', 'Period', 'PRD', 'Period Time','ps' , 1 , '%02d,%02d,%02d,%02d');
% instFuncGenerator('ed', 'Start', 'STA', 'Start measurement','' , 2 );
% instFuncGenerator('ed', 'Stop', 'STO', 'Stop measurement','' , 2 );

% instFuncGenerator('ppg', 'Logic', 'LGC', 'Data Logic','0 Positive, 1 Negative' , 1 );
% instFuncGenerator('ppg', 'DL', 'DLN', 'Data Length','Integer' , 1 );
% instFuncGenerator('ppg', 'Bits', 'BIT', 'Data Length','Integer' , 1 );
% instFuncGenerator('ppg', 'On', 'OON 1', 'Turn on Output','' , 2);
% instFuncGenerator('ppg', 'Off', 'OON 0', 'Turn off Output','' , 2);
% instFuncGenerator('ppg', 'One', 'ALL 1', 'Set all bits to one','' , 2);
% instFuncGenerator('ppg', 'Zero', 'ALL 0', 'Set all bits to zero','' , 2);
% instFuncGenerator('ppg', 'POne', 'PST 1', 'Set page bits to one','' , 2);
% instFuncGenerator('ppg', 'PZero', 'PST 0', 'Set page bits to zero','' , 2);


% 
instFuncGenerator('las', 'On', 'outp on', 'Turn on the laser','' , 2 );
% instFuncGenerator('las', 'Off', 'outp off', 'Turn off the laser','' , 2 );
% instFuncGenerator('las', 'ATTPower', 'outp2:pow', 'Attenuator Power','dBm' , 1 );



% instFuncGenerator('sg', 'Freq', 'freq', 'Freqency', 'Hz' , 1 );
% instFuncGenerator('sg', 'Power', 'pow', 'Power', 'dBm' , 1 );

% instFuncGenerator('sg', 'Phase', 'PHAS', 'Phase reference', 'rad' , 1 );
% instFuncGenerator('vsg', 'Phase', 'PHAS', 'Phase reference', 'rad' , 1 );


% instFuncGenerator('vsg', 'Freq', 'freq', 'Freqency', 'Hz' , 1 );
% instFuncGenerator('vsg', 'Power', 'pow', 'Power', 'dBm' , 1 );
% instFuncGenerator('vsg', 'On', 'outp on', 'Turn on RF','' , 2 );
% instFuncGenerator('vsg', 'Off', 'outp off', 'Turn off RF','' , 2 );
% instFuncGenerator('sg', 'On', 'outp on', 'Turn on RF','' , 2 );
% instFuncGenerator('sg', 'Off', 'outp off', 'Turn off RF','' , 2 );

% instFuncGenerator('pws', 'Freq', 'freq', 'Freqency', 'Hz' , 1 );
% instFuncGenerator('pws', 'Meas', 'meas', 'Power', 'dBm' , 0 );
% instFuncGenerator('pws', 'Fetch', 'fetc', 'Power', 'dBm' , 0 );


% instFuncGenerator('dsa', 'TimeScale', 'TIM:SCALE', 'Time Scale', 's' , 1 );
% instFuncGenerator('dsa', 'Delay', 'TIM:DELAY', 'Time Delay', 's' , 1 );
% -instFuncGenerator('dsa', 'Scale', 'chan%d:scale', 'Scale', '' , 1 );
% instFuncGenerator('dsa', 'AutoScale', 'AUT', 'Auto Scale', '' , 2 );
% instFuncGenerator('dsa', 'Run', 'Run', 'Run Measurement', '' , 2 );
% -instFuncGenerator('dsa', 'Image', 'DISK:SIM %s, SCReen', 'Save image', '' , 2 );

% instFuncGenerator('dso', 'Run', 'Run', 'Run Measurement', '' , 2 );
% instFuncGenerator('dso', 'XRef', 'WAVeform:XREFerence', 'X Reference', 's' , 0 );
% instFuncGenerator('dso', 'XOrigin', 'WAVeform:XORigin', 'X Origin', 's' , 0 );
% instFuncGenerator('dso', 'XInc', 'WAVeform:XINCrement', 'X Increment', 's' , 0 );
% instFuncGenerator('dso', 'YRef', 'WAVeform:YREFerence', 'Y Reference', 's' , 0 );
% instFuncGenerator('dso', 'YOrigin', 'WAVeform:YORigin', 'Y Origin', 's' , 0 );
% instFuncGenerator('dso', 'YInc', 'WAVeform:YINCrement', 'Y Increment', 's' , 0 );

% instFuncGenerator('psa', 'FreqCent', 'freq:cent', 'Freqency', 'Hz' , 1 );
% instFuncGenerator('psa', 'FreqSpan', 'freq:span', 'Freqency', 'Hz' , 1 );
% instFuncGenerator('psa', 'FreqStart', 'freq:start', 'Freqency', 'Hz' , 1 );
% instFuncGenerator('psa', 'FreqStop', 'freq:stop', 'Freqency', 'Hz' , 1 );
% instFuncGenerator('psa', 'BW', 'band', 'Freqency', 'Hz' , 1 );



