% DC_MOTOR_DATA_SHOWING
%==========================================================================
clear 
close all
%warnning off
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
% Elapsed time show %
%==========================================================================
% simulate model "PID_CONTROLLER_DC_MOTOR.slx" with every run for editor code..
% create a 1x10 vector that will store the values of simulation times.
simulation_time = zeros(10,1);
% for loop for 10 times simulationsto get the average simulation time.
%====================================================================
for k = 1:1:10
% start timer.
tic

modelName = 'PID_CONTROLLER_DC_MOTOR.slx';
simOut  = sim ( modelName , 'SrcWorkspace','current');

% store value of current loop simulation time in element k.
simulation_time(k,1) = toc ;
% wait one second to complete the simulation before the next one.
pause(1)
end

%====================================================================
% Get the mean value of simulation time for this model.
mean(simulation_time)

% plot the simulation time 
plot(simulation_time,...
    'MarkerFaceColor','green',...
    'MarkerEdgeColor','red',...
    'MarkerSize',7,...
    'Marker','o',...
    'LineWidth',2,...
    'Color','blue')
%====================================================================
grid on
%====================================================================
ylabel('simulation time','FontSize',14,'FontWeight','bold');
%====================================================================