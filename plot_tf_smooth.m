function [logscale,smoothmagn]=plot_tf_smooth(data, color, Fs, octbin, fract)

if nargin<5
    fract=3;
end
if nargin<4
    octbin=200;
end

if nargin<3
    Fs=48000;
end;

if nargin<2
    color='b';
end

FFTSIZE=2^18;
data=data(:);
tf=fft(data,FFTSIZE); %FFT
magn=abs(tf(1:FFTSIZE/2));

logfact=2^(1/octbin);
LOGN=floor(log(Fs/2)/log(logfact));
logscale=logfact.^[0:LOGN]; %logarithmic scale from 1 Hz to Fs/2

for k=0:LOGN
    fstep=Fs/FFTSIZE;
    index_bin=round(logscale(k+1)/fstep);
    logmagn(k+1)=magn(index_bin);
end

%creating hanning window
HL=2*round(octbin/fract); %fractional octave smoothing
hh=hanning(HL);
L=length(logmagn);
% L=length(compamp);
logmagn(L+1:L+HL)=0;

tmp=fftfilt(hh,logmagn); 
smoothmagn=tmp(HL/2+1:HL/2+L)/sum(hh);

if nargout<1
    semilogx(logscale,20*log10(abs(smoothmagn)),color, 'LineWidth', 1);
%     semilogx(w,20*log10(abs(smoothmagn)),color);
end
end
