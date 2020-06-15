%%%%% Effet de l'echantillonage %%%%%

%question_1

f0 = 1100;   %%La fréquénce du signal
Fe = 10000;  %%La fréquence d'échantillonnage.
Te = 1/Fe;   %%La période d'échantillonnage .
N = 90;      %%Le nombre d'échantillons.
Amp = 1;     %%L'amplitude du signal
x = Amp*cos(2*pi*f0*[0:Te:(N-1)*Te]);  %%Génération du signal.

%question_2
figure;plot(x);
title('figure 1');
xlabel('Temps (s)');
ylabel('Amplitude (V)');

%question_3

                                
f0 = 1100;
Fe = 1000;
Te = 1/Fe;
N = 90;
Amp = 1;
x = Amp*cos(2*pi*f0*[0:Te:(N-1)*Te]);

%question_4
figure;plot(x);
title('figure 2');
xlabel('Temps (s)');
ylabel('Ampliture (V)');



%%%% Transformée de Fourier discrète %%%% 

%Question 2-a
f0 = 1100;
Fe = 10000;
Te = 1/Fe;
N = 90;
A = 1;
x = A*cos(2*pi*f0*[0:Te:(N-1)*Te]);
X=fft(x);
figure;semilogy(linspace(-Fe/2,Fe/2 - Fe/N,length(X)),fftshift(abs(X)));
title('figure 3');
xlabel('Fréquence (Hz)');
ylabel('TFD du signal');


%Question 2-b
f0 = 1100;
Fe = 1000;
Te = 1/Fe;
N = 90;
A = 1;
x = A*cos(2*pi*f0*[0:Te:(N-1)*Te]);
X=fft(x);
figure;semilogy(linspace(-Fe/2,Fe/2 - Fe/N,length(X)),fftshift(abs(X)));
title('figure 4');
xlabel('Fréquence (Hz)');
ylabel('TFD du signal');

%TFD Discrète

f0 = 1100;
Fe = 10000;
Te = 1/Fe;
N=90;
A = 1;
x = A*cos(2*pi*f0*[0:Te:(N-1)*Te]);
K = 2^nextpow2(length(x));
X=fft(x,K);
figure;
subplot(2,2,1);
semilogy(linspace(-Fe/2,Fe/2 - Fe/(N*K),length(X)),abs(X));
title('figure 5');
xlabel('Fréquence (Hz)');
ylabel('TFD du signal');

%%Pour différentes valeurs de K

%%K=128
K = 100;
X=fft(x,K);
figure;
semilogy(linspace(-Fe/2,Fe/2 - Fe/(N*K),length(X)),abs(X)); hold on;
%%K=256
K = 256;
X=fft(x,K);
semilogy(linspace(-Fe/2,Fe/2 - Fe/(N*K),length(X)),abs(X));
%%K=512
K = 512;
X=fft(x,K);
semilogy(linspace(-Fe/2,Fe/2 - Fe/(N*K),length(X)),abs(X));
legend('K = 128','K = 256','K = 512');
title('figure6');
xlabel('frequences (HZ)');
ylabel('TFD du signal');

%%%% Densité spectral de puissance ( DSP ) numérique %%%

%%Question 1 et 2 
f0 = 1100;
Fe = 10000;
Te = 1/Fe;
N=90;
A = 1;
phi = 2*pi*rand;
x = A*cos(2*pi*f0*[0:Te:(N-1)*Te] + phi);
[pxx,w] = periodogram(x);
Variable_1 = pxx;
figure;plot(w,10*log10(pxx));
title('figure 7');
xlabel('Fréquence (Hz)');
ylabel('DSP');


%%Question 3 

f0 = 1100;
Fe = 10000;
Te = 1/Fe;
N=90;
A = 1;
phi = 2*pi*rand;
x = A*cos(2*pi*f0*[0:Te:(N-1)*Te] + phi);
w_1 = hamming(N);
[pxx,w] = periodogram(x,w_1);
Variable_2 = pxx;
figure;plot(w,10*log10(pxx));
title('figure 8_a');
xlabel('Fréquence (Hz)');
ylabel('DSP');



f0 = 1100;
Fe = 10000;
Te = 1/Fe;
N=90;
A = 1;
phi = 2*pi*rand;
x = A*cos(2*pi*f0*[0:Te:(N-1)*Te] + phi);
w_2 = blackman(N);
[pxx,w] = periodogram(x,w_2);
Variable_3 = pxx;
figure;plot(w,10*log10(pxx));
title('figure 8_b');
xlabel('Fréquence (Hz)');
ylabel('DSP');


%%Question 4 

f0 = 1100;
Fe = 10000;
Te = 1/Fe;
N=90;
A = 1;
phi = 2*pi*rand;
x = A*cos(2*pi*f0*[0:Te:(N-1)*Te] + phi);
DSPx = pwelch(x,'','','','twosided');
Variable_4 = DSPx;
figure;plot(DSPx);
title('figure 9');
xlabel('Fréquence (Hz)');
ylabel('DSP');


%%Question 5
figure;
semilogy(Variable_1) ; hold on;
semilogy(Variable_2);
semilogy(Variable_3);
semilogy(Variable_4);
legend('DSP','Hamming','Blackman','welch');
title('figure10');
xlabel('frequences (HZ)');
xlabel('Fréquence (Hz)');


