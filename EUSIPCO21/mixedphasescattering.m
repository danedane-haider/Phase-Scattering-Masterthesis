% mixed phase scattering coefficients and 2nd order STFT scattering of impulse train

%% setup: impulse train at 20Hz
fs = 16000;
L = fs*6;
h = 20;
f = zeros(1,L);
r = round(fs/h);
f(r:r:end) = 1;

%% 1st order lgd and STFT

a1 = 100;
M1 = 400;
g1_f = {'gauss',1/2};
g1_gab = {'gauss',2};
c1_f = gabphasederiv('f','dgt',f,g1_f,a1,M1,'relative');
c1_gab = abs(dgtreal(f,g1_gab,a1,M1));
    
% some frequency bin and normalization
p = 10;
cp_f = c1_f(p,:);
cp_f = cp_f-(max(cp_f)+min(cp_f))/2;
cp_f = cp_f/max(cp_f);
cp_gab = c1_gab(p,:);
cp_gab = cp_gab-(max(cp_gab)+min(cp_gab))/2;
cp_gab = cp_gab/max(cp_gab);


%% 2nd order cif transformation and STFT wrt p

a2 = 1;
M2 = 800*4;
g2 = {'gauss',2};
c2_ft = gabphasederiv('t','dgt',cp_f,g2,a2,M2,'relative');
c2_gab = abs(dgtreal(cp_gab,g2,a2,M2));



%%%% plots mixed scattering %%%%

% only positive frequencies
c1_f = c1_f(1:M1/2,:);
c2_ft = c2_ft(1:M2/2,:);

% 1st order lgd
figure
plotdgtreal(c1_f,a1,M1,fs,'lin','clim',[-200,200])
colorbar('off')
ylim([0,2000])
xlim([0,1])

% propagation bin p - sawtooth wave
figure
plot(linspace(0,1,round(L/a1/6)),cp_f(1:round(L/a1/6)),'k')
xlim([0,1])
xlabel('Time (s)')
ylabel('Amplitude')

% 2nd order mixed wrt p
figure
plotdgtreal(c2_ft,a2,M2,round(fs/a1),'lin','clim',[-40,40])
ylim([0,35])
xlim([0,6])
colorbar('off')


%%%% plots STFT scattering %%%%

% 1st order STFT
figure
plotdgtreal(c1_f,a1,M1,fs,'dynrange',10)
colorbar('off')
ylim([0,2000])
xlim([0,1])

% propagation bin p
figure
plot(linspace(0,1,round(L/a1/6)),cp_gab(1:round(L/a1/6)),'k')
xlim([0,1])
xlabel('Time (s)')
ylabel('Amplitude')

% 2nd order STFT wrt p
figure
plotdgtreal(c2_gab,a2,M2,round(fs/a1),'dynrange',20)
ylim([0,35])
xlim([0,6])
colorbar('off')
