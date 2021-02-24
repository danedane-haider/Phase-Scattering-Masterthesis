% function that loads tremolo.wav

function [s,fs] = tremolo()

if nargin>0
  error('This function does not take input arguments.')
end

f = mfilename('fullpath');

s = wavload([f,'.wav']);
s = s(:,1);
fs = 44100;