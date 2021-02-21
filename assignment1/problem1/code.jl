### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 54dd294e-6d1a-11eb-2ade-23da22520aa1
begin
	using Statistics
	using Random
	
	Random.seed!(0)
	
	averaged_over = 100
	n_samples = 10000
	
	sum_matrix = zeros(Int64, averaged_over, n_samples)
	samples = rand(-5:5, averaged_over, n_samples)
	
	for i in 1:averaged_over
		sum_samples = 0
		for n in 1:n_samples
			sum_samples = sum_samples + samples[i, n]

			sum_matrix[i, n] = sum_samples
		end
	end
end

# ╔═╡ ce4bd710-6d17-11eb-25f6-af21f4bcec4c
md"# Assignment 1"

# ╔═╡ e3f3512e-6d17-11eb-1be0-d97ddeac9e63
md"*Name:* Siddharth Nishtala"

# ╔═╡ 335d91a2-6d18-11eb-2566-d9c1187d0c85
md"*Roll No.:* CS20S022"

# ╔═╡ aae3a9f6-6d17-11eb-3546-850cbec2456d
md"### Question 1"

# ╔═╡ 35bc6a4c-7437-11eb-3245-e9d54d0742cb
mean_sum = mean(sum_matrix, dims=1)

# ╔═╡ aa7a0eac-6d1b-11eb-3879-1525d027bf58
begin
	using Plots
	
	plot(sum_matrix[1, :], xlabel="No. of Samples", ylabel="Sum", label="Random Seed - 1", color = :yellow)
	plot!(sum_matrix[2, :], label="Random Seed - 2", color = :yellow)
	plot!(sum_matrix[3, :], label="Random Seed - 3", color = :yellow)
	plot!(sum_matrix[4, :], label="Random Seed - 4", color = :yellow)
	plot!(sum_matrix[5, :], label="Random Seed - 5", color = :yellow)
	
	plot!(mean_sum[:], label="Mean - 100 Runs", fmt = :png)

end

# ╔═╡ Cell order:
# ╟─ce4bd710-6d17-11eb-25f6-af21f4bcec4c
# ╟─e3f3512e-6d17-11eb-1be0-d97ddeac9e63
# ╟─335d91a2-6d18-11eb-2566-d9c1187d0c85
# ╟─aae3a9f6-6d17-11eb-3546-850cbec2456d
# ╠═54dd294e-6d1a-11eb-2ade-23da22520aa1
# ╠═35bc6a4c-7437-11eb-3245-e9d54d0742cb
# ╠═aa7a0eac-6d1b-11eb-3879-1525d027bf58
