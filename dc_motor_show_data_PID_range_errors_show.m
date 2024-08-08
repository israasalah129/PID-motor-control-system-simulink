% DC_MOTOR_DATA_SHOWING
%==========================================================================
clear 
close all
% warnning off
clc
%==========================================================================
global Ke R L Kt b J
% motor physiacl characteristics..

Ke = 0.1;          % electromotive force constant.
R  = 3;            % electric resistance.
L = 0.5;           % electric inductance.
Kt = 0.2;          % motor torque constant.
b = 0.05;          % motor ciscous friction constant. 
J = 0.02;          % moment of inertia of the rotor.
ST =10;
%==========================================================================
% inital conditions..
i0 =0;
theta_dot0 = 0;
%==========================================================================
% PID parameters..
Kp = 1.25 ;
Kd = 0.09 ;
Ki = 2.98 ;
%==========================================================================
% simulate model "PID_CONTROLLER_DC_MOTOR.slx" with every run for editor code..
modelName = 'PID_CONTROLLER_DC_MOTOR.slx';
simOut  = sim ( modelName , 'SrcWorkspace','current');
%==========================================================================
% Elapsed time show %
%==========================================================================
% simulate model "PID_CONTROLLER_DC_MOTOR.slx" with every run for editor code..
% Get the different error types values for a range/ different values of pid
% parameters.

k=1;
% Proportional gain loop.
for Kp= [ 0.5 0.8 1 1.6 ]
    % Integral gain loop.
    for Ki= [1 3]
        % derivative gain loop.
        for kd= [0.05 0.09]
            
            % Start timer to calc simulation time for model.
            tic
            
            % simulate model "PID_CONTROLLER_DC_MOTOR.slx" with every run for editor code.
            modelName = 'PID_CONTROLLER_DC_MOTOR.slx';
            simOut  = sim ( modelName , 'SrcWorkspace','current');
            
            % Store values of pid parameters with its errors values.
            KP(k,1)= Kp;
            KI(k,1)= Kp;
            KD(k,1)= Kp;

            ISE(k,1)  = simOut.get('ISE').get('Data');
            IAE(k,1)  = simOut.get('IAE').get('Data');
            ITSE(k,1) = simOut.get('ITSE').get('Data');
            ITAE(k,1) = simOut.get('ITAE').get('Data');
            Max_Voltage(k,1) = abs(simOut.get('voltage').get('Data'));
            
            % stop timer.
            simulation_time = toc;
            
            k=k+1;
        end
    end
end

% Make a table for displaying.
Table = table(KP,KI,KD.ISE,IAE,ITSE,ITAE,Max_Voltage,simulation_time);
disp(Table);