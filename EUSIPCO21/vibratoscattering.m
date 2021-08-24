% 2nd order cif and STFT scattering coefficients of constant vibrato

% setup: vibrato tone at 880Hz with modulation at 20Hz
fs = 16000;
L = fs*2;
t = [1:L]/fs;
A = ones(1,L);
f = A.*sin(2*pi*t*880 + sin(2*pi*t*20));

% 1st order cif and STFT routines
a1 = 10;
M1 = 1000;
g1_t = {'gauss',1/2};
g1_gab = {'gauss',2};
c1_t = gabphasederiv('t','dgt',f,g1_t,a1,M1,'relative');
c1_gab = abs(dgtreal(f,g1_gab,a1,M1));


% frequency bin at 880Hz and normalization
p_t = 56;
p_gab = 53; % instead of 56, due to windowing in the dgt
cp_t = c1_t(p_t,:);
cp_t = cp_t-(max(cp_t)+min(cp_t))/2;
cp_t = cp_t/max(cp_t);
cp_gab = c1_gab(p_gab,:);
cp_gab = cp_gab-(max(cp_gab)+min(cp_gab))/2;
cp_gab = cp_gab/max(cp_gab);


% 2nd order cif and STFT routines wrt p
a2 = 10;
M2 = 800*4;
g2 = {'gauss',40};
c2_t = gabphasederiv('t','dgt',cp_t,g2,a2,M2,'relative');
c2_gab = abs(dgtreal(cp_gab,g2,a2,M2));


%%%% plots cif scattering %%%%

% only positive frequencies
c1_t = c1_t(1:M1/2,:);
c2_t = c2_t(1:M2/2,:);

% 1st order cif
figure
plotdgtreal(c1_t,a1,M1,fs,'lin','clim',[-50,50])
colorbar('off')
ylim([0,2000])
xlim([0,1])

% propagation bin
figure
plot(linspace(0,1,L/a1/2),cp_t(1:L/a1/2),'k')
xlabel('Time (s)')
ylabel('Amplitude')

% second order cif wrt p
figure
plotdgtreal(c2_t,a2,M2,round(fs/a1),'lin','clim',[-7,7])
ylim([0,50])
xlim([0,1])
colorbar('off')

% samplecolumn
figure
w = c2_t(:,50);
w = w(1:101);
wl = length(w);
plot(linspace(0,50,wl),w,'k')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
set(gca,'YTick',[0])
view(-90,90)


%%%% plots STFT scattering %%%%

% 1st order STFT
figure
plotdgtreal(c1_gab,a1,M1,fs,'dynrange',60)
colorbar('off')
ylim([0,2000])
xlim([0,1])

% propagation bin
figure
plot(linspace(0,1,L/a1/2),cp_gab(1:L/a1/2),'k')
xlabel('Time (s)')
ylabel('Amplitude')

% 2nd order STFT wrt p
figure
plotdgtreal(c2_gab,a2,M2,round(fs/a1),'dynrange',15)
ylim([0,50])
xlim([0,1])
colorbar('off')

% samplecolumn
figure
wd = c2_gab(:,50);
wd= wd(1:56);
wdl = length(wd); 
plot(linspace(0,50,wdl),wd,'k')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
set(gca,'YTick',[0])
view(-90,90)
