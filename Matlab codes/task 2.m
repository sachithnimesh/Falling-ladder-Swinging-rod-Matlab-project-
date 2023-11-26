function ladder_fall()
    global mu g L W;
    mu = 0.1;
    g = 9.81;
    L = 5;
    W = 25;

    % Initial conditions
    tspan = [0 2.5]; % Time span for simulation
    Z0 = [theta_0, 0]; % Initial theta and initial angular velocity

    % Solve ODE using ode45
    [t, Z] = ode45(@ode_equations, tspan, Z0);

    % Extract theta and omega from Z
    theta = Z(:, 1);
    omega = Z(:, 2);

    % Find the time t_end when theta exceeds pi/2
    t_end = t(find(theta > pi/2, 1));

    % Plot theta(t) and omega(t)
    figure;
    subplot(2, 1, 1);
    plot(t, theta);
    xlabel('Time (s)');
    ylabel('Theta (rad)');
    title('Theta vs. Time');

    subplot(2, 1, 2);
    plot(t, omega);
    xlabel('Time (s)');
    ylabel('Omega (rad/s)');
    title('Omega vs. Time');
end

function dZdt = ode_equations(t, Z)
    global mu g L W;
    theta = Z(1);
    omega = Z(2);

    % Define the system of ODEs
    dtheta = omega;
    domega = (-mu * g * cos(theta) - mu * omega^2 * sin(theta) + W) / (L * (1 + mu^2));

    dZdt = [dtheta; domega];
end
