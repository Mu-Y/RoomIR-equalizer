function [p]=pole_position(pole_freq,Fs)
pole_freq=pole_freq(:); % making a column vector
wp=2*pi*pole_freq/Fs; %discrete pole frequencies
wp=sort(wp); % sorting the frequencies
pnum=length(wp); 
dwp=zeros(pnum,1);
for k=2:pnum-1
    dwp(k)=(wp(k+1)-wp(k-1))/2;
end
dwp(1)=(wp(2)-wp(1));
dwp(pnum)=(wp(pnum)-wp(pnum-1));
p=exp(-dwp/2).*exp(j*wp); % computing poles from center frequency wp and bandwidth dwp

p=[p; conj(p)]; %pole pairs one after the other
p=p(:); %making it a column vector
  
end