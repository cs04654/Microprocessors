function MCpi(N)
    Esquare = 1; % area of the square with side length a=1
    r = 0.5; % radius of the circle
    Ecircle = pi * r^2; % area of the circle

    countInside = 0; % Counter for points inside the circle

    for i = 1:N
        x = rand(); % generate random x coordinate
        y = rand(); % generate random y coordinate

        if (x - 0.5)^2 + (y - 0.5)^2 <= 0.5^2 % check if the point is inside the circle
            countInside = countInside + 1;
        end
    end

    ratio = countInside / N; % ratio of points inside the circle to total points
    pi_approx = ratio * 4; % approximation of pi

    disp(['For N = ', num2str(N), ', the approximation of pi is: ', num2str(pi_approx)]);
end