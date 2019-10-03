% function that loads funf.wav
function [s,fs] = funf()
if nargin>0
  error('This function does not take input arguments.')
end;
f = mfilename('fullpath');
s = wavload([f,'.wav']);
s = s(:,1);
s = s(88200:end);
fs = 44100;