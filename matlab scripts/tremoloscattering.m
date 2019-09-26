% gabor scattering of the melody with tremolo modulated note

t = tremolo;

%% gabor

a1 = 100;
M1 = 2048;
g1 = firwin('hann',M1);
c1 = (abs(dgtreal(t,g1,a1,M1)));

%% gabor of p-th frequency bin 

% frequency bin corresponding to 440Hz
p = 42;

a2 = 1;
M2 = 440*4;
g2 = firwin('hann',550);
c2 = abs(dgtreal(c1(p,:),g2,a2,M2));

% time averaging 
[k,~] = size(c2);
cc = zeros(size(c2));
for ii=1:k
    cc(ii,:) = conv(c2(ii,:),hanning(800)','same');
end


%% plots

figure

% gabor
subplot(5,1,1:2)
plotdgtreal(c1,a1,M1,'dynrange',60,'fs',44100)
colorbar('off')
xlabel('')
colormap(ltfat_inferno)
ylabel('Frequency (Hz)')
ylim([0,4000])
xlim([0,4.5])

% p-th frequency bin
subplot(5,1,3)
plot(linspace(0,4.5,length(c1(p,:))),c1(p,:)./max(max(c1(p,:))),'k','Linewidth',1.6)
ylabel('Amplitude (norm.)')

% gabor of p-th frequency bin mapped to bpm
subplot(5,1,4:5)
plotdgtreal(cc,a1,M2,'fs',ceil(44100/a1),'dynrange',14);
colorbar('off')
% labelling
tim = 0:0.5:4.5;
lab = {'0','0.5','1','1.5','2','2.5','3','3.5','4','4.5'};
ylim([0,30])
xlim([0,tim(end)*a1])
set(gca,'xtick',tim*a1);
set(gca,'xticklabel',lab)
ylabel('Frequency (Hz)');
xlabel('Time (s)')
colormap(ltfat_inferno)
