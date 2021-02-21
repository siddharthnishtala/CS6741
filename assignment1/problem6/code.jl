### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ cffda884-6f03-11eb-2f5f-95f8ed328753
begin
	using Distributions
	
	p = 0.1
	ber = Bernoulli(p)
	n_experiments_sm = 10000000
	samples_sm = rand(ber, n_experiments_sm, 20)
end

# ╔═╡ ce4bd710-6d17-11eb-25f6-af21f4bcec4c
md"# Assignment 1"

# ╔═╡ e3f3512e-6d17-11eb-1be0-d97ddeac9e63
md"*Name:* Siddharth Nishtala"

# ╔═╡ 335d91a2-6d18-11eb-2566-d9c1187d0c85
md"*Roll No.:* CS20S022"

# ╔═╡ 91f3a660-6f03-11eb-0fec-cbec4ead6906
md"### Question 6"

# ╔═╡ ca39c642-7464-11eb-3e39-179289436a4c
md"Setting up the experiment."

# ╔═╡ d82bc05c-7464-11eb-38e2-bd30e325988f
md"Running the simulation to find the probability."

# ╔═╡ 98aca934-6f03-11eb-2257-a150c9071554
begin
	event_of_interest = 0
	
	for i in 1:n_experiments_sm
		wallet = 10
		for t in 1:20
			if samples_sm[i, t]
				wallet = wallet - 1
			else
				wallet = wallet + 1
			end
		end
		
		if wallet >= 10
			global event_of_interest = event_of_interest + 1
		end
	end
end

# ╔═╡ f1c5414a-6f04-11eb-129e-41d3f561cb46
event_of_interest/n_experiments_sm

# ╔═╡ Cell order:
# ╟─ce4bd710-6d17-11eb-25f6-af21f4bcec4c
# ╟─e3f3512e-6d17-11eb-1be0-d97ddeac9e63
# ╟─335d91a2-6d18-11eb-2566-d9c1187d0c85
# ╟─91f3a660-6f03-11eb-0fec-cbec4ead6906
# ╟─ca39c642-7464-11eb-3e39-179289436a4c
# ╠═cffda884-6f03-11eb-2f5f-95f8ed328753
# ╟─d82bc05c-7464-11eb-38e2-bd30e325988f
# ╠═98aca934-6f03-11eb-2257-a150c9071554
# ╠═f1c5414a-6f04-11eb-129e-41d3f561cb46
