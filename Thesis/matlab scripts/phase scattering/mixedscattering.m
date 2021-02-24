% mixed phase scattering coefficients of impulse train

%% setup

% impulse train at 5Hz
f = train(5,6);
fs = 44100;


%%  lgd

a1f = 100;
M1f = 2048;
g1f = {'gauss',16};
c1f = gabphasederiv('f','dgt',f,g1f,a1f,M1f,'relative');
    

%%  cif of the q-th row of c1f

% some frequency bin
p = 44;

ccc = c1f(p,:);
a2 = 1;
M2 = 880*4;
g2 = {'gauss',512};
c2ft = gabphasederiv('t','dgt',ccc,g2,a2,M2,'relative');

% magnitude as comparison
c2td = dgtreal(ccc,g2,a2,M2);


%% plots

% only positive frequencies

c1f = c1f(1:M1f/2,:);
c2ft = c2ft(1:M2/2,:);
c2td = c2td(1:M2/2,:);

% samplecolumns
w = c2ft(:,660);
wl = length(w);
wd = c2td(:,660);
wdl = length(wd); 

figure

% lgd
subplot(5,2,1:2)
plotdgtreal(c1f,a1f,M1f,fs,'lin','clim',[-1000,1000])
colorbar('off')
ylim([0,2000])
xlim([0,6.2])

% frequency bin p
subplot(5,2,3:4)
plot(linspace(0,6.2,2750),c1f(p,1:2750),'k')
xlim([0,6.2])
xlabel('Time (s)')
ylabel('Amplitude')

% cif of bin p
subplot(5,2,6:8)
plotdgtreal(c2ft,a2,M2,round(fs/a1f),'lin','clim',[-1,1])
ylim([0,round(2000/a1f)])
xlim([0,6.2])
colorbar('off')

% samplecolumn
subplot(5,2,9:10)
plot(linspace(0,20,round(wl/11)),w(1:round(wl/11)),'k')
xlabel('Frequency (Hz)')
ylabel('Amplitude')


figure

% magnitude
subplot(3,2,1:4)
plotdgtreal(c2td,a2,M2,round(fs/a1t),'dynrange',60)
ylim([0,round(2000/a1f)])
xlim([0,2])
colorbar('off')

% samplecolumn
subplot(3,2,5:6)
plot(linspace(0,20,round(wdl/11)),wd(1:round(wdl/11)),'k')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
    