% globalADDR.m
%	GLOBALADDR Predefines ADDR for all GPIB instruments in our lab
%
%	Copyright (c) 2012, LONMP, Tsinghua University,
%	Written by Shangyuan Li,
%
%	Revision Note: Add baud_rate for COM
%	$Version: 1.1.0.1 $	$Date: 2012-10-10 14:37:01 $

% Instrument Handler

global           g_addr_VSG;  		% Agilent E8267D PSG Vector Signal Generator
global       g_addr_lan_VSG;  		% Agilent E8267D PSG Vector Signal Generator
global            g_addr_SG;  		% Agilent E8257D PSG Signal Generator
global        g_addr_lan_SG;  		% Agilent E8257D PSG Signal Generator
global           g_addr_MXG;  		% Agilent N5183A MXG Signal Generator
global       g_addr_lan_MXG;  		% Agilent N5183A MXG Signal Generator
global           g_addr_PSA;  		% Agilent E4446A PSA Series Spectrum Analyzer
global       g_addr_lan_PSA;  		% Agilent E4446A PSA Series Spectrum Analyzer
global           g_addr_DSO;  		% Agilent 81204B Digital Sample Oscilloscope
global       g_addr_lan_DSO;  		% Agilent 81204B Digital Sample Oscilloscope
global           g_addr_DCA;  		% Agilent 86100C Digital Communication Analyzer
global       g_addr_lan_DCA;  		% Agilent 86100C Digital Communication Analyzer
global            g_addr_NA;  		% Agilent 8510C Network Analyzer
global           g_addr_PNA;  		% Agilent E8364B PNA Network Analyzer
global       g_addr_lan_PNA;  		% Agilent E8364B PNA Network Analyzer
global           g_addr_LAS;  		% Agilent 8164A Lightwave Mainframe
global           g_addr_TDS;  		% Tektronix TDS220 Digital Real-time Oscilloscope
global            g_addr_ED;  		% Anritsu MP1762A Error Detector
global           g_addr_PPG;  		% Anritsu MP1761B Pulse Pattern Generator
global           g_addr_LDC;  		% ILX Lightwave LDC-3724B Laser Diode Controller
global           g_addr_ESG;  		% Agilent E4433B ESG-D Series Signal Generator
global       g_addr_usb_PWS;  		% Agilent U2002H Power Sensor
global       g_addr_asrl_DC;  		% Itech IT6322 DC Power Supply
global           g_addr_OSA;  		% Advantest Q8384 Optical Spectrum Analyzer
global     g_addr_asrl_TDCM;  		% TeraXion TDCM30 Tunable Dispersion Compensator Module
global           g_addr_DMM;  		% Fluke 8840A Digital Multimeter
global           g_addr_AFG;  		% Tektronix AFG320 Arbitrary Function Generator
global            g_addr_PM;  		% Agilent 437B Power Meter
global       g_addr_VXIMWSW;  		% Agilent E1368A Microwave Switch & Driver Module
global        g_addr_VXIDAC;  		% Agilent E1418A Digital to Analog Converter
global        g_addr_VXIRFM;  		% Agilent E1472A RF Multiplexer

% Instrument Address

% GPIB Instrument
          g_addr_VSG = 22;		% Agilent E8267D PSG Vector Signal Generator
           g_addr_SG = 19;		% Agilent E8257D PSG Signal Generator
          g_addr_MXG = 19;		% Agilent N5183A MXG Signal Generator
          g_addr_PSA = 18;		% Agilent E4446A PSA Series Spectrum Analyzer
          g_addr_DSO =  7;		% Agilent 81204B Digital Sample Oscilloscope
          g_addr_DCA =  9;		% Agilent 86100C Digital Communication Analyzer
           g_addr_NA = 16;		% Agilent 8510C Network Analyzer
          g_addr_PNA = 16;		% Agilent E8364B PNA Network Analyzer
          g_addr_LAS = 17;		% Agilent 8164A Lightwave Mainframe
          g_addr_TDS = NaN;		% Tektronix TDS220 Digital Real-time Oscilloscope
           g_addr_ED =  6;		% Anritsu MP1762A Error Detector
          g_addr_PPG =  8;		% Anritsu MP1761B Pulse Pattern Generator
          g_addr_LDC = 12;		% ILX Lightwave LDC-3724B Laser Diode Controller
          g_addr_ESG = 23;		% Agilent E4433B ESG-D Series Signal Generator
          g_addr_OSA = 15;		% Advantest Q8384 Optical Spectrum Analyzer
          g_addr_DMM = 13;		% Fluke 8840A Digital Multimeter
          g_addr_AFG =  1;		% Tektronix AFG320 Arbitrary Function Generator
           g_addr_PM = 14;		% Agilent 437B Power Meter

% LAN Instrument
      g_addr_lan_VSG =  0;		% Agilent E8267D PSG Vector Signal Generator
       g_addr_lan_SG =  0;		% Agilent E8257D PSG Signal Generator
      g_addr_lan_MXG =  0;		% Agilent N5183A MXG Signal Generator
      g_addr_lan_PSA =  0;		% Agilent E4446A PSA Series Spectrum Analyzer
      g_addr_lan_DSO =  0;		% Agilent 81204B Digital Sample Oscilloscope
      g_addr_lan_DCA =  0;		% Agilent 86100C Digital Communication Analyzer
      g_addr_lan_PNA =  0;		% Agilent E8364B PNA Network Analyzer

% VXI Instrument
      g_addr_VXIMWSW =  0;		% Agilent E1368A Microwave Switch & Driver Module
       g_addr_VXIDAC =  0;		% Agilent E1418A Digital to Analog Converter
       g_addr_VXIRFM =  0;		% Agilent E1472A RF Multiplexer

% ASRL Instrument
             baud_DC = 38400;
      g_addr_asrl_DC =  0;		% Itech IT6322 DC Power Supply
           baud_TDCM = NaN;
    g_addr_asrl_TDCM =  0;		% TeraXion TDCM30 Tunable Dispersion Compensator Module

% USB Instrument
      g_addr_usb_PWS =  0;		% Agilent U2002H Power Sensor


