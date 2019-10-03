function [s,fs]=melody()

if nargin>0
  error('This function does not take input arguments.')
end;

f=mfilename('fullpath');

s=wavload([f,'.wav']);
s = s(:,1);
s=s(97e3:30e4)*7.5;
fs=44100;