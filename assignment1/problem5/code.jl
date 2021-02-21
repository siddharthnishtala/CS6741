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

# ╔═╡ 432736ae-6eff-11eb-03fe-9f1feefd71af
md"### Question 5"

# ╔═╡ 3a18712e-7463-11eb-1b5c-8530cdc73b62
md"Computing the theoretical probability an attempt being saved if 3 characters match."

# ╔═╡ d38a2a12-7378-11eb-1cc5-5b4101d82036
begin
	save_prob = 0
	for k in 3:8
		save_prob = save_prob + binomial(8, k) * (0.01282051282)^k * (1 - 0.0128205128)^(8-k)
	end
end

# ╔═╡ 51f7c69c-737a-11eb-35d3-8363f8f1a8cf
save_prob

# ╔═╡ 4b8c4a50-7463-11eb-04a9-adcf46802c27
md"Computing through simulations, the probability of an attempt being saved if 3 characters match."

# ╔═╡ 0836f36a-737b-11eb-3cfc-e3001e838469
begin
	characters = [
		'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
		'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 
		'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 
		'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '1', '2', '3', '4', '5', '6', '7', '8', 
		'9', '0', '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', 
		'=', '-', '`'
	]
	password = ['*', '(', ')', '_', '+', '=', '-', '`']
	n_saves = 0
	for guess in 1:10000000
		guess = rand(characters, 8)
		character_matches = 0
		for i in 1:8
			if isequal(guess[i], password[i])
				character_matches = character_matches + 1
			end 
		end
		
		if character_matches >= 3
				n_saves = n_saves + 1
		end 
	end
end

# ╔═╡ d4c81c14-737c-11eb-3a8c-d94748abdb40
n_saves/10000000

# ╔═╡ Cell order:
# ╟─ce4bd710-6d17-11eb-25f6-af21f4bcec4c
# ╟─e3f3512e-6d17-11eb-1be0-d97ddeac9e63
# ╟─335d91a2-6d18-11eb-2566-d9c1187d0c85
# ╟─432736ae-6eff-11eb-03fe-9f1feefd71af
# ╟─3a18712e-7463-11eb-1b5c-8530cdc73b62
# ╠═d38a2a12-7378-11eb-1cc5-5b4101d82036
# ╠═51f7c69c-737a-11eb-35d3-8363f8f1a8cf
# ╟─4b8c4a50-7463-11eb-04a9-adcf46802c27
# ╠═0836f36a-737b-11eb-3cfc-e3001e838469
# ╠═d4c81c14-737c-11eb-3a8c-d94748abdb40
