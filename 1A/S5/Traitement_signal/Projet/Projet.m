close all;
clear;
clc;
load donnees1.mat;
load donnees2.mat;

%Paramètres
fp1= 0;
fp2=46000;
T=0.04;
Fe=128000;
Te=1/Fe;
Ns=Fe * (T / length(bits_utilisateur1)); %Ns==10
Ts=Ns*Te;

%3.2.1 Modulation bande base
%1/
m1=kron(2*bits_utilisateur1 -1, ones(1,Ns));
m2=kron(2*bits_utilisateur2 -1, ones(1,Ns));
t1=(0 : Te : (length(m1) - 1) * Te);
t2=(0 : Te : (length(m2) - 1) * Te);
%2/
figure;
subplot(211);
plot(t1,m1);
title('Figure 1 : m1(t)');
xlabel('Temps en secondes')
ylabel('Amplitude')
ylim([-1.5,1.5]);
subplot(212);
plot(t2,m2,'color',[0.8500, 0.3250, 0.0980]);
title('Figure 2 : m2(t)');
xlabel('Temps en secondes')
ylabel('Amplitude')
ylim([-1.5,1.5]);

%3/
pxx1=(1/Ns) * abs(fftshift(fft((m1)))).^2;
pxx2=(1/Ns) * abs(fftshift(fft((m2)))).^2;
w1 = -Fe : 2*Fe/(length(pxx1)-1) :  Fe;
w2 = -Fe : 2*Fe/(length(pxx2) -1) : Fe;
figure;
subplot(211);
plot(w1,pxx1); title('Figure 3: DSP de m1');
subplot(212); plot(w2,pxx2,'color',[0.8500, 0.3250, 0.0980]);
title('Figure 4: DSP de m2');
xlabel('Fréquence en Hz')
ylabel('DSP')

%3.2.2 Construction du signal MF-TDMA
%1/
sp1 = [zeros(1, length(m1)), m1, zeros(1, 3 * length(m1))];
sp2 = [zeros(1, 4 * length(m2)), m2];
sp = [zeros(1, length(m1)), m1, zeros(1, 2 * length(m1)), m2];
t=0:Te:(length(sp1)-1)*Te;

figure;
plot(t,sp1);hold on; plot(t,sp2); 
title('Figure 4');
legend('Message 1 dans le slot 2', 'Message 2 dans le slot 5');

%2/
%p1=cos(2*pi*fp1*t) == 0;
p2=cos(2*pi*fp2*t);
x1=sp1;
x2=sp2.* p2;

% Construction du signal MF-TDMA
x_intermediaire=x1 + x2;
Ps=mean(x_intermediaire.^ 2); %Puissance du signal

SNR = 100; %Rapport signal sur bruit
Pbr=Ps/(10^(SNR/10)); %Puissance du bruit

N_Gauss=randn(1,length(sp));
BG=sqrt(Pbr)*N_Gauss; %Bruit gaussien

x=sp + BG; %signal MF-TDMA

figure;
plot(t,x);
title('Figure 5 : Signal MF-TDMA');
xlabel('Temps en secondes');
ylabel('Signal');

%3/
DSPx=(1/Ns^2) * abs(fftshift(fft((x)))).^ 2;
figure;
plot((-Fe : 2*Fe/(length(fft(x))-1) : Fe),DSPx);
title('Figure 6: DSP du signal MF-TDMA');
xlabel('Fréquence en Hz');
ylabel('DSP');

%4.1 Démultiplexage des porteuses
%4.1.1 Synthèse du filtre passe-bas
%1/
Fc=fp2/2;   %fréquence de coupure
N=30;
k = -N:N;
pb = 2*(Fc/Fe)*sinc(2*(Fc/Fe)*k);
figure;
subplot(211);
plot(k,pb)
title('Figure 7 : Réponse impulsionnelle du filtre passe-bas');
xlabel("Temps en secondes");

%2)
freq=-Fe/2 : Fe/(length(pb)-1):Fe/2;
HPB=fftshift(fft(pb));
subplot(212);
plot(freq,abs(HPB));
title('Figure 8: Transformée de Fourier de la réponse impulsionnelle');
xlabel("Fréquence en Hz");

figure;
DSPx_normalisee=(1/max(DSPx))*DSPx;
plot((-Fe : 2*Fe/(length(DSPx)-1) : Fe), DSPx_normalisee);
title('Figure 9');
xlabel('Fréquence en Hz');
ylabel('Amplitude en V');
hold on;
DSPpb=(1/Ns)*(abs(HPB)).^2;
plot((-Fe : 2*Fe/(length(DSPpb) -1) : Fe), abs(HPB))
legend('DSP', 'Module de la réponse en fréquences du filtre passe-bas')


%4.1.2 Synthèse du filtre passe-haut
%1/
DIRAC= dirac(Te*k);
DIRAC(DIRAC==Inf)=1;
ph= DIRAC - pb;
figure;
subplot(211);
plot(k,ph);
title('Figure 10: Réponse impulsionnelle du filre passe-haut');
xlabel('Temps en secondes');

%2/
HPH=fftshift(fft(ph));
subplot(212);
plot(freq, abs(HPH));
title('Figure 11: Réponse en fréquence du filtre passe-haut');
xlabel('Fréquence en Hz');

%3/
figure;
plot((-Fe/2 : Fe/(length(DSPx)-1) : Fe/2), DSPx_normalisee );
title('Figure 12');
xlabel('Fréquence en Hz');
ylabel('Amplitude en V');
hold on;
plot((-Fe/2 : Fe/(length(fft(HPH)) -1) : Fe/2), abs(HPH))
legend('DSP', 'Module de la réponse en fréquences du filtre passe-haut')

%4.1.3 Filtrage
msg1 = conv(x, pb, 'same');
msg2 = conv(x, ph, 'same');

figure; subplot(211);
plot(t,msg1);
title('Figure 13 : Message 1 après filtrage');
xlabel('Temps en secondes');
ylim([-1.5,1.5]);
subplot(212);
plot(t,msg2,'color',[0.8500, 0.3250, 0.0980]);
title('Figure 14 : Message 2 après filtrage');
xlabel('Temps en secondes');
ylim([-1.5,1.5]);

%4.2 Retour en bande de base
m_2 = msg2 .* cos(2*pi*fp2 * linspace(-1/fp2, 1/fp2, length(msg2)));
m1_filtrage = conv(msg1, pb, 'same'); m2_filtrage = conv(m_2, ph,'same');

%4.3 Détection du slot utile
x_apres_filtrage=m1_filtrage + m2_filtrage;
X_2=x_apres_filtrage(length(m1)+1 : 2*length(m1));
X_5=x_apres_filtrage(4*length(m1)+1 : end);

slot_utile = zeros(1,length(x_apres_filtrage));

%4.4 Démodulation bande de base
SignalFiltre=conv(X_2, ones(1,Ns), 'same');
SignalEchantillonne=SignalFiltre(1:Ns:end);
BitsRecuperes_1=(sign(SignalEchantillonne)+1)/2;

SignalFiltre=conv(X_5, ones(1,Ns), 'same');
SignalEchantillonne=SignalFiltre(1:Ns:end);
BitsRecuperes_2=(sign(SignalEchantillonne)+1)/2;

texte_1=bin2str(BitsRecuperes_1);
texte_2=bin2str(BitsRecuperes_2);
fprintf('Le message 1 est :\n\t %s\n\n', texte_1);
fprintf('Le message 2 est :\n\t %s\n', texte_2);