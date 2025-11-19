close all;

% Number of samples taken
n = 1000000;

% Number of bins
bins = 100;

markov_chain = zeros(n,1);

f = @(x) exp(-5.*(x-0.5).^2).*cos(3.*pi.*x) + 1;

markov_chain(1) = rand;

for i = 1:(n-1)
	proposal = rand;
	acceptance_probability = f(proposal) / f(markov_chain(i));
	if rand < acceptance_probability
		markov_chain(i + 1) = proposal;
	else
		markov_chain(i + 1) = markov_chain(i);
	end
end

histogram(markov_chain, bins);
hold on;
x_values = linspace(0, 1, bins);
scale = n / bins;
plot(x_values, scale.*f(x_values));
legend("Histogram of Results from Metropolis-Hastings", "$e^{-5(x-0.5)^2}\cos{(3 \pi x)} + 1$", "Interpreter", "latex");