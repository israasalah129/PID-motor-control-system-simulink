%==========================================================================
% SCRIPT FILE FOR THE INTERPRETED FUNCTION FOR DC_MOTOR_
% THIRD BLOCK IN THE MOTOR EQUATION REPRESENTATION_
%==========================================================================
function out = DC_MOTOR(u)

% INPUTS
v=u(1);
theta_dot=u(2);
i=u(3);

% IMPLEMENTED IN SIMULINK MODEL
time=u(4);

%========================
%  MOTOR CHARACTERISTICS  
Ke = 0.1;
R  = 3;
L = 0.5;
Kt = 0.2;
b = 0.05;
J = 0.02;
%========================
% OUTPUTS
theta_double_dot = (Kt*i-b*theta_dot)/J ;
i_dot = (v-Ke*theta_dot-R*i)/L ;

out = [theta_double_dot ; i_dot];

hold on
% PLOT VOLTGAE WITH TIME
plot(time,v,'.');
%========================
end

