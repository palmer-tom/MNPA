%
% ELEC 4700 PA 7
%
% MNA Building
%
% Tom Palmer - 101045113
%
% 28 FEB 2020
%

% Setup
clear
clc

% Define Variables
w = 200;
s = 1i*w;
G1 = 1/1;
G2 = 1/2;
G3 = 1/10;
G4 = 1/0.1;
G0 = 1/1000;
c = 0.25;
L = 0.2;
a = 100;

% Define Matrix

G = [0,  1,     0,              0,           0,    0,        0;
     1,  G1,    -G1,            0,           0,    0,        0;
     0,  -G1,   G1-G2+1/(s*L),  -1/(s*L),    0,    0,        0;
     0,  0,     -1/(s*L),       1/(s*L)-G3,  0,    0,        0;
     0,  0,     0,              0,           -1,   0,        a;
     0,  0,     0,              0,           G4,   -G4-G0,   0;
     0,  0,     0,              G3,          0,    0,        -1];

 C = [0,  0,   0,   0,  0,  0,  0;
      0,  c,   -c,  0,  0,  0,  0;
      0,  -c,  c,   0,  0,  0,  0;
      0,  0,   0,   0,  0,  0,  0;
      0,  0,   0,   0,  0,  0,  0;
      0,  0,   0,   0,  0,  0,  0;
      0,  0,   0,   0,  0,  0,  0];
  
  
for Vin = -10:0.1:10

    F = [Vin;
       0;
       0;
       0;
       0;
       0;
       0];

    V = (G+(s.*C))\F;

    figure(1)
    plot(Vin, real(V(6)), 'r.')
%     xlim([-10 10]);
%     ylim([-120 120]);
    xlabel('Input Voltage, V1 (V)')
    ylabel('Output Voltage, VO (V)')
    hold on
end


for Vin = -10:0.1:10
  
    F = [Vin;
       0;
       0;
       0;
       0;
       0;
       0];

    V = (G+(s.*C))\F;

    figure(2)
    plot(Vin, real(V(3)), 'b.')
%     xlim([-10 10]);
%     ylim([-20 20]);
    xlabel('Input Voltage, V1 (V)')
    ylabel('Node Voltage, V3 (V)')
    hold on
end


Vin = 1;
F = [Vin;
     0;
     0;
     0;
     0;
     0;
     0];
Vfreq = zeros(1,1000);
W = logspace(-3,3,1000);
for n = 1:1000
    
    s = 1i*W(n);
    
    G = [0,  1,     0,              0,           0,    0,        0;
         1,  G1,    -G1,            0,           0,    0,        0;
         0,  -G1,   G1-G2+1/(s*L),  -1/(s*L),    0,    0,        0;
         0,  0,     -1/(s*L),       1/(s*L)-G3,  0,    0,        0;
         0,  0,     0,              0,           -1,   0,        a;
         0,  0,     0,              0,           G4,   -G4-G0,   0;
         0,  0,     0,              G3,          0,    0,        -1];

    V = (G+(s.*C))\F;
    
    Vfreq(1,n) = real(V(6));
    
end

figure(3)
    semilogx(W,Vfreq)
    xlabel('Frequency (rad/s)')
    ylabel('Output Voltage, VO (V)')
    
figure(4)
    semilogx(W,20*log10(Vfreq./Vin))
    xlabel('Frequency (rad/s)')
    ylabel('Circuit Gain, Vo/V1 (dB)')
 

    
c = 0.05.*randn(1,5000) + 0.25;
Vpert = zeros(1,5000);
s = 1i*pi;
G = [0,  1,     0,              0,           0,    0,        0;
     1,  G1,    -G1,            0,           0,    0,        0;
     0,  -G1,   G1-G2+1/(s*L),  -1/(s*L),    0,    0,        0;
     0,  0,     -1/(s*L),       1/(s*L)-G3,  0,    0,        0;
     0,  0,     0,              0,           -1,   0,        a;
     0,  0,     0,              0,           G4,   -G4-G0,   0;
     0,  0,     0,              G3,          0,    0,        -1];

for n = 1:5000
    
C = [0,  0,        0,        0,  0,  0,  0;
     0,  c(1,n),   -c(1,n),  0,  0,  0,  0;
     0,  -c(1,n),  c(1,n),   0,  0,  0,  0;
     0,  0,        0,        0,  0,  0,  0;
     0,  0,        0,        0,  0,  0,  0;
     0,  0,        0,        0,  0,  0,  0;
     0,  0,        0,        0,  0,  0,  0];
 
 V = (G+(s.*C))\F;
 Vpert(1,n) = 20*log10(real(V(6))/Vin);
end

figure(5)
histogram(Vpert,100)
xlabel('Gain (dB)')
ylabel('Number of Occurences')
 
   
   
  