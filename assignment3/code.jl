### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 95ad30c6-8cc9-11eb-24ac-5f0e4c7d59d4
begin
	using Distributions
	using QuadGK
	using Plots
	using StatsPlots
	using HTTP
	using CSV
	using DataFrames
	using Dates
	using StatsBase
	using Measures
	using Random 
	
	Random.seed!(0)
end

# ╔═╡ 092277f6-8cc9-11eb-1393-91f786797cf3
md"# Assignment 3"

# ╔═╡ 7e13bb24-8cc9-11eb-171a-8b0310986408
md"*Name:* Siddharth Nishtala"

# ╔═╡ 87fd380e-8cc9-11eb-3e40-2519c2edb1e9
md"*Roll No.:* CS20S022"

# ╔═╡ 8e3c0b8c-8cc9-11eb-0a9a-e33b9bba1297
md"### Importing Required Packages"

# ╔═╡ 9e08ee9a-8cc9-11eb-3b92-db7a51bab2b6
md"### Question 1"

# ╔═╡ b03fd2ca-8cc9-11eb-2059-d7f215588102
kl_divergence(p, q) = quadgk(x -> pdf(p, x) * log(pdf(p, x) / pdf(q, x)), -25, 25)

# ╔═╡ e3121024-8cca-11eb-2cb4-e1542dfbcadc
begin
	norm_dist = Normal(0, 1)
	kl_divergences = []
	for i in 1:5
		t_dist = TDist(i)
		push!(kl_divergences, kl_divergence(norm_dist, t_dist)[1])
	end
end

# ╔═╡ c5b64a24-8ccd-11eb-2932-0181420aca01
kl_divergences

# ╔═╡ 7e5b102c-8ccf-11eb-2f8a-93cf2478410c
md"### Question 2"

# ╔═╡ f338b2d2-8ccf-11eb-34ce-3b53d81a2141
function convolution(p, q, i)
	
	x_val = -10 + (i-1) * 0.01
	
	conv_limit_start = x_val + 10
	conv_limit_end = x_val - 10
	
	p_start_idx = round(Int32, ((conv_limit_start + 10) / 0.01) + 1)
	p_end_idx = round(Int32, ((conv_limit_end + 10) / 0.01) + 1)
	
	t_p_start_idx = min(2001, p_start_idx)
	t_p_end_idx = max(1, p_end_idx)
	
	q_start_idx = 1 + (p_start_idx - t_p_start_idx)
	q_end_idx = 2001 + (p_end_idx - t_p_end_idx)
	
	conv = sum(
		(p[j] * q[k]) for (j, k) in zip(
				t_p_start_idx:-1:t_p_end_idx, q_start_idx:q_end_idx
		)
	)
	
	return conv
end

# ╔═╡ b3220e00-8d42-11eb-0197-8bceee5e2196
function add_n_uniform_distributions(n)
	x_axis = -10:0.01:10
	uniform_dist = [pdf(Uniform(0, 1), i) for i in x_axis]
	new_dist = [pdf(Uniform(0, 1), i) for i in x_axis]
	
	for i in 2:n
		new_dist = [
			convolution(
				new_dist, 
				uniform_dist, 
				i
			) for i in 1:length(uniform_dist)
		]
		new_dist = new_dist ./ (sum(new_dist) * 0.01)
	end
	
	return new_dist
end

# ╔═╡ ab6a1a92-9308-11eb-2404-c7445751d23b
function n_uniform_distributions_pdf(x, n, dist=nothing)
	if dist == nothing
		dist = add_n_uniform_distributions(n)
	end
	
	idx = round(Int32, 1001 + (round(x, digits=2)/0.01))
	return dist[idx]
end

# ╔═╡ 84cdee16-8ccf-11eb-000c-67236f5a7561
begin
	plot(-10:0.01:10, add_n_uniform_distributions(2), label="2")
	plot!(-10:0.01:10, add_n_uniform_distributions(3), label="3")
	plot!(-10:0.01:10, add_n_uniform_distributions(4), label="4")
	plot!(-10:0.01:10, add_n_uniform_distributions(5), label="5")
	plot!(-10:0.01:10, add_n_uniform_distributions(6), label="6")
	plot!(-10:0.01:10, add_n_uniform_distributions(7), label="7")
	plot!(-10:0.01:10, add_n_uniform_distributions(8), label="8")
	plot!(-10:0.01:10, add_n_uniform_distributions(9), label="9")
end

# ╔═╡ ee644d1c-931d-11eb-0527-e983ec4cfe4d
function kl_divergence_discretized(p, q)
	sum_ = 0
	for x in -10:0.01:10
		if (pdf(q, x) > 0) & (n_uniform_distributions_pdf(x, "", p) > 0)
			sum_ += n_uniform_distributions_pdf(
					x, 
					"", 
					p
			) * log(
					n_uniform_distributions_pdf(x, "", p) / pdf(q, x)
			)
		end
	end
	
	return sum_ * 0.01
end

# ╔═╡ abcac19c-92f6-11eb-3059-7b06f4f83274
function approximate_normal_and_get_kl_divergence(n)
	conv_dis = add_n_uniform_distributions(n)
	mean_ = sum(n_uniform_distributions_pdf(x, n, conv_dis) * x for x=-10:0.01:10)
	mean_ = mean_ * 0.01
	
	std_ = sqrt(
		sum(
			n_uniform_distributions_pdf(
				x, 
				n, 
				conv_dis
			) * (x-(n/2))^2 for x=-10:0.01:10
		) * 0.01
	)
	
	return kl_divergence_discretized(conv_dis, Normal(mean_, std_))
end

# ╔═╡ 3f04a9dc-932b-11eb-05d8-ddfd8c24f51c
begin
	n_s = 2:9
	kl_s = [approximate_normal_and_get_kl_divergence(i) for i in n_s]
	scatter(n_s, kl_s, x_ticks=n_s, xlabel="n", ylabel="KL Divergence", label=false, fmt=:png, dpi=200)
end

# ╔═╡ 443cab4e-9206-11eb-02c7-a94ac4731fa9
md"### Question 3"

# ╔═╡ 6ede0ff0-9206-11eb-1707-a951873bddc0
pearson_skew(d_) = (mean(d_) - mode(d_))/std(d_)

# ╔═╡ 50c187e4-9211-11eb-2660-bd522d493517
conv(dist1, dist2, x) = sum(pdf(dist1, x-k) * pdf(dist2, k) for k=-10:0.01:10)

# ╔═╡ dfbadb4e-9207-11eb-1eb0-3d009c14c5e4
begin
	skew_samples = rand(Poisson(0.8), 1000)
end

# ╔═╡ ee364226-920c-11eb-1056-498a6f8870ad
function dist_plot1(samples, nbins)
	histogram(
		samples, 
		nbins=nbins,
		normalize=true,
		label=false, 
		line=3
	)
	
	d_mean = mean(samples)
	d_mode = mode(samples)
	d_median = median(samples)
	
	plot!(
		[d_mean, d_mean], 
		[0, 1], 
		label="Mean: " * repr(d_mean), 
		line=(4, :dash, :green)
	)
	
	plot!(
		[d_mode, d_mode], 
		[0, 1], 
		label="Mode: " * repr(d_mode), 
		line=(4, :red)
	)
	
	plot!(
		[d_median, d_median], 
		[0, 1], 
		label="Median: " * repr(d_median), 
		line=(4, :dot, :orange),
		fmt=:png,
		dpi=200
	)
end

# ╔═╡ 4aba8d00-9207-11eb-0224-1fdcd58d1b59
dist_plot1(skew_samples, length(unique(skew_samples)))

# ╔═╡ 4d877d64-9206-11eb-051b-b123e2b201ca
md"### Question 4"

# ╔═╡ e54a5410-93ed-11eb-07d3-09bbbbea8cd5
function get_mode(samples, nbins)
	hist = fit(Histogram, samples[:, 1], nbins=nbins)
	return hist.edges[1][[argmax(hist.weights)]][1]
end

# ╔═╡ 5f3cd56a-9218-11eb-029d-c160db4e6459
function dist_plot2(samples, nbins)
	histogram(
		samples, 
		nbins=nbins,
		label=false, 
		line=3
	)
	
	d_mean = mean(samples)
	d_median = median(samples)
	
	hist = fit(Histogram, samples[:, 1], nbins=nbins)
	d_mode =  hist.edges[1][[argmax(hist.weights)]][1]
	
	plot!(
		[d_mean, d_mean], 
		[0, maximum(hist.weights)], 
		label="Mean: " * repr(d_mean), 
		line=(2, :dash, :green)
	)
	
	plot!(
		[d_mode, d_mode], 
		[0, maximum(hist.weights)], 
		label="Mode: " * repr(d_mode), 
		line=(2, :red)
	)
	
	plot!(
		[d_median, d_median], 
		[0, maximum(hist.weights)], 
		label="Median: " * repr(d_median), 
		line=(2, :dot, :orange),
		legend=:topleft,
		fmt=:png,
		dpi=200
	)
end

# ╔═╡ 8b9930d8-9216-11eb-0763-79ad31839f43
begin	
	samples = rand(Uniform(0, 1), (10000, 30))
	max_elements = maximum(samples, dims=2)
	min_elements = minimum(samples, dims=2)
	ranges = max_elements .- min_elements
	dist_plot2(ranges, 30)
end

# ╔═╡ 58e006fe-9206-11eb-0b44-c52864691d2c
md"### Question 6"

# ╔═╡ ea9f4d8a-9219-11eb-0147-5df0602c91dd
begin
	r = HTTP.request("GET", "https://api.covid19india.org/csv/latest/states.csv")
	covid_data = CSV.read(
		IOBuffer(String(r.body)), 
		DataFrame, 
		delim=",", 
		copycols=true
	)
	
	states = filter!(
		e -> e ∉ [
			"State Unassigned", "India", "Andaman and Nicobar Islands",
			"Dadra and Nagar Haveli and Daman and Diu", "Lakshadweep",
			"Chandigarh", "Puducherry", "Ladakh", "Jammu and Kashmir", "Delhi"
		], 
		unique(covid_data.State)
	) 
	covid_data = covid_data[in(states).(covid_data.State), :]
end

# ╔═╡ e818d72c-9226-11eb-0930-7fbb692afcf9
begin
	weekly_data = DataFrame()
	for day in minimum(covid_data.Date):Dates.Day(7):maximum(covid_data.Date)
		week_data = covid_data[covid_data.Date .== day + Dates.Day(6), :]
		week_data[:, :WeekOf] .= day
		
		append!(weekly_data, week_data[:, [:WeekOf, :State, :Confirmed]])
	end
	
	weekly_data = unstack(
		weekly_data, 
		:State,
		:Confirmed
	)
	
	sort!(weekly_data, :WeekOf)
	
	for n in names(weekly_data)
		if n == "WeekOf"
			continue
		end
		for i in size(weekly_data)[1]:-1:2
			replace!(weekly_data[!, n], missing => 0)
			weekly_data[i, n] -= weekly_data[i-1, n]
		end
		
		weekly_data[!, n] = map(identity, weekly_data[!, n])
	end
	
	order = [
		"WeekOf",
		"Tamil Nadu", "Kerala", "Karnataka", "Goa", "Maharashtra", "Telangana",
		"Andhra Pradesh", "Odisha", "Chhattisgarh", "Madhya Pradesh", "Gujarat",
		"Rajasthan", "Haryana", "Punjab", "Himachal Pradesh", "Uttarakhand", 
		"Uttar Pradesh", "Bihar", "Jharkhand", "West Bengal", "Sikkim", "Meghalaya", 
		"Assam", "Arunachal Pradesh", "Nagaland", "Manipur", "Mizoram", "Tripura"
	]
	weekly_data = weekly_data[
		!, 
		[findall(x -> x == item, names(weekly_data))[1] for item in order]
	]
end

# ╔═╡ 36481bb0-9227-11eb-289b-e508f961a989
weekly_data

# ╔═╡ 27ed403e-92c4-11eb-1945-518493c09da0
function get_matrix(data, metric)
	if metric == "Covariance"
		func = cov
	elseif metric == "Pearson's Correlation"
		func = cor
	else
		func = corspearman
	end
	
	metric_matrix = zeros((size(data)[2]-1, size(data)[2]-1))
	for i in 2:size(data)[2]
		for j in 2:size(data)[2]
			metric_matrix[i-1, j-1] = func(data[!, i], data[!, j])
		end
	end
	
	return metric_matrix
end

# ╔═╡ a8af4dea-92c7-11eb-2e55-51e3d16cacd2
function plot_heatmap(data, metric)
	metric_matrix = get_matrix(data, metric)
	heatmap(
		names(weekly_data)[2:length(names(weekly_data))], 
		names(weekly_data)[2:length(names(weekly_data))], 
		metric_matrix,
		yflip=true,
		xrotation=90,
		tickfontsize=5,
		xticks = (0.3:1:27.3, names(weekly_data)[2:length(names(weekly_data))]),
		yticks = (0.3:1:27.3, names(weekly_data)[2:length(names(weekly_data))]),
		title=metric,
		fmt=:png,
		bottom_margin=12mm, 
		right_margin=10mm, 
		dpi=200
	)
end

# ╔═╡ 70d2b922-92c5-11eb-13ac-d5aa8f18209b
plot_heatmap(weekly_data, "Covariance")

# ╔═╡ 570e942e-92c6-11eb-2e7c-d992e9c4f177
plot_heatmap(weekly_data, "Pearson's Correlation")

# ╔═╡ 5df63f44-92c6-11eb-269b-d1b808dc01d7
plot_heatmap(weekly_data, "Spearman's Rank Correlation")

# ╔═╡ 5a882b3a-9206-11eb-0d96-21cf7b07f40e
md"### Question 7"

# ╔═╡ 0ab7945c-92d2-11eb-2de8-1b1bd070d13c
function OneSidedTailStardardNormal(x, name)
	return minimum(filter((k) -> (cdf(Normal(0, 1), k) >= (100-x)/100), -5:0.01:5))
end

# ╔═╡ c6d7de76-92d7-11eb-1eab-15d112628abb
function OneSidedTailStudentsT(x, name)
	return minimum(filter((k) -> (cdf(TDist(10), k) >= (100-x)/100), -5:0.01:5))
end

# ╔═╡ 7d7d4746-92d4-11eb-3e57-c373fc4170b7
function VisualizePercentile(x, name)
	if name == "Standard Normal"
		dist = Normal(0, 1)
		one_sided_func = OneSidedTailStardardNormal
	else
		dist = TDist(10)
		one_sided_func = OneSidedTailStudentsT
	end
	plot(x->x, x->pdf(dist, x), -5, 5, label=name)
	plot!(
		x->x, 
		x->pdf(dist, x), 
		-5, 
		one_sided_func(x, name), 
		fill=(0, :orange), 
		label="",
		fmt=:png,
		dpi=200
	)
end

# ╔═╡ bccd5d52-92d5-11eb-1600-b5c50bc7a360
VisualizePercentile(95, "Standard Normal")

# ╔═╡ ce445d52-92d6-11eb-1bd6-379de812a724
VisualizePercentile(95, "Student's T")

# ╔═╡ Cell order:
# ╟─092277f6-8cc9-11eb-1393-91f786797cf3
# ╟─7e13bb24-8cc9-11eb-171a-8b0310986408
# ╟─87fd380e-8cc9-11eb-3e40-2519c2edb1e9
# ╟─8e3c0b8c-8cc9-11eb-0a9a-e33b9bba1297
# ╠═95ad30c6-8cc9-11eb-24ac-5f0e4c7d59d4
# ╟─9e08ee9a-8cc9-11eb-3b92-db7a51bab2b6
# ╠═b03fd2ca-8cc9-11eb-2059-d7f215588102
# ╠═e3121024-8cca-11eb-2cb4-e1542dfbcadc
# ╠═c5b64a24-8ccd-11eb-2932-0181420aca01
# ╟─7e5b102c-8ccf-11eb-2f8a-93cf2478410c
# ╠═f338b2d2-8ccf-11eb-34ce-3b53d81a2141
# ╠═b3220e00-8d42-11eb-0197-8bceee5e2196
# ╠═ab6a1a92-9308-11eb-2404-c7445751d23b
# ╠═84cdee16-8ccf-11eb-000c-67236f5a7561
# ╠═ee644d1c-931d-11eb-0527-e983ec4cfe4d
# ╠═abcac19c-92f6-11eb-3059-7b06f4f83274
# ╠═3f04a9dc-932b-11eb-05d8-ddfd8c24f51c
# ╟─443cab4e-9206-11eb-02c7-a94ac4731fa9
# ╠═6ede0ff0-9206-11eb-1707-a951873bddc0
# ╠═50c187e4-9211-11eb-2660-bd522d493517
# ╠═dfbadb4e-9207-11eb-1eb0-3d009c14c5e4
# ╠═ee364226-920c-11eb-1056-498a6f8870ad
# ╠═4aba8d00-9207-11eb-0224-1fdcd58d1b59
# ╟─4d877d64-9206-11eb-051b-b123e2b201ca
# ╠═e54a5410-93ed-11eb-07d3-09bbbbea8cd5
# ╠═5f3cd56a-9218-11eb-029d-c160db4e6459
# ╠═8b9930d8-9216-11eb-0763-79ad31839f43
# ╟─58e006fe-9206-11eb-0b44-c52864691d2c
# ╠═ea9f4d8a-9219-11eb-0147-5df0602c91dd
# ╠═e818d72c-9226-11eb-0930-7fbb692afcf9
# ╠═36481bb0-9227-11eb-289b-e508f961a989
# ╠═27ed403e-92c4-11eb-1945-518493c09da0
# ╠═a8af4dea-92c7-11eb-2e55-51e3d16cacd2
# ╠═70d2b922-92c5-11eb-13ac-d5aa8f18209b
# ╠═570e942e-92c6-11eb-2e7c-d992e9c4f177
# ╠═5df63f44-92c6-11eb-269b-d1b808dc01d7
# ╟─5a882b3a-9206-11eb-0d96-21cf7b07f40e
# ╠═0ab7945c-92d2-11eb-2de8-1b1bd070d13c
# ╠═c6d7de76-92d7-11eb-1eab-15d112628abb
# ╠═7d7d4746-92d4-11eb-3e57-c373fc4170b7
# ╠═bccd5d52-92d5-11eb-1600-b5c50bc7a360
# ╠═ce445d52-92d6-11eb-1bd6-379de812a724
