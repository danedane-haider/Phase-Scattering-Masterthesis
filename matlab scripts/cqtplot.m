% cqt scalogram of the guitar melody

m = melody;
Ls = length(m);
fs = 44100;
% min and max computed frequencies
freqmin = floor(100);
freqmax = round(2000);
% no. of bins per octave
B = 24;
[g,a,fc] = cqtfilters(fs,freqmin,freqmax,B,Ls);
c=filterbank(m,g,a);

figure

plotfilterbank(c,a,'dynrange',45,'fs',44100)
colorbar('off')
colormap(ltfat_inferno)