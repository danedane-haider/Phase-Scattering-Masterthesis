% function that loads melodysynth.wav

function [s,fs] = melodysynth()

if nargin>0
  error('This function does not take input arguments.')
end

f = mfilename('fullpath');

s = wavload([f,'.wav']);
s = s(:,1);
fs = 44100;