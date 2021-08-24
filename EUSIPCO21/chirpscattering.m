% 2nd order cif and STFT scattering coefficients of exponentially increasing vibrato

%% setup: vibrato tone at 880Hz with exponential chirp modulation
fs = 16000;
L = fs*2;
t = [1:L]/fs;
A = ones(1,L);
f = A.*sin(2*pi*t*880 + sin(2*pi*t.*(19+exp(t))));

%% 1st order cif and STFT

a1 = 10;
M1 = 1000;
g1 = {'gauss',1/2};
c1_t = gabphasederiv('t','dgt',f,g1,a1,M1,'relative');
c1_gab = abs(dgtreal(f,g1,a1,M1));
    
% frequency bin at 880Hz and normalization
p_t = 56;
p_gab = 53; % instead of 56, due to windowing in the dgt
cp_t = c1_t(p_t,:);
cp_t = cp_t-(max(cp_t)+min(cp_t))/2;
cp_t = cp_t/max(cp_t);
cp_gab = c1_gab(p_gab,:);
cp_gab = cp_gab-(max(cp_gab)+min(cp_gab))/2;
cp_gab = cp_gab/max(cp_gab);

%% 2nd order cif
a2 = 10;
M2 = 800*4;
g2_t = {'gauss',30};
g2_gab = {'gauss',20};
c2_t = (gabphasederiv('t','dgt',cp_t,g2_t,a2,M2,'relative'));
c2_gab = abs(dgtreal(cp_gab,g2_gab,a2,M2));


%%%% plots cif scattering %%%%

% only positive frequencies
c1_t = c1_t(1:M1t/2,:);
c2_t = c2_t(1:M2/2,:);

% first order cif
figure
plotdgtreal(c1_t,a1,M1,fs,'lin','clim',[-50,50])
colorbar('off')
ylim([0,2000])
xlim([0,2])

% second order cif wrt p
figure
plotdgtreal(c2_t,a2,M2,round(fs/a1),'lin','clim',[-5,5])
ylim([0,50])
xlim([0,2])
colorbar('off')


%%%% plots STFT scattering %%%%

% 1st order STFT
figure
plotdgtreal(c1_gab,a1,M1,fs,'dynrange',60)
colorbar('off')
ylim([0,2000])
xlim([0,2])

% 2nd order STFT wrt p
figure
plotdgtreal(c2_gab,a2,M2,round(fs/a1),'dynrange',15)
ylim([0,50])
xlim([0,2])
colorbar('off')
