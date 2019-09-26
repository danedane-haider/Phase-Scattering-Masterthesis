% plots the tf magnitudes and phase angles of the melody in wrapped and
% unwrapped form using the gabor transform

%% melody

L = 192437;
fs = 44100;
l = L/16;
t = [1:l]/fs;
tone = @(omega,theta) sin(2*pi*theta*omega);
a = tone(220,t);
e = tone(329.63,t);
g = tone(392,t);
a2 = tone(440,t);
glong = tone(392,[1:4*l]/fs);
f = [a,e,g,e,a,e,a,a2,a,g,e,a,e,glong];

%% Gabor

a = 64;
M = 8192;
g = {'hann',512};
c = dgtreal(f,g,a,M);

%% plots

figure

% magnitude
subplot(3,1,1)
plotdgtreal(abs(c),a,M,'fs',44100,'dynrange',30)
colormap(ltfat_inferno)
colorbar('off')
ylim([0,1000])

% unwrapped phase
subplot(3,1,2)
plotdgt(angle(c),a,M,'fs',44100,'lin','clim',[-5,5])
colormap(ltfat_inferno)
colorbar('off')
ylim([0,1000])

% wrapped phase
subplot(3,1,3)
plotdgt(unwrap(angle(c),[],2),a,M,'fs',44100,'lin','clim',[-6000,6000])
colormap(ltfat_inferno)
colorbar('off')
ylim([0,1000])