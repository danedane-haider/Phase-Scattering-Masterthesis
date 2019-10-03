% function that loads melodysynth2.wav

function [s,fs] = melodysynth2()

if nargin>0
  error('This function does not take input arguments.')
end

f = mfilename('fullpath');

s = wavload([f,'.wav']);
s = s(round(length(s)/2):end,1);
fs = 44100;