% DC_MOTOR_DATA_SHOWING
%==========================================================================
clear 
close all
% warnning off
clc
%==========================================================================
% global Ke R L Kt b J
% motor physiacl characteristics..
% MOTOR CHARACTERISTICS..
Ke  = 0.57;           % electromotive force constant.
Ra  = 9.375 ;         % electric resistance.
La  = 0.143;          % electric inductance.
Kt  = 0.259;          % motor torque constant.
Bm  = 0.0158;         % motor ciscous friction constant. 
Jm  = 0.00252;        % moment of inertia of the rotor.

% Ke  = 0.57 ;
% Ra  = 9.375 ;
% La  = 6e-4;
% Kt  = 0.196 ;
% Bm  = 9.3e-4;
% Jm  = 5.26e-5;

B_roller    = 0;
B_material  = 0;

J_roller   = 9.734e-5 ;
J_material = 5.618e-6 ;

JL = J_roller + J_material ;
BL = B_roller + B_material ;

Jt = Jm + JL ;
Bt = Bm + BL ;


Gear_ratio = 210;
TL = 0.0017;

pi = 3.14;
r  = 0.005;

Max_Voltage =6;
ST =10;
%==========================================================================
% inital conditions..
i0 =0;
theta_dot0 = 0;
%==========================================================================
% PID parameters..
% Kp =  2.1398;
% Ki =  39.9;
% Kd =  0.0189;
Kp = 2.17;
Ki = 20;
Kd = 0.019;
%==========================================================================
input_values  = [0.16666 0.332328 0.6667 0.999 1.33 1.666 3.33 ];
Torque_Values =  zeros(1,9);
for i = 1:9;
    V_RAD = input_values(i);
    modelName = 'DC_Motor_Load_PID_block_tuning_unit_response.slx';
    simOut    = sim ( modelName , 'SrcWorkspace','current');
    
    FIGURE(1) = figure(i);
    FIGURE(1) = plot(simOut.get('Theta_dot').get('Time'),simOut.get('Theta_dot').get('Data'),'lineWidth',2.5);
    hold on
    %================================
    FIGURE(2) = plot(simOut.get('Torque').get('Time'),simOut.get('Torque').get('Data'),'LineStyle',':','lineWidth',2);
    %================================
    %LABLES %
    ylabel ('$$\dot{theta} _ Torque $$' ,'Interpreter','latex','FontSize',14,'FontWeight','bold');
    xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
    %================================
    grid on
    set(gcf, 'Name', 'input speed step with torque required')    
    leg = legend ( [FIGURE(1)  FIGURE(2)],'$$\dot{theta}$$','Required_Torque kg.mm');
    set( leg ,'Interpreter','latex','FontSize',10);
    hold on
end
%     % FIGURE(2)--------> plot reference signal..
%     FIGURE(2) = plot(simOut.get('Reference').get('Time'),simOut.get('Reference').get('Data'),'LineStyle','--','color','blue','lineWidth',2);
%     hold on
%     %leg1 = legend  ((FIGURE(3)),'Required_Torque');
%     %==========================================================================
% %     % FIGURE(2) ========> ERROR 
% %     FIGURE(2) = figure(2);
% %     %=================================
% %     FIGURE(1) = plot(simOut.get('ERROR').get('Time'),simOut.get('ERROR').get('Data'),'color','red','lineWidth',2.5);
% %     %=================================
% %     % LABLES %
% %     ylabel ('ERROR','FontSize',14,'FontWeight','bold');
% %     xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
% %     %=================================
% %     grid on
% %     set(gcf, 'Name', 'error signal with time')
% %     hold on
% %     %=================================    
% end
% 
%    
% %     plot (input_values );
% %     plot (Torque_Values);
% % %==========================================================================
% simulate model "PID_CONTROLLER_DC_MOTOR.slx" with every run for editor code..
modelName = 'DC_Motor_Load_PID_block_tuning_unit_response.slx';
simOut    = sim ( modelName , 'SrcWorkspace','current');
%==========================================================================
% FIGURES   %
% Theta_dot_output %
%==========================================================================
% FIGURE(1)--------> plot theta dot data..
FIGURE(1) = figure(1);
FIGURE(1) = plot(simOut.get('Theta_dot').get('Time'),simOut.get('Theta_dot').get('Data'),'color','red','lineWidth',2.5);
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
FIGURE(1) = plot(simOut.get('ERROR').get('Time'),simOut.get('ERROR').get('Data'),'color','red','lineWidth',2.5);
%=================================
% LABLES %
ylabel ('ERROR','FontSize',14,'FontWeight','bold');
xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
%=================================
grid on
set(gcf, 'Name', 'error signal with time')
%=================================
hold on
FIGURE(3) = figure(3);
%=================================
FIGURE(3) = plot(simOut.get('Voltage').get('Time'),simOut.get('Voltage').get('Data'),'color','green','lineWidth',2.5);
% LABLES %
ylabel ('Voltage','FontSize',14,'FontWeight','bold');
xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
%=================================
grid on
set(gcf, 'Name', 'Voltage with time')
%=================================
%=================================
% ==========================================================================
% end
% in case of theta_dot_structure.
% plot(simOut.theta.dot.time,simOut.theta.dot.signals.values);
% 
% in case of theta_dot_array.
% add time clock to block digram ----> ST is implementrd in simulation.
% plot(simOut.time,simOut.theta.dot);
% ==========================================================================
