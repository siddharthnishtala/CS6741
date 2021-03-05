### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 66523e96-7b96-11eb-254c-2da9ad4bd173
begin
	using DataFrames
	using Dates
	using HTTP
	using JSON
	using Plots
end

# ╔═╡ 092037d2-7b96-11eb-0c6e-150ee01746c8
md"# Assignment 2"

# ╔═╡ e11835f0-7b95-11eb-3bf3-53d9de8dadc6
md"*Name:* Siddharth Nishtala"

# ╔═╡ 3e3387c6-7b96-11eb-2717-1d20b0e21c4d
md"*Roll No.:* CS20S022"

# ╔═╡ 6e0ff02e-7b96-11eb-0811-89f6597cdf33
md"### Importing Required Packages"

# ╔═╡ 496201f4-7b96-11eb-1ae9-e1e3ea683e3a
md"### Question 1"

# ╔═╡ af339c62-7b97-11eb-3da1-690b30679c98
md"Creating the untidy dataframe in a row-wise manner."

# ╔═╡ 551b4168-7b96-11eb-3189-c59a16989cc1
begin
	untidy_data_q1 = DataFrame(
		religion = String[], 
		less_than_10k = Int[],
		from_10k_to_20k = Int[],
		from_20k_to_30k = Int[],
		from_30k_to_40k = Int[],
		from_40k_to_50k = Int[],
		from_50k_to_75k = Int[]
	)
	push!(untidy_data_q1, ("Agnostic", 27, 34, 60, 81, 76, 137))
	push!(untidy_data_q1, ("Athiest", 12, 27, 37, 52, 35, 70))
	push!(untidy_data_q1, ("Buddhist", 27, 21, 30, 34, 33, 58))
	push!(untidy_data_q1, ("Catholic", 418, 617, 732, 670, 638, 1116))
	push!(untidy_data_q1, ("Don't know / refused", 15, 14, 15, 11, 10, 35))
	push!(untidy_data_q1, ("Evangelical Prot", 575, 869, 1064, 982, 881, 1486))
	push!(untidy_data_q1, ("Hindu", 1, 9, 7, 9, 11, 34))
	push!(untidy_data_q1, ("Historically Black Prot", 228, 244, 236, 238, 197, 223))
	push!(untidy_data_q1, ("Jehovah's Witness", 20, 27, 24, 24, 21, 30))
	push!(untidy_data_q1, ("Jewish", 19, 19, 25, 25, 30, 95))
	push!(untidy_data_q1, ("Raëlism", 1, 3, 2, 1, 4, 300))
end

# ╔═╡ ea228ecc-7b98-11eb-34dc-35ba6990e10e
md"Transforming the untidy dataset into tidy dataset."

# ╔═╡ aec8a8d8-7b99-11eb-28a2-6d66f5445833
begin
	tidy_data_q1 = sort(
		DataFrames.stack(untidy_data_q1, 2:(size(untidy_data_q1)[2]), :religion),
		:religion
	)
	rename!(tidy_data_q1,:variable => :income)
	rename!(tidy_data_q1,:value => :freq)
end

# ╔═╡ 9ef4eba2-7b9b-11eb-2c5d-c7c341533611
md"### Question 2"

# ╔═╡ d706841a-7b9d-11eb-1041-79d5bdd42bd9
md"Creating the untidy dataframe with missing values in a row-wise manner."

# ╔═╡ bd3e27b8-7b9b-11eb-2b32-d1cecfef4719
begin
	untidy_data_q2 = DataFrame(
		id = String[], 
		year = Int[],
		month = Int[],
		element = String[],
		d1 = [],
		d2 = [],
		d3 = [],
		d4 = [],
		d5 = [],
		d6 = [],
		d7 = [],
		d8 = []
	)
	push!(untidy_data_q2, (
			"MX17004", 2010, 1, "tmax", 
			7.8, missing, missing, 7.9, missing, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17004", 2010, 1, "tmin", 
			missing, missing, missing, 3.5, missing, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17004", 2010, 2, "tmax", 
			missing, 27.3, 24.1, missing, missing, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17004", 2010, 2, "tmin", 
			missing, 14.4, 14.4, missing, missing, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17004", 2010, 3, "tmax", 
			missing, missing, missing, missing, 32.1, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17004", 2010, 3, "tmin", 
			missing, missing, missing, missing, 14.2, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17004", 2010, 4, "tmax", 
			missing, missing, missing, missing, missing, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17004", 2010, 4, "tmin", 
			missing, missing, missing, missing, missing, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17004", 2010, 5, "tmax", 
			missing, missing, missing, missing, missing, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17004", 2010, 5, "tmin", 
			missing, missing, missing, missing, missing, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17005", 2010, 1, "tmax", 
			27.8, missing, missing, 27.9, missing, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17005", 2010, 1, "tmin", 
			missing, missing, missing, 43.5, missing, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17005", 2010, 2, "tmax", 
			missing, 47.3, 44.1, missing, missing, missing, missing, missing
		)
	)
	push!(untidy_data_q2, (
			"MX17005", 2010, 2, "tmin", 
			missing, 43.3, 41.1, missing, missing, missing, missing, missing
		)
	)
end

# ╔═╡ a025787a-7ba2-11eb-03aa-1f7ba233b111
md"Transforming the untidy data with missing values to the required format."

# ╔═╡ ec2892a4-7b9d-11eb-20a4-eb8c1b262210
begin
	tidy_data_q2 = DataFrames.stack(
		untidy_data_q2, 5:(size(untidy_data_q2)[2]), [:id, :year, :month, :element]
	)
	
	tidy_data_q2 = dropmissing(tidy_data_q2, :value)
	
	tidy_data_q2 = transform(
		tidy_data_q2, 
		:variable => ByRow(x -> parse(Int8,x[2:length(x)])) => :day
	)
	
	tidy_data_q2 = transform(
		tidy_data_q2, 
		[:year, :month, :day] => ByRow((y, m, d) -> Date(y, m, d)) => :date
	)
	
	# Strategy 1 - tmax/tmin missing in the untidy data -> missing in tidy data
	tidy_data_q2 = tidy_data_q2[:, [:id, :date, :element, :value]]
	tidy_data_q2 = unstack(
		tidy_data_q2, [:id, :date], :element, :value
	)
	
	# Strategy 2 - tmax/tmin missing in the untidy data -> not missing in tidy data
	# tidy_data_q2 = groupby(tidy_data_q2, [:id, :date])
	# tidy_data_q2 = combine(
	# 	tidy_data_q2, :value => (x -> [extrema(x)]) => [:tmin, :tmax]
	# )
	
	sort!(tidy_data_q2, [:id, :date])
end

# ╔═╡ a82f1974-7b9b-11eb-1c72-f7808e0b397d
md"### Question 3"

# ╔═╡ 272c8982-7c16-11eb-047a-e3933b686466
md"Creating the untidy dataframe in a row-wise manner."

# ╔═╡ 73d4af14-7ba4-11eb-15b2-e19f6108c1ab
begin
	untidy_data_q3 = DataFrame(
		year = Int[], 
		artist = String[],
		time = String[],
		track = String[],
		date = Date[],
		week = Int[],
		rank = Int[]
	)
	push!(
		untidy_data_q3, 
		(2000, "2 Pac", "4:22", "Baby Don't Cry", Date(2000, 2, 26), 1, 87)
	)
	push!(
		untidy_data_q3, 
		(2000, "2 Pac", "4:22", "Baby Don't Cry", Date(2000, 3, 4), 2, 82)
	)
	push!(
		untidy_data_q3, 
		(2000, "2 Pac", "4:22", "Baby Don't Cry", Date(2000, 3, 11), 3, 72)
	)
	push!(
		untidy_data_q3, 
		(2000, "2 Pac", "4:22", "Baby Don't Cry", Date(2000, 3, 18), 4, 77)
	)
	push!(
		untidy_data_q3, 
		(2000, "2 Pac", "4:22", "Baby Don't Cry", Date(2000, 3, 25), 5, 87)
	)
	push!(
		untidy_data_q3, 
		(2000, "2 Pac", "4:22", "Baby Don't Cry", Date(2000, 4, 1), 6, 94)
	)
	push!(
		untidy_data_q3, 
		(2000, "2 Pac", "4:22", "Baby Don't Cry", Date(2000, 4, 8), 7, 99)
	)
	push!(
		untidy_data_q3, 
		(2000, "2Ge+her", "3:15", "The Hardest Part..", Date(2000, 9, 2), 1, 91)
	)
	push!(
		untidy_data_q3, 
		(2000, "2Ge+her", "3:15", "The Hardest Part..", Date(2000, 9, 9), 2, 87)
	)
	push!(
		untidy_data_q3, 
		(2000, "2Ge+her", "3:15", "The Hardest Part..", Date(2000, 9, 16), 3, 92)
	)
	push!(
		untidy_data_q3, 
		(2000, "3 Doors Down", "3:53", "Kryptonite", Date(2000, 4, 8), 1, 81)
	)
	push!(
		untidy_data_q3, 
		(2000, "3 Doors Down", "3:53", "Kryptonite", Date(2000, 4, 15), 2, 70)
	)
	push!(
		untidy_data_q3, 
		(2000, "3 Doors Down", "3:53", "Kryptonite", Date(2000, 4, 22), 3, 68)
	)
	push!(
		untidy_data_q3, 
		(2000, "3 Doors Down", "3:53", "Kryptonite", Date(2000, 4, 29), 4, 67)
	)
	push!(
		untidy_data_q3, 
		(2000, "3 Doors Down", "3:53", "Kryptonite", Date(2000, 5, 6), 5, 66)
	)
end

# ╔═╡ 30277cde-7c16-11eb-0863-95918ef1d0e2
md"Creating a dataframe with columns that are not dependent on time."

# ╔═╡ c04cec18-7c11-11eb-2051-e73f3e3cc80b
begin
	tidy_data_q3_static = untidy_data_q3[:, [:artist, :time, :track]]
	unique!(tidy_data_q3_static)
	insertcols!(
		tidy_data_q3_static, 
		1, 
		:id => 1:size(tidy_data_q3_static)[1],
		makeunique=true
	)
end

# ╔═╡ 5334f526-7c16-11eb-2518-292352716d39
md"Creating a dataframe with columns that are dependent on time."

# ╔═╡ fc244caa-7c15-11eb-23cd-794af74eadd2
begin
	tidy_data_q3_dynamic = leftjoin(
		tidy_data_q3_static[:, [:id, :track]], 
		untidy_data_q3[:, [:track, :date, :rank]],
		on = :track
	)
	tidy_data_q3_dynamic = tidy_data_q3_dynamic[:, [:id, :date, :rank]]
end

# ╔═╡ aef1a484-7b9b-11eb-0c68-5354d2ab08e0
md"### Question 4"

# ╔═╡ 6738844e-7c24-11eb-04e8-9de75c9c1666
md"Reading the data from the given source."

# ╔═╡ 7ae2634c-7c16-11eb-1401-afb758c8a8be
begin
	r = HTTP.request("GET", "https://api.covid19india.org/data.json")
	data_dictionary = JSON.parse(String(r.body))
	cols = reduce(∩, keys.(data_dictionary["cases_time_series"]))
	covid_data = DataFrame(
		(
			Symbol(c)=>getindex.(
				data_dictionary["cases_time_series"], c
			) for c ∈ cols
		)...
	)
end

# ╔═╡ 7496970c-7c24-11eb-3230-093402cfce65
md"Processing the data: changing the data types and re-ordering columns."

# ╔═╡ a96434ac-7c20-11eb-0282-991ba7842480
begin
	processed_covid_data = copy(covid_data)
	processed_covid_data[!, :dateymd] = parse.(
		Date, processed_covid_data[!, :dateymd]
	)
	processed_covid_data[!, :dailyconfirmed] = parse.(
		Int64, processed_covid_data[!, :dailyconfirmed]
	)
	processed_covid_data[!, :dailydeceased] = parse.(
		Int64, processed_covid_data[!, :dailydeceased]
	)
	processed_covid_data[!, :dailyrecovered] = parse.(
		Int64, processed_covid_data[!, :dailyrecovered]
	)
	processed_covid_data[!, :totalconfirmed] = parse.(
		Int64, processed_covid_data[!, :totalconfirmed]
	)
	processed_covid_data[!, :totaldeceased] = parse.(
		Int64, processed_covid_data[!, :totaldeceased]
	)
	processed_covid_data[!, :totalrecovered] = parse.(
		Int64, processed_covid_data[!, :totalrecovered]
	)
	processed_covid_data = processed_covid_data[
		:, [
			:dateymd, 
			:date, 
			:dailyconfirmed, 
			:dailydeceased, 
			:dailyrecovered,
			:totalconfirmed,
			:totaldeceased,
			:totalrecovered
		]
	]
end

# ╔═╡ 9faa5190-7c24-11eb-2d6f-0da5d387a37c
md"Calculating aggregates of daily confirmed cases, daily deaths and daily recoveries for each month since January 2020."

# ╔═╡ 4c3e8fdc-7c1d-11eb-148f-0d4eef8438ca
begin
	relevant_covid_data_q4 = processed_covid_data[
		:, [:dailyconfirmed, :dailydeceased, :dailyrecovered, :dateymd]
	]

	transform!(
		relevant_covid_data_q4, 
		:dateymd => ByRow(
			x -> [Dates.year(x), Dates.month(x), Dates.day(x)]
		) => [:year, :month, :day]
	)
	
	monthly_aggregates = combine(
		groupby(relevant_covid_data_q4, [:month, :year]),
		:dailyconfirmed => sum,
		:dailydeceased => sum,
		:dailyrecovered => sum,
	)
	rename!(monthly_aggregates, :dailyconfirmed_sum => :total_confirmed)
	rename!(monthly_aggregates, :dailydeceased_sum => :total_deceased)
	rename!(monthly_aggregates, :dailyrecovered_sum => :total_recovered)
end

# ╔═╡ b0e6dc46-7b9b-11eb-29ec-adfed1267664
md"### Question 5"

# ╔═╡ 349fc522-7c35-11eb-36c9-eb0aeeb2477d
md"""
Setting the window size for calculating the n-day moving averages.

*Note*: The plots and the column values are computed as a function of n and hence, will change based on the value. 
"""

# ╔═╡ 4d8f295a-7c31-11eb-068d-2d86b23b1922
n = 7;

# ╔═╡ 603b46f2-7c35-11eb-2090-f7bf3361b683
md"Calculating the $(n)-day moving averages."

# ╔═╡ 4227bcec-7c2e-11eb-253a-357e45c1138d
begin
	relevant_covid_data_q5 = processed_covid_data[
		:, [:dailyconfirmed, :dailydeceased, :dailyrecovered, :dateymd]
	]
	n_day_moving_average_confirmed = Any[missing for i in 1:(n-1)]
	n_day_moving_average_deceased = Any[missing for i in 1:(n-1)]
	n_day_moving_average_recovered = Any[missing for i in 1:(n-1)]
	for i in n:size(relevant_covid_data_q5)[1]
		push!(
			n_day_moving_average_confirmed, 
			sum(relevant_covid_data_q5[i-(n-1):i, :dailyconfirmed])/n
		)
		push!(
			n_day_moving_average_deceased, 
			sum(relevant_covid_data_q5[i-(n-1):i, :dailydeceased])/n
		)
		push!(
			n_day_moving_average_recovered, 
			sum(relevant_covid_data_q5[i-(n-1):i, :dailyrecovered])/n
		)
	end
	relevant_covid_data_q5[
		:, :n_day_moving_average_confirmed
	] = n_day_moving_average_confirmed
	relevant_covid_data_q5[
		:, :n_day_moving_average_deceased
	] = n_day_moving_average_deceased
	relevant_covid_data_q5[
		:, :n_day_moving_average_recovered
	] = n_day_moving_average_recovered
	relevant_covid_data_q5
end

# ╔═╡ 74045606-7c3a-11eb-1db3-ab37f91fb3a8
md"Plot 1: Number of Cases Confirmed - Original and $(n)-Day Moving Average."

# ╔═╡ 97f1d7ca-7c33-11eb-01f9-4589b32262e3
begin
	plot(
		relevant_covid_data_q5[!, :dateymd], 
		relevant_covid_data_q5[!, :dailyconfirmed],
		label="Original",
		xlabel="Date",
		ylabel="Number of Cases Confirmed"
	)
	plot!(
		relevant_covid_data_q5[
			n:size(relevant_covid_data_q5)[1], 
			:dateymd
		], 
		relevant_covid_data_q5[
			n:size(relevant_covid_data_q5)[1], 
			:n_day_moving_average_confirmed
		],
		label=repr(n)*"-Day Moving Average", 
		fmt = :png
	)
	
end

# ╔═╡ a6821a14-7c3a-11eb-1a3c-0d40a49b1c18
md"Plot 2: Number of Deaths - Original and $(n)-Day Moving Average."

# ╔═╡ f4c4284a-7c33-11eb-266d-53f8d0657c66
begin
	plot(
		relevant_covid_data_q5[!, :dateymd], 
		relevant_covid_data_q5[!, :dailydeceased],
		label="Original",
		xlabel="Date",
		ylabel="Number of Deaths"
	)
	plot!(
		relevant_covid_data_q5[
			n:size(relevant_covid_data_q5)[1], 
			:dateymd
		], 
		relevant_covid_data_q5[
			n:size(relevant_covid_data_q5)[1], 
			:n_day_moving_average_deceased
		],
		label=repr(n)*"-Day Moving Average", 
		fmt = :png
	)
	
end

# ╔═╡ ae6e760a-7c3a-11eb-242c-41cac44d7a0b
md"Plot 3: Number of Recoveries - Original and $(n)-Day Moving Average."

# ╔═╡ 21b30a60-7c34-11eb-00fc-ef2c07879ff3
begin
	plot(
		relevant_covid_data_q5[!, :dateymd], 
		relevant_covid_data_q5[!, :dailyrecovered],
		label="Original",
		xlabel="Date",
		ylabel="Number of Recoveries"
	)
	plot!(
		relevant_covid_data_q5[
			n:size(relevant_covid_data_q5)[1], 
			:dateymd
		], 
		relevant_covid_data_q5[
			n:size(relevant_covid_data_q5)[1], 
			:n_day_moving_average_recovered
		],
		label=repr(n)*"-Day Moving Average", 
		fmt = :png
	)
	
end

# ╔═╡ Cell order:
# ╟─092037d2-7b96-11eb-0c6e-150ee01746c8
# ╟─e11835f0-7b95-11eb-3bf3-53d9de8dadc6
# ╟─3e3387c6-7b96-11eb-2717-1d20b0e21c4d
# ╟─6e0ff02e-7b96-11eb-0811-89f6597cdf33
# ╠═66523e96-7b96-11eb-254c-2da9ad4bd173
# ╟─496201f4-7b96-11eb-1ae9-e1e3ea683e3a
# ╟─af339c62-7b97-11eb-3da1-690b30679c98
# ╟─551b4168-7b96-11eb-3189-c59a16989cc1
# ╟─ea228ecc-7b98-11eb-34dc-35ba6990e10e
# ╟─aec8a8d8-7b99-11eb-28a2-6d66f5445833
# ╟─9ef4eba2-7b9b-11eb-2c5d-c7c341533611
# ╟─d706841a-7b9d-11eb-1041-79d5bdd42bd9
# ╟─bd3e27b8-7b9b-11eb-2b32-d1cecfef4719
# ╟─a025787a-7ba2-11eb-03aa-1f7ba233b111
# ╟─ec2892a4-7b9d-11eb-20a4-eb8c1b262210
# ╟─a82f1974-7b9b-11eb-1c72-f7808e0b397d
# ╟─272c8982-7c16-11eb-047a-e3933b686466
# ╟─73d4af14-7ba4-11eb-15b2-e19f6108c1ab
# ╟─30277cde-7c16-11eb-0863-95918ef1d0e2
# ╟─c04cec18-7c11-11eb-2051-e73f3e3cc80b
# ╟─5334f526-7c16-11eb-2518-292352716d39
# ╟─fc244caa-7c15-11eb-23cd-794af74eadd2
# ╟─aef1a484-7b9b-11eb-0c68-5354d2ab08e0
# ╟─6738844e-7c24-11eb-04e8-9de75c9c1666
# ╟─7ae2634c-7c16-11eb-1401-afb758c8a8be
# ╟─7496970c-7c24-11eb-3230-093402cfce65
# ╟─a96434ac-7c20-11eb-0282-991ba7842480
# ╟─9faa5190-7c24-11eb-2d6f-0da5d387a37c
# ╟─4c3e8fdc-7c1d-11eb-148f-0d4eef8438ca
# ╟─b0e6dc46-7b9b-11eb-29ec-adfed1267664
# ╟─349fc522-7c35-11eb-36c9-eb0aeeb2477d
# ╠═4d8f295a-7c31-11eb-068d-2d86b23b1922
# ╟─603b46f2-7c35-11eb-2090-f7bf3361b683
# ╟─4227bcec-7c2e-11eb-253a-357e45c1138d
# ╟─74045606-7c3a-11eb-1db3-ab37f91fb3a8
# ╟─97f1d7ca-7c33-11eb-01f9-4589b32262e3
# ╟─a6821a14-7c3a-11eb-1a3c-0d40a49b1c18
# ╟─f4c4284a-7c33-11eb-266d-53f8d0657c66
# ╟─ae6e760a-7c3a-11eb-242c-41cac44d7a0b
# ╟─21b30a60-7c34-11eb-00fc-ef2c07879ff3
