% plot of the magnitude spectrum of the guitar melody

m = melody;
L = length(m);
t = [0:L-1]/2;
f = abs(fft(m));

figure

plot(t,f/max(max(f)),'k')
xlim([0,4e3])
xlabel('Frequency (Hz)')
ylabel('Magnitude (normalized)')