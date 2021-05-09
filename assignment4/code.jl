### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ ad4f6f9e-afe9-11eb-35ee-25160e0e286a
begin
	using Plots
	using Random 
	using StatsPlots
	using LaTeXStrings
	using Distributions
	
	Random.seed!(0)
end

# ╔═╡ e79cd44e-afe8-11eb-26c1-13543ccab489
md"# Assignment 4"

# ╔═╡ 266f16be-afe9-11eb-1b0c-9913c5511cd9
md"*Name:* Siddharth Nishtala"

# ╔═╡ 27f1485c-afe9-11eb-0def-aff674ea7c29
md"*Roll No.:* CS20S022"

# ╔═╡ 2f5ac0a2-afe9-11eb-1ef1-59fc0ed24930
md"### Importing Required Packages"

# ╔═╡ a166d8ac-afe9-11eb-1e04-c980b4086916
md"### Question 1"

# ╔═╡ d254a3c2-aff0-11eb-07b9-93a736d3027c
begin
	n = 10000000
	p1 = 0.50
end

# ╔═╡ c560b1ac-afed-11eb-03c0-e78cac17a47b
md"Monte Carlo Simulations"

# ╔═╡ c3d3535c-afe9-11eb-02fc-13060fb3add1
function monte_carlo_simulation(n, p)	
	bern = Bernoulli(p)
	samples = rand(bern, (n, 50))
	sums = sum(samples, dims=2)
	n_go_aheads = length(sums[sums .>= 30])
	prob_mc = n_go_aheads/n
	
	return prob_mc
end

# ╔═╡ a57e47c2-aff0-11eb-05f2-8d3b4b139b0a
monte_carlo_simulation(n, p1)

# ╔═╡ b04e8cd4-afe9-11eb-008b-9f4d8f500d2a
md"### Question 2"

# ╔═╡ c4891200-afe9-11eb-16e8-09e5885a9321
md"Verification using Monte Carlo Simulations"

# ╔═╡ 866a1328-b009-11eb-10a4-b1d167a4aa6e
begin
	p2 = 0.59
end

# ╔═╡ 8df6d52c-b009-11eb-176f-817f7ccde062
monte_carlo_simulation(n, p2)

# ╔═╡ b1584dea-afe9-11eb-0f7e-f77b24e9457e
md"### Question 3"

# ╔═╡ c525f4ee-afe9-11eb-090c-797e3c12258a
begin
	l_limit, h_limit = 20, 45
	probs = [1 - cdf(Normal(100*i, 30*(i^0.5)), 3000) for i=l_limit:h_limit]
	
	num_space_suits = findfirst(probs .>= 0.95) + (l_limit-1)
	
	plot(
		l_limit:h_limit, 
		probs, 
		line=(2, :green), 
		label=false
	)
	
	plot!(
		[l_limit, h_limit], 
		[0.95, 0.95], 
		line=(1, :dash, :red), 
		label=false
	)
	
	plot!(
		[num_space_suits, num_space_suits], 
		[0, 0.95], 
		line=(1, :dot, :black), 
		label=false
	)
	
	plot!(xlabel="Number of ")
	plot!(ylabel=L"$\mathrm{Pr}(Z \geq 3000)$")
	
	xticks!([0, 10, 20, 30, num_space_suits, 40, 50])
end

# ╔═╡ b22f20e0-afe9-11eb-274f-ed1f896dc033
md"### Question 4"

# ╔═╡ c5bec354-afe9-11eb-39e0-b9790d114cdb
function get_smallest_samp_size(dist, u_limit)
	
	diff_in_skewness = []
	diff_in_kurtosis = []
	
	for n_samples = 1:u_limit
		
		samples = [
			sum(
				(rand(dist, n_samples) .- mean(dist)) / (std(dist) * (n^0.5))
			) 
			for _ = 1:100000
		]
		
		push!(diff_in_skewness, abs(skewness(samples) - skewness(Normal(0, 1))))
		push!(diff_in_kurtosis, abs(kurtosis(samples) - kurtosis(Normal(0, 1))))
		
	end
	
	smallest_samp_size_skewness = findfirst(diff_in_skewness .< 0.1)
	smallest_samp_size_kurtosis = findfirst(diff_in_kurtosis .< 0.1)

	smallest_samp_size = max(
		smallest_samp_size_skewness, smallest_samp_size_kurtosis
	)
	
	comparision_fig = plot(
		1:u_limit, 
		diff_in_skewness, 
		label="Skewness", 
		line=(1, :green),
		title="Error in Skewness and Kurtosis",
		fmt=:png
	)
	
	plot!(
		1:u_limit, 
		diff_in_kurtosis, 
		label="Kurtosis", 
		line=(1, :blue)
	)
	
	plot!(
		[0, u_limit], 
		[0.1, 0.1], 
		label=false, 
		line=(1, :dash, :red)
	)
	
	plot!(
		[smallest_samp_size, smallest_samp_size], 
		[0, 0.1], 
		line=(1, :dash, :black), 
		label=false
	)

	xticks!([0, smallest_samp_size, u_limit])
	
	return comparision_fig, smallest_samp_size
end

# ╔═╡ 305a79d2-b0ec-11eb-15b6-5395245fc0e6
fig_unif, samp_size_unif = get_smallest_samp_size(Uniform(0, 1), 100);

# ╔═╡ e76702c2-b0ee-11eb-2997-dd779009e5ef
function plot_distributions(dist, n, dist_name)
	
	samples = [
		sum(
			(rand(dist, samp_size_unif) .- mean(dist)) / (std(dist) * (n^0.5))
		) 
		for _ = 1:100000
	]
	
	distributions_fig = histogram(
		samples, 
		label=dist_name,
		norm=true,
		fmt=:png
	)
	
	plot!(
		Normal(0, 1), 
		label="Standard Normal Distribution", 
		line=(2, :green)
	)
	
	return distributions_fig
end

# ╔═╡ 972a621a-b0ec-11eb-0e4d-03b094ca6489
fig_unif

# ╔═╡ 646ebbcc-b0ed-11eb-1bbf-2b850cd9ff0f
plot_distributions(Uniform(0, 1), samp_size_unif, "Uniform Distribution")

# ╔═╡ 9a4c786e-b0ee-11eb-3f9c-b535ac556103
fig_bin1, samp_size_bin1 = get_smallest_samp_size(Binomial(100, 0.01), 100);

# ╔═╡ 6396fbae-b0f1-11eb-35e5-6bbee5de08d5
fig_bin1

# ╔═╡ 6356bc24-b0f1-11eb-123a-db1dfb0fc848
plot_distributions(Binomial(100, 0.01), samp_size_bin1, "Binomial Distribution")

# ╔═╡ 5f34708a-b0f1-11eb-0dfa-ad154afbc4ce
fig_bin2, samp_size_bin2 = get_smallest_samp_size(Binomial(100, 0.5), 100);

# ╔═╡ 75cc9318-b0f1-11eb-1220-0539897396fc
fig_bin2

# ╔═╡ 79ed1a44-b0f1-11eb-3434-6fc5e1d1746c
plot_distributions(Binomial(100, 0.5), samp_size_bin2, "Binomial Distribution")

# ╔═╡ 8aa2575a-b0f1-11eb-2177-618990eeae3d
fig_chi, samp_size_chi = get_smallest_samp_size(Chi(3), 100);

# ╔═╡ 9ebcb58c-b0f1-11eb-2b9a-39c7277cbebb
fig_chi

# ╔═╡ a0be611c-b0f1-11eb-10f9-35af521fdecf
plot_distributions(Chi(3), samp_size_chi, "Chi Square Distribution")

# ╔═╡ b52127ee-afe9-11eb-2e25-4f41e4e2963c
md"### Question 5"

# ╔═╡ 54acadc4-b0e1-11eb-2243-f3162fae5f9c
norm = Normal(2, 0.2053)

# ╔═╡ 58c07664-b0e1-11eb-0dd0-a5cd5b670765
s = [var([sum(rand(norm, 100)) for i in 1:100]) for j in 1:100000]

# ╔═╡ 59f2f14c-b0e1-11eb-0307-99dd44bf0268
var_greater = length(s[s .> 5])

# ╔═╡ 5e20ecce-b0e1-11eb-0c13-91342bed5472
prob_fail = var_greater/100000

# ╔═╡ Cell order:
# ╟─e79cd44e-afe8-11eb-26c1-13543ccab489
# ╟─266f16be-afe9-11eb-1b0c-9913c5511cd9
# ╟─27f1485c-afe9-11eb-0def-aff674ea7c29
# ╟─2f5ac0a2-afe9-11eb-1ef1-59fc0ed24930
# ╠═ad4f6f9e-afe9-11eb-35ee-25160e0e286a
# ╟─a166d8ac-afe9-11eb-1e04-c980b4086916
# ╠═d254a3c2-aff0-11eb-07b9-93a736d3027c
# ╟─c560b1ac-afed-11eb-03c0-e78cac17a47b
# ╠═c3d3535c-afe9-11eb-02fc-13060fb3add1
# ╠═a57e47c2-aff0-11eb-05f2-8d3b4b139b0a
# ╟─b04e8cd4-afe9-11eb-008b-9f4d8f500d2a
# ╟─c4891200-afe9-11eb-16e8-09e5885a9321
# ╠═866a1328-b009-11eb-10a4-b1d167a4aa6e
# ╠═8df6d52c-b009-11eb-176f-817f7ccde062
# ╟─b1584dea-afe9-11eb-0f7e-f77b24e9457e
# ╠═c525f4ee-afe9-11eb-090c-797e3c12258a
# ╟─b22f20e0-afe9-11eb-274f-ed1f896dc033
# ╠═c5bec354-afe9-11eb-39e0-b9790d114cdb
# ╠═e76702c2-b0ee-11eb-2997-dd779009e5ef
# ╠═305a79d2-b0ec-11eb-15b6-5395245fc0e6
# ╠═972a621a-b0ec-11eb-0e4d-03b094ca6489
# ╠═646ebbcc-b0ed-11eb-1bbf-2b850cd9ff0f
# ╠═9a4c786e-b0ee-11eb-3f9c-b535ac556103
# ╠═6396fbae-b0f1-11eb-35e5-6bbee5de08d5
# ╠═6356bc24-b0f1-11eb-123a-db1dfb0fc848
# ╠═5f34708a-b0f1-11eb-0dfa-ad154afbc4ce
# ╠═75cc9318-b0f1-11eb-1220-0539897396fc
# ╠═79ed1a44-b0f1-11eb-3434-6fc5e1d1746c
# ╠═8aa2575a-b0f1-11eb-2177-618990eeae3d
# ╠═9ebcb58c-b0f1-11eb-2b9a-39c7277cbebb
# ╠═a0be611c-b0f1-11eb-10f9-35af521fdecf
# ╟─b52127ee-afe9-11eb-2e25-4f41e4e2963c
# ╠═54acadc4-b0e1-11eb-2243-f3162fae5f9c
# ╠═58c07664-b0e1-11eb-0dd0-a5cd5b670765
# ╠═59f2f14c-b0e1-11eb-0307-99dd44bf0268
# ╠═5e20ecce-b0e1-11eb-0c13-91342bed5472
