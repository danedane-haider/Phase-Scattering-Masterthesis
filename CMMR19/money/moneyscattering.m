%   computes the 2nd layer of the scattering transform via dgtreal and
%   plots both, the dgtreal and the second layer wrt the frequency bins [p,q].

    m = money;
    
%   gabor settings    
    a1 = 2000;
    M1 = 2048;
    g1 = firwin('hann',M1/8);
    c1 = (abs(dgtreal(m,g1,a1,M1)));

%   average over frequency bins within [p,q]
    p = 700;
    q = 900;
    ave = sum(c1(p:q,:)/(q-p));
    
%   gabor settings 2nd layer    
    a2 = 1;
    M2 = 340;
    g2 = firwin('hann',1000);
    c2 = (abs(dgtreal(ave,g2,a2,M2)));
    
%   time averaging     
    [k,~] = size(c2);
    l2 = zeros(size(c2));
    for ii=1:k
        l2(ii,:) = conv(c2(ii,:),hanning(250)','same');
    end
    
%   visual output of gabor magnitudes
    figure
    subplot(1,2,1)
    plotdgtreal(c1,a1,M1,'dynrange',60,'fs',44100)
    colorbar('off')
    tim = 0:5:35;
    lab = {'2:45','2:50','2:55','3:00','3:05','3:10','3:15','3:20'};
    set(gca,'xtick',tim);
    set(gca,'xticklabel',lab)
    ylabel('Frequency (Hz)')
    xlabel('Time (mm:ss)')
    ylim([0,22050/2])
    xlim([0,35])
      
%   visual output of the 2nd layer mapped to bpm
    subplot(1,2,2)
    plotdgtreal(l2,a1,M2,'fs',floor(44100/a1)*60,'clim',[54.2,56]);
    colorbar('off')
    ylim([0,500])
    xlim([0,(tim(end))*a1/60])
    set(gca,'xtick',tim*a1/60);
    set(gca,'xticklabel',lab)
    ylabel('Tempo (bpm)');
    xlabel('Time (mm:ss)')
    