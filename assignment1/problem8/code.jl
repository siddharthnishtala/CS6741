### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ b44642ba-7465-11eb-0c49-2b8410a6d8c8
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

# ╔═╡ 5619ed90-7433-11eb-0c40-53b91cbe3a5b
md"### Question 8"

# ╔═╡ c76b697e-7465-11eb-0be9-45e98285ccce
md"Setting up the experiment."

# ╔═╡ b5bd43dc-7465-11eb-311a-e1ea2f0dcbc2
md"Running the simulation to compute the probability."

# ╔═╡ d6be5aa8-6f08-11eb-20e4-d5c01d050704
begin
	event_of_interest_A = 0
	event_of_interest_B = 0
	
	for _ in 1:n_experiments_sm
		wallet = 10
		bankrupt = false
		updated = false
		for t in 1:20
			if rand(ber, 1)[1]
				wallet = wallet - 1
			else
				wallet = wallet + 1
			end
			
			if !(updated)
				if isequal(wallet, 0)
					bankrupt = true
					updated = true
				end
			end
		end
			
		if !(bankrupt)
			global event_of_interest_B = event_of_interest_B + 1
			if wallet >= 10
				global event_of_interest_A = event_of_interest_A + 1
			end
		end
	end
end

# ╔═╡ c37580f4-6f09-11eb-2838-a7238b89b36e
event_of_interest_A/event_of_interest_B

# ╔═╡ Cell order:
# ╟─ce4bd710-6d17-11eb-25f6-af21f4bcec4c
# ╟─e3f3512e-6d17-11eb-1be0-d97ddeac9e63
# ╟─335d91a2-6d18-11eb-2566-d9c1187d0c85
# ╟─5619ed90-7433-11eb-0c40-53b91cbe3a5b
# ╟─c76b697e-7465-11eb-0be9-45e98285ccce
# ╠═b44642ba-7465-11eb-0c49-2b8410a6d8c8
# ╟─b5bd43dc-7465-11eb-311a-e1ea2f0dcbc2
# ╠═d6be5aa8-6f08-11eb-20e4-d5c01d050704
# ╠═c37580f4-6f09-11eb-2838-a7238b89b36e
