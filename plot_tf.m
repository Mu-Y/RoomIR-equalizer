function [logscale,logmagn]=plot_tf(data, color, Fs, octbin)

if nargin<4
    octbin=200;
end
if nargin<3
    Fs=48000;
end
if nargin<2
    color='b';
end

FFTSIZE=2^18;
data=data(:);
tf=fft(data,FFTSIZE); 
magn=abs(tf(1:FFTSIZE/2));    % take absolute value here

logfact=2^(1/octbin);
LOGN=floor(log(Fs/2)/log(logfact));
logscale=logfact.^[0:LOGN]; %logarithmic scale from 1 Hz to Fs/2

for k=0:LOGN
    fstep=Fs/FFTSIZE;
    index_bin=round(logscale(k+1)/fstep);
    logmagn(k+1)=magn(index_bin);
end

if nargout<1
    semilogx(logscale,20*log10(abs(logmagn)),color);
%     semilogx(w,20*log10(abs(compamp)),color);
end

end
