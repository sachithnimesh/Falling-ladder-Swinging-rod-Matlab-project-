function swinging_rod()

    % Define the constants
    L = 2;  % Length of the rod (in meters)
    g = 9.81;  % Acceleration due to gravity (in m/s^2)
    c_f = 0.2;  % Damping coefficient
    m = 1;  % Mass of the rod (in kg)

    % Initial conditions
    theta_0 = 0;  % Initial angular position
    omega_0 = 0;  % Initial angular velocity

    % Time span for simulation (0 to 20 seconds)
    tspan = [0 20];

    % Solve the system of ODEs using ode45
    [t, Z] = ode45(@ode_equations, tspan, [theta_0, omega_0]);

    % Extract theta from Z
    theta = Z(:, 1);

    % Plot theta(t)
    figure;
    plot(t, theta);
    xlabel('Time (s)');
    ylabel('Theta (rad)');
    title('Theta vs. Time');

end

function dZdt = ode_equations(t, Z)
    % Unpack variables
    theta = Z(1);
    omega = Z(2);

    % Define the ODEs
    dtheta = omega;
    domega = (3 * g * cos(theta)) / (2 * L) - (3 * c_f * sign(omega)) / (m * L^2);

    % Pack the derivatives
    dZdt = [dtheta; domega];
end

% Call the main function
swinging_rod();
