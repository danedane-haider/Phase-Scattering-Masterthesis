%   computes the 2nd layer of the scattering transform via dgtreal and
%   plots both, the dgtreal and the second layer wrt the frequency bins [p,q].

    f = melody;

%   gabor settings
    a1 = 1000;
    M1 = 2048;
    g1 = firwin('hann',M1*2);
    c1 = (abs(dgtreal(f,g1,a1,M1)));
    
%   average over frequency bins within [p,q]    
    p = 65;
    q = 850;
    ave = sum(c1(p:q,:)/(q-p));
    
%   gabor settings 2nd layer     
    a2 = 1;
    M2 = 440;
    g2 = firwin('hann',270);
    c2 = (abs(dgtreal(ave,g2,a2,M2)));
    
%   time averaging
    [k,~] = size(c2);
    cc = zeros(size(c2));
    for ii=1:k
        cc(ii,:) = conv(c2(ii,:),hanning(800)','same');
    end    

%   visual output of gabor magnitudes
    figure
    subplot(1,2,1)
    plotdgtreal(c1,a1,M1,'dynrange',60,'fs',44100)
    colorbar('off')
    tim = 0:0.5:4.5;
    lab = {'0','0.5','1','1.5','2','2.5','3','3.5','4','4.5'};
    xlabel('Time (s)')
    ylim([0,22050/2])
    xlim([0,4.5])
    
%   visual output of 2nd layer mapped to bpm
    subplot(1,2,2)
    plotdgtreal(cc,a1,M2,'fs',floor(44100/a1)*60,'clim',[56.5,57]);
    colorbar('off')
    ylim([0,400])
    xlim([0,tim(end)*a1/60])
    set(gca,'xtick',tim*a1/60);
    set(gca,'xticklabel',lab)
    ylabel('Tempo (bpm)');
    xlabel('Time (s)')
    