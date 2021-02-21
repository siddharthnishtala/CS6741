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

# ╔═╡ f6c1895c-6ece-11eb-2101-edf25fe2ab5a
md"### Question 2"

# ╔═╡ f9b51b36-745c-11eb-1088-230ffbdbd6d2
md"Generating a deck of cards"

# ╔═╡ 041210fe-6ecf-11eb-39b5-d16c3be2fec5
begin
	cards = Vector{Array{String,1}}()
	for card in ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
		for suite in ["Diamonds", "Clubs", "Hearts", "Spades"]
			push!(cards, [card, suite])
		end
	end
end

# ╔═╡ 0b53c702-745d-11eb-3ad4-9fcab367dda3
md"Setting the number of jacks"

# ╔═╡ 98b3603e-736b-11eb-1769-a943f6965cf7
n = 0

# ╔═╡ a47ca8ba-6ee3-11eb-3488-cb8840238f99
begin
	using Combinatorics
	
	possible_hands = collect(combinations(cards, 5))
	n_hands_of_interest = 0
	
	for hand in possible_hands
		n_jacks = 0
		for card in hand
			if isequal(card[1], "J")
				n_jacks = n_jacks + 1
			end
		end
		
		if isequal(n_jacks, n)
			global n_hands_of_interest = n_hands_of_interest + 1
		end
	end
end

# ╔═╡ 1b2edbe4-745d-11eb-1b66-d930fee0693d
md"Iterating through all possibilities to compute the probability of picking n jacks without replacement."

# ╔═╡ e6f31fb6-6efd-11eb-3f2a-a5a2125486ba
n_hands_of_interest/length(possible_hands)

# ╔═╡ 3c24b724-745d-11eb-334e-0f3d2a4b4da1
md"Running simulations to compute the probability of picking n jacks with replacement."

# ╔═╡ 8c8c26ca-6efb-11eb-28a9-1d41efbb75f2
begin
	n_hands_of_interest_p = 0
	n_experiments = 1000000
	
	for _ in 1:n_experiments
		idx = rand(1:length(cards), 5)
		n_jacks = 0
		for i in 1:length(idx)
			card = cards[idx[i]]
			if isequal(card[1], "J")
				n_jacks = n_jacks + 1
			end
		end
		
		if isequal(n_jacks, n)
			global n_hands_of_interest_p = n_hands_of_interest_p + 1
		end
	end
end

# ╔═╡ 84e94cec-6efc-11eb-2af6-a330a0095d6e
n_hands_of_interest_p/n_experiments

# ╔═╡ Cell order:
# ╟─ce4bd710-6d17-11eb-25f6-af21f4bcec4c
# ╟─e3f3512e-6d17-11eb-1be0-d97ddeac9e63
# ╟─335d91a2-6d18-11eb-2566-d9c1187d0c85
# ╟─f6c1895c-6ece-11eb-2101-edf25fe2ab5a
# ╟─f9b51b36-745c-11eb-1088-230ffbdbd6d2
# ╠═041210fe-6ecf-11eb-39b5-d16c3be2fec5
# ╟─0b53c702-745d-11eb-3ad4-9fcab367dda3
# ╠═98b3603e-736b-11eb-1769-a943f6965cf7
# ╟─1b2edbe4-745d-11eb-1b66-d930fee0693d
# ╠═a47ca8ba-6ee3-11eb-3488-cb8840238f99
# ╠═e6f31fb6-6efd-11eb-3f2a-a5a2125486ba
# ╟─3c24b724-745d-11eb-334e-0f3d2a4b4da1
# ╠═8c8c26ca-6efb-11eb-28a9-1d41efbb75f2
# ╠═84e94cec-6efc-11eb-2af6-a330a0095d6e
