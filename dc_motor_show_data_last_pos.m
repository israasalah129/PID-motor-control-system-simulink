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
% Ke  = 0.57;           % electromotive force constant.
% Ra  = 9.375 ;         % electric resistance.
% La  = 0.143;          % electric inductance.
% Kt  = 0.259;          % motor torque constant.
% Bm  = 0.0158;         % motor ciscous friction constant. 
% Jm  = 0.00252;        % moment of inertia of the rotor.
theta_d = 0;

Ke  = 0.57 ;
Ra  = 9.375 ;
La  = 6e-4;
Kt  = 0.196 ;
Bm  = 9.3e-4;
Jm  = 5.26e-5;

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
Kp =  14;
Ki =  22;
Kd =  0.96;

% Kp = 0.01;
% Ki = 0.19;
% Kd = 9.03e-5;
%==========================================================================
% simulate model "PID_CONTROLLER_DC_MOTOR.slx" with every run for editor code..
modelName = 'DC_Motor_Load_PID_block_position_unit_response.slx';
simOut    = sim ( modelName , 'SrcWorkspace','current');
%==========================================================================
% FIGURES   %
% Theta_dot_output %
%==========================================================================
% FIGURE(1)--------> plot theta dot data..
FIGURE(1) = figure(1);
FIGURE(1) = plot(simOut.get('Theta').get('Time'),simOut.get('Theta').get('Data'),'color','red','lineWidth',2.5);
hold on
%================================
% FIGURE(2)--------> plot reference signal..
FIGURE(2) = plot(simOut.get('Reference').get('Time'),simOut.get('Reference').get('Data'),'LineStyle','--','color','blue','lineWidth',2);
%================================
% LABLES %
ylabel ('theta','Interpreter','latex','FontSize',14,'FontWeight','bold');
xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
%================================
% LEGENDS %
leg = legend ( [FIGURE(1)  FIGURE(2)],'theta','Ref');
set( leg ,'Interpreter','latex','FontSize',14);
%=================================
grid on
set(gcf, 'Name', 'Ref vs Output signal with time')
%==========================================================================
% FIGURE(2) ========> ERROR 

FIGURE(2) = figure(2);
%=================================
FIGURE(2) = plot(simOut.get('ERROR').get('Time'),simOut.get('ERROR').get('Data'),'color','red','lineWidth',2.5);
%=================================
% LABLES %
ylabel ('ERROR','FontSize',14,'FontWeight','bold');
xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
%=================================
grid on
set(gcf, 'Name', 'error signal with time')
hold on
%=================================
FIGURE(3) = figure(3);
FIGURE(3) = plot(simOut.get('PWM').get('Time'),simOut.get('PWM').get('Data'),'color','red','lineWidth',2.5);
%=================================
% LABLES %
ylabel ('PWM','FontSize',14,'FontWeight','bold');
xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
%=================================
grid on
set(gcf, 'Name', ' PWM with time')
hold on
%=================================
%==========================================================================
% % Load the Simulink model
% modelName = 'DC_Motor_Load_PID_block_position_unit_response.slx';
% 
% % Define the range of desired angles
% theta_d_range = -pi:pi/8:pi;
% 
% % Preallocate arrays to store the results
% pwm_range = cell(length(theta_d_range), 1);
% theta_d_values = zeros(length(theta_d_range), 1);
% 
% % Create a workspace structure to pass the desired angle values
% simworkspace = Simulink.SimulationData.createStructure;
% simworkspace.assignin('base', 'theta_d', 0); % Initialize the theta_d variable
% 
% % Simulate the model for each desired angle and extract the PWM values
% for i = 1:length(theta_d_range)
%     theta_d = theta_d_range(i);
%     
%     % Update the workspace structure with the current desired angle
%     simworkspace.theta_d = theta_d;
%     assignin('base', 'theta_d', theta_d);
%     
%     % Simulate the model using the workspace structure
%     simOut    = sim ( modelName , 'SrcWorkspace','current');
%     
%     % Extract the PWM values from the simulation output
%     pwm =simOut.get('PWM');
%     
%     % Store the PWM values and the desired angle
%     pwm_range{i} = pwm;
%     theta_d_values(i) = theta_d;
%     
%     % Plot the PWM response for the current desired angle
%     figure;
%     plot(simOut.get('tout'), pwm);
%     xlabel('Time (s)');
%     ylabel('PWM');
%     title(['Desired Angle: ', num2str(theta_d), ' rad']);
%     grid on;
% end
% in case of theta_dot_structure.
% plot(simOut.theta.dot.time,simOut.theta.dot.signals.values);
% 
% in case of theta_dot_array.
% add time clock to block digram ----> ST is implementrd in simulation.
% plot(simOut.time,simOut.theta.dot);
% ==========================================================================
