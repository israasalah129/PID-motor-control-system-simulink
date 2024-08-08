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
% Elapsed time show %
%==========================================================================
for Kp= [ 0.5 0.8 1 1.6 ]
    for Ki= [1 3]
        for kd= [0.05 0.09]
            % simulate model "PID_CONTROLLER_DC_MOTOR.slx" with every run for editor code.
            modelName = 'PID_CONTROLLER_DC_MOTOR.slx';
            simOut  = sim ( modelName , 'SrcWorkspace','current');
            hold on
            
            % figure(1)====================================================
            figure(1);
            
            % plot Theta_dot with time.
            F(1) = plot(simOut.get('Theta_dot').get('Time'),simOut.get('Theta_dot').get('Data'),'lineWidth',2.5); 
            %==========================
            % F(2)--------> plot reference signal..
            F(2) = plot(simOut.get('Reference').get('Time'),simOut.get('Reference').get('Data'),'LineStyle','--','lineWidth',2.5);
            %==========================
            % LABLES %
            ylabel ('$$\dot{theta}$$','Interpreter','latex','FontSize',14,'FontWeight','bold');
            xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
            %==========================
            % LEGENDS %
            leg = legend ( [F(1),F(2)],'$$\dot{theta}$$','Ref');
            set( leg ,'Interpreter','latex','FontSize',14);
            %==========================
            grid on
            % delay to see %
            % pause(1);
            % figure(2)====================================================
            hold on
            
            figure(2);
            % plot error with time.
            F(3) = plot(simOut.get('error').get('Time'),simOut.get('error').get('Data'),'lineWidth',2.5);
            %==========================
            % LABLES %
            ylabel ('error','FontSize',14,'FontWeight','bold');
            xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
            %==========================
            % LEGENDS %
            leg = legend(F(3), 'error');
            set(leg,'FontSize',14);
            grid on
            % figure(3)====================================================
            hold on
            
            figure(3);
            % plot voltage with time.
            F(4) = plot(simOut.get('voltage').get('Time'),simOut.get('voltage').get('Data'),'lineWidth',2.5);
            %==========================
            % LABLES %
            ylabel ('voltage','FontSize',14,'FontWeight','bold');
            xlabel ( 'time(s)','FontSize',14,'FontWeight','bold');
            grid on
            %==========================
            % LEGENDS %
            leg = legend(F(4), 'voltage');
            set(leg,'FontSize',14);
            %==========================
        end % end of kd loop.
        %==========================================================================
    end % end of ki loop.
    %==========================================================================
end % end of kp loop.