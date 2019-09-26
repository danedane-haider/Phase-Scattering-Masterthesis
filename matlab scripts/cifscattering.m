% 2nd order cif scattering coefficients of constant vibrato

%% setup

% vibrato tone at 440Hz with modulation at 10Hz
fs = 44100;
L = fs*2;
t = [1:L]/fs;
A = [zeros(1,5000),ones(1,34100*2+10000),zeros(1,5000)];
f = A.*sin(2*pi*t*880 + 10*sin(2*pi*t*10));

%% cif

a1t = 100;
M1t = 2048;
g1t = {'gauss',1};
c1t = gabphasederiv('t','dgt',f,g1t,a1t,M1t,'relative');

%%  cif of the p-th row of c1t

% frequency bin at 440Hz
p=42;

ccc = c1t(p,:);
a2 = 1;
M2 = 880*4;
g2 = {'gauss',64}; 
c2tt = (gabphasederiv('t','dgt',ccc,g2,a2,M2,'relative'));

% magnitude as comparison
c2td = dgtreal(ccc,g2,a2,M2);


%% plots

% only positive frequencies

c1t = c1t(1:M1t/2,:);
c2tt = c2tt(1:M2/2,:);
c2td = c2td(1:M2/2,:);
% samplecolumns
w = c2tt(:,660);
wl = length(w);
wd = c2td(:,660);
wdl = length(wd); 

figure

% 1st order cif
subplot(5,2,1:2)
plotdgtreal(c1t,a1t,M1t,fs,'lin','clim',[-50,50])
colorbar('off')
ylim([0,2000])
xlim([0,2])

% frequency bin at 440Hz
subplot(5,2,3:4)
plot(linspace(0,2,882),ccc(1:882),'k')
xlabel('Time (s)')
ylabel('Amplitude')

% second order cif wrt bin p
subplot(5,2,5:8)
plotdgtreal(c2tt,a2,M2,round(fs/a1t),'lin','clim',[-5,5])
ylim([0,round(2000/a1t)])
xlim([0,2])
colorbar('off')

% samplecolumn
subplot(5,2,9:10)
plot(linspace(0,20,round(wl/11)),w(1:round(wl/11)),'k')
xlabel('Frequency (Hz)')
ylabel('Amplitude')

figure

% magnitude of bin p
subplot(3,2,1:4)
plotdgtreal(c2td,a2,M2,round(fs/a1t),'dynrange',60)
ylim([0,round(2000/a1t)])
xlim([0,2])
colorbar('off')

% samplecolumn
subplot(3,2,5:6)
plot(linspace(0,20,round(wdl/11)),wd(1:round(wdl/11)),'k')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
      