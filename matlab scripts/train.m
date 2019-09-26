% function that constructs an impulse train of desired frequency f,
% length l and samplingrate s

function [ t ] = train( f, l, s )

if nargin == 2
    l = round(44100*l);
    s = 44100;
elseif nargin == 1
    s = 44100;
    l = s;
end

t = zeros(1,l);
r = round(s/f);
t(r:r:end) = 1;


end

