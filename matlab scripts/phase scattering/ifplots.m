% instantaneous frequency of pure sine at 50Hz and quadratic chirp 10-100Hz

fs = 1000;
x = [0:(1/fs):1];
y1 = sin(2*pi*50*x)';
y2 = chirp(x,10,1,100,'q')';

figure

subplot(4,4,1:2)
plot(x,y1,'k')
xlabel('Time')
ylabel('Amplitude')

subplot(4,4,5:6)
plot(instfreq(y1,fs),'k')
xlabel('Time')
ylabel('Frequency')

subplot(4,4,3:4)
plot(x,y2,'k')
xlabel('Time')
ylabel('Amplitude')

subplot(4,4,7:8)
% labelling
tim = 0:3:30;
lab = {'0','0.1','0.2','0.3','0.4','0.5','0.6','0.8','0.7','0.9','1'};
plot(instfreq(y2,fs),'k')
xlabel('Time')
ylabel('Frequency')
set(gca,'xtick',tim)
set(gca,'xticklabel',lab)