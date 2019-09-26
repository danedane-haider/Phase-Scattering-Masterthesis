% 2nd order cif scattering coefficients of quadratically increasing vibrato

%% setup

% vibrato tone at 440Hz with modulation from 5 to 17Hz
fs = 44100;
L = fs*2;
t = [1:L]/fs;
A = [zeros(1,5000),ones(1,34100*2+10000),zeros(1,5000)];
f = A.*sin(2*pi*t*880 + 10*chirp(t,5,2,17,'q'));

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
g2 = {'gauss',8}; 
c2tt = (gabphasederiv('t','dgt',ccc,g2,a2,M2,'relative'));

% magnitude as comparison
c2td = dgtreal(ccc,g2,a2,M2);


%% plots

% only positive frequencies

c1t = c1t(1:M1t/2,:);
c2tt = c2tt(1:M2/2,:);
c2td = c2td(1:M2/2,:);

figure

% cif
subplot(4,2,1:2)
plotdgtreal(c1t,a1t,M1t,fs,'lin','clim',[-50,50])
colorbar('off')
ylim([0,2000])
xlim([0,2])

% frequency bin at 440Hz
subplot(4,2,3:4)
plot(linspace(0,2,882),ccc(1:882),'k')
xlabel('Time (s)')
ylabel('Amplitude')

% second order cif wrt bin p
subplot(4,2,5:8)
plotdgtreal(c2tt,a2,M2,round(fs/a1t),'lin','clim',[-5,5])
ylim([0,round(2000/a1t)])
xlim([0,2])
colorbar('off')