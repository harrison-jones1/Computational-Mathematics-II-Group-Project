close all;

% Number of samples taken
n = 10000;

markov_chain = zeros(n,3);

v = randn(1,3);
markov_chain(1,:) = v / norm(v);

for i = 1:(n-1)
	proposal = markov_chain(i,:) + 0.1*randn(1,3); % creates little step off the sphere
    proposal = proposal / norm(proposal); % renormalises and adds back to the surface of the sphere

	acceptance_probability = 1;

	if rand < acceptance_probability
		markov_chain(i+1,:) = proposal;
	else
		markov_chain(i+1,:) = markov_chain(i,:);
	end
end
figure; scatter3(markov_chain(:,1), markov_chain(:,2), markov_chain(:,3), 5);
xlabel("x"); ylabel("y");
title("Metropolis–Hastings samples on the sphere");
axis equal;
