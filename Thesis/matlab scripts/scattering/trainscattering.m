% gabor scattering of an impulse train at frequency 2 Hz = 120bpm

f = train(2,11);

%% gabor

a1 = 1000;
M1 = 2048;
g1 = firwin('hann',M1*8);
c1 = (abs(dgtreal(f,g1,a1,M1)));

%% gabor of some bin output p

p = 100;
a2 = 1;
M2 = 440;
g2 = firwin('hann',880);
c2 = (abs(dgtreal(c1(p,:),g2,a2,M2)));

% time averaging 
[n,k] = size(c2);
cc = zeros(n,k);
for ii=1:n
    cc(ii,:) = conv(c2(ii,:),hanning(500)','same');
end
    

%%  plots

figure

% train signal
subplot(3,4,[1,2])
plot(f,'k','Linewidth',1.1)
set(gca,'ytick',[0,0.5,1])
set(gca,'xtick',tim*44100)
set(gca,'xticklabel',lab)
ylim([-0.5,1.5])
xlim([0,11.5*44100])
xlabel('Time (s)')
ylabel('Amplitude')

% gabor
subplot(3,4,[5,6,9,10])
plotdgtreal(c1,a1,M1,'dynrange',8,'fs',44100)
colorbar('off')
tim = 0:2:10;
lab = {'0','2','4','6','8','10'};
set(gca,'xtick',tim);
set(gca,'xticklabel',lab)
xlabel('Time (s \times 10^{-3}) !')

% p-th frequency bin
subplot(3,4,[3,4])
plot(c1(p,:),'k','Linewidth',1.1)
set(gca,'ytick',[0,0.5,1])
set(gca,'xtick',tim*round(44100/a1))
set(gca,'xticklabel',lab)
ylim([-0.5,1.5])
xlim([0,11.5*round(44100/a1)])
xlabel('Time (s \times 10^{-3}) !')

% gabor of p-th bin mapped to bpm
subplot(3,4,[7,8,11,12])
plotdgtreal(cc,a1,M2,'fs',floor(44100/a1)*60,'dynrange',13);
colorbar('off')
ylim([0,500])
xlim([0,11.9*a1/60])
set(gca,'xtick',tim*a1/60);
set(gca,'xticklabel',lab)
ylabel('Tempo (bpm)');
xlabel('Resampled Time (s)')