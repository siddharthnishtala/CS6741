### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ ce4bd710-6d17-11eb-25f6-af21f4bcec4c
md"# Assignment 1"

# ╔═╡ e3f3512e-6d17-11eb-1be0-d97ddeac9e63
md"*Name:* Siddharth Nishtala"

# ╔═╡ 335d91a2-6d18-11eb-2566-d9c1187d0c85
md"*Roll No.:* CS20S022"

# ╔═╡ 1209ff42-736f-11eb-3f3c-25a50cbc4298
md"### Question 3"

# ╔═╡ b867383e-745d-11eb-3a37-9bb2c5f51329
md"Setting the number of jacks."

# ╔═╡ 48d6afce-7370-11eb-085c-31eb6953aea2
no_of_jacks = 2

# ╔═╡ 851745e8-7370-11eb-3618-211a87612d09
begin
	using Distributions
	
	hyp_g_d = Hypergeometric(4, 48, 5)
	hyp_g_samples = rand(hyp_g_d, 1000000)
	
	hyp_g_counter = 0
	for i in 1:1000000
		if isequal(hyp_g_samples[i], no_of_jacks)
				global hyp_g_counter = hyp_g_counter + 1
		end 
	end
end

# ╔═╡ c376571e-745d-11eb-33bd-b1a3f0388cd5
md"Computing the theoretical probability of without replacement case by using the formula for hypergeometric distribution."

# ╔═╡ f9f7138c-7372-11eb-08ff-1ba8504affa5
(binomial(4, no_of_jacks) * binomial(48, 5-no_of_jacks)) / binomial(52, 5)

# ╔═╡ e10e671c-745d-11eb-27ec-4513d05da24b
md"Computing the theoretical probability of without replacement case by running simulations using hypergeometric distribution."

# ╔═╡ bced183a-7370-11eb-2122-8bf0616f4573
hyp_g_counter/1000000

# ╔═╡ c8d490ba-7460-11eb-04d9-63771fcc2785
md"Computing the theoretical probability of with replacement case by using the formula for binomial distribution."

# ╔═╡ 5d1bd9c0-7373-11eb-3912-212c85501b76
binomial(5, no_of_jacks) * (4/52)^no_of_jacks * (48/52)^(5-no_of_jacks)

# ╔═╡ dc168d02-7460-11eb-0c76-e7eef1b17338
md"Computing the theoretical probability of with replacement case by running simulations using binomial distribution."

# ╔═╡ ff3ca1c2-7372-11eb-2a7d-2ba32b8ae21e
begin
	bino_d = Distributions.Binomial(5, 4/52)
	bino_samples = rand(bino_d, 1000000)
	
	bino_counter = 0
	for i in 1:1000000
		if isequal(bino_samples[i], no_of_jacks)
				global bino_counter = bino_counter + 1
		end 
	end
end

# ╔═╡ 8f249466-7373-11eb-27e4-fd289c190748
bino_counter/1000000

# ╔═╡ Cell order:
# ╟─ce4bd710-6d17-11eb-25f6-af21f4bcec4c
# ╟─e3f3512e-6d17-11eb-1be0-d97ddeac9e63
# ╟─335d91a2-6d18-11eb-2566-d9c1187d0c85
# ╟─1209ff42-736f-11eb-3f3c-25a50cbc4298
# ╟─b867383e-745d-11eb-3a37-9bb2c5f51329
# ╠═48d6afce-7370-11eb-085c-31eb6953aea2
# ╟─c376571e-745d-11eb-33bd-b1a3f0388cd5
# ╠═f9f7138c-7372-11eb-08ff-1ba8504affa5
# ╟─e10e671c-745d-11eb-27ec-4513d05da24b
# ╠═851745e8-7370-11eb-3618-211a87612d09
# ╠═bced183a-7370-11eb-2122-8bf0616f4573
# ╟─c8d490ba-7460-11eb-04d9-63771fcc2785
# ╠═5d1bd9c0-7373-11eb-3912-212c85501b76
# ╟─dc168d02-7460-11eb-0c76-e7eef1b17338
# ╠═ff3ca1c2-7372-11eb-2a7d-2ba32b8ae21e
# ╠═8f249466-7373-11eb-27e4-fd289c190748
