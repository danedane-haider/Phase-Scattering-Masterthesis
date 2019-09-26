% gabor magnitude of the guitar melody and synthesizer version

m = melody;
ms = melodysynth;
Lm = length(m);
Ls = length(ms);
a = 32;
M = 8192;
g = {'hann',1024};
c1 = abs(dgtreal(m,g,a,M));
c2 = abs(dgtreal(ms,g,a,M));

figure

subplot(2,1,1)
plotdgtreal(c1,a,M,'fs',44100,'dynrange',30)
ylim([0,1500])
colorbar('off')

subplot(2,1,2)
plotdgtreal(c2,a,M,'fs',44100,'dynrange',15)
ylim([0,1000])
colormap(ltfat_inferno)
colorbar('off')