% 2nd order gabor scattering of the guitar melody to compute its tempo

%% setup
f = melody;

%% gabor

a1 = 1000;
M1 = 2048;
g1 = firwin('hann',M1*2);
c1 = abs(dgtreal(f,g1,a1,M1));

%% gabor of average over transienty regions

% average over bins 60-850   
ave = sum(c1(60:850,:)/(850-60));

a2 = 1;
M2 = 440;
g2 = firwin('hann',270);
c2 = abs(dgtreal(ave,g2,a2,M2));

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
plotdgtreal(c1,a1,M1,'dynrange',50,'fs',44100)
colorbar('off')
colormap(ltfat_inferno)
ylabel('Frequency (Hz)')
xlabel(' ')
ylim([0,4000])
xlim([0,4.5])

% average over the bins
subplot(5,1,3)
plot(linspace(0,4.5,length(ave)),ave./max(max(ave)),'k','Linewidth',1.6)
ylabel('Amplitude (norm.)')

% 2nd order gabor scattering coefficients, mapped to bpm

subplot(5,1,4:5)
plotdgtreal(cc,a1,M2,'fs',floor(44100/a1)*60,'clim',[56.5,58])
colorbar('off')
colormap(ltfat_inferno)
tim = 0:0.5:4.5;
lab = {'0','0.5','1','1.5','2','2.5','3','3.5','4','4.5'};
ylim([0,400])
xlim([0,(tim(end))*a1/60])
set(gca,'xtick',tim*a1/60)
set(gca,'xticklabel',lab)
ylabel('Tempo (bpm)')
xlabel('Time (s)')
    