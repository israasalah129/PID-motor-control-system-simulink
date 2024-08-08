clear
clc
%==========================================================================
Ke = 0.57;           % electromotive force constant.
R  = 9.375 ;         % electric resistance.
L  = 0.143;          % electric inductance.
Kt = 0.259;          % motor torque constant.
b  = 0.0158;         % motor ciscous friction constant. 
J  = 0.00252;        % moment of inertia of the rotor.

% MATRICES..
A  = [ -R/L    -Ke/L   0;
        Kt/J   -b/J    0;
        0       1      0 ];

B  = [ 1/L; 0; 0];
Ct = [ 0 0 1];
D  =   0; 
%==========================================================================
% CONVERT STATE SPACE MODEL TO TRANSFER FUNCTION..
[num, den] = ss2tf(A, B, Ct, D);
GP = tf(num,den);
%==========================================================================
%PID Controller design using Zeigler-Nichols method. 
%Calculate pid parameters for three cases..
%=======================
K_cr = 82;
frequency =28.64;

P_cr =( 2 *3.14 )/ 4.12;
% VALUE TAKEN FROM GRAPH WHEN SYSTEM IS SUSTAINED OSCILLATORY "CONSTANT AMPLITUDE"
%=======================
   Kp = 0.6*K_cr;   Ti = 0.5*P_cr;   Td = 0.125*P_cr;    % Classical 
   Ki = Kp/Ti;     
   Kd = Kp*Td;
   disp('Used Classical type of Zeigler-Nichols method'); 
   disp ([ 'K_cr =  ' , num2str(Kp) ]);
   disp ([ 'P_cr =  ' , num2str(P_cr)]);
   disp ([ 'Ti =  '   , num2str(Ti) ]);
   disp ([ 'Td =  '   , num2str(Td) ]);
   disp ([ 'Kp =  '   , num2str(Kp) ]);
   disp ([ 'Ki =  '   , num2str(Ki) ]);
   disp ([ 'Kd =  '   , num2str(Kd) ]);
   disp ('=================================================>');
 %=======================
   Kp = K_cr/3;     Ti = 0.5*P_cr;   Td = P_cr/3;        % some overshoot
   Ki = Kp/Ti;     
   Kd = Kp*Td;
   disp('Used some overshoot type of Zeigler-Nichols method');
   disp ([ 'K_cr =  ' , num2str(Kp) ]);
   disp ([ 'P_cr =  ' , num2str(P_cr)]);
   disp ([ 'Ti =  '   , num2str(Ti) ]);
   disp ([ 'Td =  '   , num2str(Td) ]);
   disp ([ 'Kp =  '   , num2str(Kp) ]);
   disp ([ 'Ki =  '   , num2str(Ki) ]);
   disp ([ 'Kd =  '   , num2str(Kd) ]);
   disp ('=================================================>');
 %=======================
   Kp = 0.2*K_cr;   Ti = 0.5*P_cr;   Td = P_cr/3;        % no overshoot 
   Ki = Kp/Ti;     
   Kd = Kp*Td;
   disp('Used no overshoot type of Zeigler-Nichols method');
   disp ([ 'K_cr =  ' , num2str(Kp) ]);
   disp ([ 'P_cr =  ' , num2str(P_cr)]);
   disp ([ 'Ti =  '   , num2str(Ti) ]);
   disp ([ 'Td =  '   , num2str(Td) ]);
   disp ([ 'Kp =  '   , num2str(Kp) ]);
   disp ([ 'Ki =  '   , num2str(Ki) ]);
   disp ([ 'Kd =  '   , num2str(Kd) ]);
   disp ('=================================================>');
%=========================================
% % Enter 1 for Classical, 2 for some overshoot, 3 for no overshoot.
% 
% x = input('Enter type of Zeigler-Nichols method: '); 
% s = tf('s'); 
%   %=======================
%  switch x    
%  case 1       
%   Kp = 0.6*K_cr;   Ti = 0.5*P_cr;   Td = 0.125*P_cr;    % Classical    
%   disp('Used Classical type of Zeigler-Nichols method'); 
%   %=======================
%  case 2         
%   Kp = K_cr/3;     Ti = 0.5*P_cr;   Td = P_cr/3;        % some overshoot  
%   disp('Used some overshoot type of Zeigler-Nichols method');
%   %=======================
%  otherwise        
%   Kp = 0.2*K_cr;   Ti = 0.5*P_cr;   Td = P_cr/3;        % no overshoot        
%   disp('Used no overshoot type of Zeigler-Nichols method');
%  end 
%   %=======================
%   % CALCULATE THE DERIVATIVR AND INTEGRAL PARAMETERS..
%   % PID PARAMETERS " ZEIGLER_NICHOLS "..
%   
% Ki = Kp/Ti;     
% Kd = Kp*Td;
% 
% CP = Kp+(Ki/s)+(s*Kd); 
% G = series(CP, GP);
% 
% sys = feedback(G,1); 
% step(sys,3)

 %=================================