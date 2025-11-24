n = 10000;

f = @(polar_angle) sin(polar_angle).^2; % Want more samples where to counterbalance sphere being wider near middle.

polar_angles = zeros(n, 1);
polar_angles(1) = rand*pi;

for i = 1:(n-1)
	proposal = rand*pi;
	acceptance_probability = f(proposal) / f(polar_angles(i));
	if rand < acceptance_probability
		polar_angles(i + 1) = proposal;
	else
		polar_angles(i + 1) = polar_angles(i);
	end
end


azimuth_angles = rand(n, 1) * 2 * pi - pi;

x = sin(polar_angles).*cos(azimuth_angles);
y = sin(polar_angles).*sin(azimuth_angles);
z = cos(polar_angles);

size(x)

plot3(x, y, z, "x");

axis equal
