### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 1f54beb6-7465-11eb-0c34-1f1d8adbb3e2
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
md"### Question 7"

# ╔═╡ 5412146e-7465-11eb-38c0-75efaa0a96ea
md"Setting up the eexperiment."

# ╔═╡ 5d1abd5e-7465-11eb-2d60-45878d6aa6b7
md"Running the simulation to find the probability."

# ╔═╡ 13ae1570-6f07-11eb-10aa-7fccb95e2ffd
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
			
			if isequal(wallet, 0)
				global event_of_interest = event_of_interest + 1
				break
			end
		end
	end
end

# ╔═╡ 7d5e7348-6f07-11eb-3fcc-61feaf07492f
event_of_interest/n_experiments_sm

# ╔═╡ Cell order:
# ╟─ce4bd710-6d17-11eb-25f6-af21f4bcec4c
# ╟─e3f3512e-6d17-11eb-1be0-d97ddeac9e63
# ╟─335d91a2-6d18-11eb-2566-d9c1187d0c85
# ╟─91f3a660-6f03-11eb-0fec-cbec4ead6906
# ╟─5412146e-7465-11eb-38c0-75efaa0a96ea
# ╠═1f54beb6-7465-11eb-0c34-1f1d8adbb3e2
# ╟─5d1abd5e-7465-11eb-2d60-45878d6aa6b7
# ╠═13ae1570-6f07-11eb-10aa-7fccb95e2ffd
# ╠═7d5e7348-6f07-11eb-3fcc-61feaf07492f
