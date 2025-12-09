close all;
%initialise variables
bins = 50;
x_values = floor(logspace(4,8,25));
y_values = zeros(5,1);
loop = 0;

for n = x_values
    %Harrison's MH code
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
    
    %KL Divergence
    KLDiv = 0;
    for j = 1:bins
        lower = (j-1)/bins;
        upper = j/bins;
        count = sum(markov_chain >= lower & markov_chain <= upper);
        p = f((2*j-1)/(2*bins));
        q = ((count*bins)/(length(markov_chain)));
        KLDiv = KLDiv + p .* log(p/q);
    end
    
    %Assign KL divergence to y_values
    loop = loop + 1;
    y_values(loop) = KLDiv;
end

hold on
xscale log
grid on
fontsize(scale=2.5);
scatter(x_values, y_values, "filled", 'MarkerEdgeColor', [0 .5 .5], 'MarkerFaceColor',[0 .7 .7], 'LineWidth', 1.5)
title('KL Divergence of Metropolis-Hastings')
xlabel('Number of Samples') 
ylabel('Divergence') 
legend("KL Divergence");
