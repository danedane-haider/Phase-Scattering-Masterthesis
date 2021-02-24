% comparison of gabor magnitude plots between wide and narrow window

m = melodysynth;
L = length(m);
a = 64;
M = 4096;
g1 = firwin('hann',512*16);
c1 = (abs(dgtreal(m,g1,a,M)));
g2 = firwin('hann',512/2);
c2 = (abs(dgtreal(m,g2,a,M)));

figure

subplot(2,1,1)
plotdgtreal(c1,a,M,'fs',44100,'dynrange',60)
ylim([0,4000])
colorbar('off')

subplot(2,1,2)
plotdgtreal(c2,a,M,'fs',44100,'dynrange',60)
ylim([0,4000])
colormap(ltfat_inferno)
colorbar('off')
