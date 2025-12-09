close all;

% Number of samples taken
n = 1000;

% Number of bins
bins = 50;

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
fontsize(scale=2.5)
plot(x_values, scale.*f(x_values));
title('Markov Chain Histogram with $10^4$ Samples', 'Interpreter', 'latex')
xlabel('Probability Space') 
ylabel('Number of States from Markov Chain') 
legend("Histogram of Results from Metropolis-Hastings", "$e^{-5(x-0.5)^2}\cos{(3 \pi x)} + 1$", "Interpreter", "latex", 'Location', 'northwest');
