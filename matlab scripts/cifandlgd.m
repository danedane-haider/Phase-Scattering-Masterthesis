%cif and lgd representations of the melody

%% melody

L = 192437;
fs = 44100;
l = L/16;
t = [1:l]/fs;
tone = @(omega,theta) sin(2*pi*theta*omega);
ah2 = tone(880,t);
ah3 = tone(1760,t);
a = tone(220,t);
e = tone(329.63,t);
g = tone(392,t);
ah = tone(440,t);
glong = tone(392,[1:4*l]/fs);
f = [a,e,g,e,a,e,a,ah+ah2+ah3,a,g,e,a,e,glong];

%% gabor

a1 = 32;
a2 = 256;
M1 = 4096;
M2 = M1;
g1 = {'gauss',16};
g2 = {'gauss',8};
d = dgtreal(f,g1,a1,M1);

%% phase derivatives

% time - cif
c1t = gabphasederiv('t','dgt',f,g1,a1,M1,'relative');

% frequency - lgd
c1f = gabphasederiv('f','dgt',f,g2,a2,M2,'relative');

    
%% plots

% consider only positive frequencies, since gabphasederiv uses complex dgt
c1t = c1t(1:M1/2,:);
c1f = c1f(1:M1/2,:);

figure

% cif
subplot(2,1,1)
plotdgtreal(c1t,a1,M1,fs,'lin','clim',[-150,150])
colorbar('off')
colormap(ltfat_inferno)
ylim([0,2000])

% samplecolumn
w = c1t(:,2820);
subplot(2,1,2)
plot(linspace(0,2000,round((M1/2)/11.025)),w(1:round((M1/2)/11.025)),'k','Linewidth',1.2)
xlim([0,2000])
xlabel('Frequency (Hz)')
ylabel('Amplitude')
    
figure

% lgd
subplot(2,1,1)
plotdgtreal(c1f,a2,M2,fs,'lin','clim',[-500,500])
colorbar('off')
colormap(ltfat_inferno)
ylim([0,2000])

% samplerow
subplot(2,1,2)
plot(linspace(0,4.5,size(c1f,2)),c1f(3,:),'k','Linewidth',1.2)
xlabel('Time (s)')
ylabel('Amplitude')

    