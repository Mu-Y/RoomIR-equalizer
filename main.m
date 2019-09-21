close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%logarithmic pole positioning

Fs=48000;

fplog=[logspace(log10(30),log10(200),12) logspace(log10(250),log10(18000),13)]; %two sets of log. resolution
plog=pole_position(fplog, Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% preparing data

imp_audio = audioread('r8-omni-conf_b.wav');   %96khz, live room, univ of Athens
imp_audio = downsample(imp_audio, 2);
imp_audio = [imp_audio;zeros(length(imp_audio),1) ];
data=imp_audio;

[cp,minresp]=rceps(data); %making the measured response minumum-phase
%% Set Target

output=zeros(length(minresp),1);
output(1)=1; %target 

[Bf,Af]=butter(4,30/(Fs/2),'high');
outf=filter(Bf,Af,output); %making the target output a 30 Hz highpass

% % outf=filter(b,a,output); 
% outf=filter(b,1,output);
imp=zeros(1,length(data));
imp(1)=1;
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%filter design

[Bm,Am,FIR]=parfiltid(minresp,outf,plog,1); %Parallel filter design

equalizedresp=parfilt(Bm,Am,FIR,data); %equalized loudspeaker response - filtering the 
						%measured transfer function by the parallel filter

equalizer=parfilt(Bm,Am,FIR,imp); %equalizer impulse response - filtering a unit pulse


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plotting
figure;
plot_tf(data,'b', 48000, 200); %original loudspeaker-room response
hold on; 
plot_tf_smooth(data,'r--',  Fs, 200, 3); %3rd octave smoothed
hold off;
axis([20 20000 -60 40]);
set(gca,'FontName','Times','Fontsize',14);
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
title('Unequzlied Room Frequency Response');
legend('Original', '1/3 Octave Smoothed');

figure;
plot_tf(equalizedresp,'b', 48000, 200); %equalized loudspeaker-room response
hold on;
plot_tf_smooth(equalizedresp,'r--', Fs, 200, 3); %3rd octave smoothed
hold off;
axis([20 20000 -60 40]);
set(gca,'FontName','Times','Fontsize',14);
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
title('Equzlied Room Frequency Response');
legend('Original', '1/3 Octave Smoothed');

figure;
plot_tf(equalizer,'b', 48000, 200); %equalizer transfer function
L=[-2;2]*ones(1,length(fplog));	%indicating pole frequencies
line([fplog;fplog],L,'color','k');
axis([20 20000 -60 60]);
set(gca,'FontName','Times','Fontsize',14);
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
title('Equalizer Frequency Response and Poles')
