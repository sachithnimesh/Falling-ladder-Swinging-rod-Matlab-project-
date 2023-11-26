% Given values
theta_0 = pi / 6; % Initial angle of the ladder
omega_0 = 0; % Initial angular velocity
mu_k = 0.1; % Coefficient of kinetic friction
L = 5; % Length of the ladder (in meters)
W = 25; % Weight of the ladder (in kg)
g = 9.81; % Acceleration due to gravity (in m/s^2)

% Create an array of initial angles to investigate
theta_0_values = linspace(0, pi/2, 100); % Vary from 0 to pi/2

% Initialize arrays to store accelerations
ax_values = zeros(size(theta_0_values));
ay_values = zeros(size(theta_0_values));
atheta_values = zeros(size(theta_0_values));

% Iterate through different initial angles
for i = 1:length(theta_0_values)
    theta_0 = theta_0_values(i);

    % Create coefficient matrices
    A = [-mu_k, 0, 1, 0, 0, 0, 0; 
         0, -mu_k, 0, 1, 0, 0, 0; 
         1, 0, 0, -1, -W/g, 0, 0; 
         0, 1, 1, 0, 0, -W/g, 0; 
         cos(theta_0), -sin(theta_0), -sin(theta_0), cos(theta_0), 0, 0, (W*L)/(6*g); 
         0, 0, 0, 0, 2, 0, -L*cos(theta_0); 
         0, 0, 0, 0, 0, 2, L*sin(theta_0)];
    
    B = [0; 0; 0; W; 0; 0; 0];

    % Solve for accelerations
    accelerations = A \ B;
    
    % Store the results
    ax_values(i) = accelerations(5);
    ay_values(i) = accelerations(6);
    atheta_values(i) = accelerations(7);
end

% Create the plot
figure;
plot(theta_0_values, ax_values, 'b', 'LineWidth', 2);
hold on;
plot(theta_0_values, ay_values, 'r', 'LineWidth', 2);
plot(theta_0_values, atheta_values, 'k', 'LineWidth', 2);

% Add labels and legend
xlabel('Initial Angle (θ_0)');
ylabel('Accelerations');
legend('ax', 'ay', 'aθ');
title('Ladder Motion Accelerations vs. Initial Angle');
grid on;

% Find the critical value of theta_0 (where the curves intersect)
critical_theta_0 = theta_0_values(abs(ax_values - ay_values) < 0.001);

% Display the critical angle
disp(['The critical angle is approximately θ_0 = ', num2str(critical_theta_0)]);

% End of the code
