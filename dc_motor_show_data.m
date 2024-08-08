% DC_MOTOR_DATA_SHOWING
%==========================================================================
clear 
close all
% warnning off
clc
%==========================================================================
global Ke R L Kt b J
% motor physiacl characteristics..
% MOTOR CHARACTERISTICS..
Ke = 0.57;           % electromotive force constant.
R  = 9.375 ;         % electric resistance.
L  = 0.143;          % electric inductance.
Kt = 0.259;          % motor torque constant.
b  = 0.0158;         % motor ciscous friction constant. 
J  = 0.00252;        % moment of inertia of the rotor.
ST =10;
%==========================================================================
% inital conditions..
i0 =0;
theta_dot0 = 0;
%==========================================================================
% PID parameters..
% Kp =  16.4;
% Ki =  21.5;
% Kd =  8.33;
 Kp =  2.1398;
Ki =  39.9;
Kd =  0.0189;
%==========================================================================
% simulate model "PID_CONTROLLER_DC_MOTOR.slx" with every run for editor code..
modelName = 'PID_CONTROLLER_DC_MOTOR_FIRST.slx';
simOut    = sim ( modelName , 'SrcWorkspace','current');
%==========================================================================
% FIGURES   %
% Theta_dot_output %
%==========================================================================
% FIGURE(1)--------> plot theta dot data..
FIGURE(1) = figure(1);
FIGURE(1) = plot(simOut.get('theta_dot').get('Time'),simOut.get('theta_dot').get('Data'),'color','red','lineWidth',2.5);
hold on
%================================
% FIGURE(2)--------> plot reference signal..
FIGURE(2) = plot(simOut.get('Reference').get('Time'),simOut.get('Reference').get('Data'),'LineStyle','--','color','blue','lineWidth',2);
%================================
% LABLES %
ylabel ('$$\dot{theta}$$','Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
%================================
% LEGENDS %
leg = legend ( [FIGURE(1)  FIGURE(2)],'$$\dot{theta}$$','Ref');
set( leg ,'Interpreter','latex','FontSize',14);
%=================================
grid on
set(gcf, 'Name', 'Ref vs Output signal with time')
%==========================================================================
% FIGURE(2) ========> ERROR 

FIGURE(2) = figure(2);
%=================================
FIGURE(1) = plot(simOut.get('error').get('Time'),simOut.get('error').get('Data'),'color','red','lineWidth',2.5);
%=================================
% LABLES %
ylabel ('error','FontSize',14,'FontWeight','bold');
xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
%=================================
grid on
set(gcf, 'Name', 'error signal with time')
%=================================

% in case of theta_dot_structure.
% plot(simOut.theta.dot.time,simOut.theta.dot.signals.values);

% in case of theta_dot_array.
% add time clock to block digram ----> ST is implementrd in simulation.
% plot(simOut.time,simOut.theta.dot);
%==========================================================================
