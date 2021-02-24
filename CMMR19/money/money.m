% function that loads the excerpt (2:45,3:20) of money by pink floyd
function [s,fs] = money()
if nargin>0
  error('This function does not take input arguments.')
end;
f = mfilename('fullpath');
s = wavload([f,'.wav']);
s = s(:,1);
s = s(44100*165:44100*200);
fs = 44100;