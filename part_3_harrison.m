function energy = energy(spins)
	energy = 0;
	for i = 1:(length(spins)-1)
		energy = energy + spins(i)*spins(i+1);
	end
	energy = -energy;
end

function magnetisation = magnetisation(spins)
	magnetisation = sum(spins, 2) ./ size(spins, 2);
end

function magnetisations = ising_model_magnetisations(number_of_iterations, number_of_spins, temperature)
	magnetisations = zeros(number_of_iterations, 1);

	initial_spins = (randi(2, 1, number_of_spins) - 1) * 2 - 1;
	spins = initial_spins;
	magnetisations(1) = magnetisation(spins);

	f = @(spins) exp(-energy(spins)/temperature);

	for i = 1:(number_of_iterations-1)
		proposal_flip = randi(number_of_spins);
		proposal_spins = spins;
		proposal_spins(proposal_flip) = proposal_spins(proposal_flip) * -1;
		acceptance_probability = f(proposal_spins) / f(spins);
		if rand < acceptance_probability
			spins = proposal_spins;
			magnetisations(i) = magnetisation(spins);
		else
			magnetisations(i) = magnetisation(spins);
		end
	end
end

close all;

% Number of iterations
n = 10000000;

% Number of spins
N = 100;

% Temperatures
temperatures = [1, 2, 5, 20];
magnetisations = zeros(n, length(temperatures));

for i = 1:length(temperatures)
	magnetisations(:, i) = ising_model_magnetisations(n, N, temperatures(i));
end

figure;

for i = 1:length(temperatures)
	subplot(1, length(temperatures), i);
	plot(magnetisations(:, i));
	ylim([-1, 1]);
end

figure;

% Number of bins
bins = 20;

for i = 1:length(temperatures)
	%subplot(1, length(temperatures), i);
	histogram(magnetisations(:, i), bins);
	hold on;
	%title("T = " + temperatures(i));
	xlim([-1, 1]);
	%ylim([0, 2.5*10^6]);
end

legend("T = 1", "T = 2", "T = 5", "T = 20");

exportgraphics(gcf, "part_3.pdf");
