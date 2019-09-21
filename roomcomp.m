%Loudspeaker-room equalization using parallel filter design in the
%time-domain - based on the paper
%
%Balázs Bank: Perceptually Motivated Audio Equalization Using Fixed-Pole Parallel Second-Order Filters
%IEEE Signal Processing Letters, Vol. 15, pp. 447-480, 2008.
%
%Homepage: www.mit.bme.hu/~bank/parfilt
%
% C. Balazs Bank, 2007-2013.



load roomresp; %floor-standing loudspeaker in a living room, 1.8m distance

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%logarithmic pole positioning

Fs=44100;

fplog=[logspace(log10(30),log10(200),13) logspace(log10(250),log10(18000),12)]; %two sets of log. resolution
plog=freqpoles(fplog);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%preparing data

data=impresp(225:100224); %neglecting the delay part

[cp,minresp]=rceps(data(1:100000)); %making the measured response minumum-phase
output=zeros(length(minresp),1);
output(1)=1; %target 

[Bf,Af]=butter(4,30/(Fs/2),'high');
outf=filter(Bf,Af,output); %making the target output a 30 Hz highpass

imp=zeros(1,length(data));
imp(1)=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%filter design

[Bm,Am,FIR]=parfiltid(minresp,outf,plog,1); %Parallel filter design

equalizedresp=parfilt(Bm,Am,FIR,data); %equalized loudspeaker response - filtering the 
						%measured transfer function by the parallel filter

equalizer=parfilt(Bm,Am,FIR,imp); %equalizer impulse response - filtering a unit pulse


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plotting

tfplot(100*data,'b'); %original loudspeaker-room response
hold on; 
tfplots(100*data,'r--',  Fs, 8); %8rd octave smoothed
tfplot(equalizedresp*0.12,'b'); %equalized loudspeaker-room response
tfplots(equalizedresp*0.12,'r--'); %3rd octave smoothed
tfplot(0.2*equalizer,'b'); %equalizer transfer function
L=[-2;2]*ones(1,length(fplog));	%indicating pole frequencies
line([fplog;fplog],L,'color','k');
hold off;
axis([20 20000 -40 40]);
set(gca,'FontName','Times','Fontsize',14);
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');

text(200,35,'Unequalized loudspeaker-room response','FontName','Times','FontSize',10);
text(1000,10,'Equalizer transfer function','FontName','Times','FontSize',10);
text(1000,6,'(Black lines: pole locations)','FontName','Times','FontSize',10);
text(200,-10,'Equalized loudspeaker-room response','FontName','Times','FontSize',10);

