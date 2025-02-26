### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 6bc0e2d0-8c81-4af8-8d5a-441aea48f9d4
begin 
	notebook_path = pwd();
	cd(raw"..\..")
	@show pwd()
	import Pkg
	Pkg.activate(".")
	cd(notebook_path)
end

# ╔═╡ 7ea0c852-e79e-11ef-276b-13fcf53182ec
using Statistics, GLM,DataFrames,MAT, Plots,MultivariateStats,PlutoUI,LaTeXStrings,Images,ImageIO

# ╔═╡ 323036df-adb6-4a5a-823f-feb5f55efb33
plotly()

# ╔═╡ 5668c805-8415-4c08-9193-3348e91b80d1
md"""
## Several examples of general linear models in julia
* `GLM.jl` - generalized linear regression package with DataFrame support
* `Statistics.jl`  - package with basic descriptive statistics
* `DataFrames.jl` - package to work with data in column oriented format
* `MultivariateStats.jl` - alternative to GLM
	"""

# ╔═╡ c68546ef-2fb0-4a2a-b301-70894db9f36a
begin # import data from mat-file
	file = matopen("DataSurfFit.mat")
	data_dict=read(file)
	close(file)
	data = DataFrame(Y=data_dict["y"][:,1], X1=data_dict["X"][:,1],X2=data_dict["X"][:,2])
end

# ╔═╡ 863d1b1c-a93a-4a26-98dc-ffda6b4cd9d6
first_order= lm(@formula(Y ~ X1 + X2),data) # first order linear regression

# ╔═╡ 5df5be1e-ee18-4132-b3f0-d03a12b5cc5c
second_order = lm(@formula(Y ~ X1 + X2 +X1^2 + X2^2),data) # second order linear regression

# ╔═╡ 461727d7-9464-48e2-a5fc-6c6f6e69b6ad
fourth_order = lm(@formula(Y ~ X1 + X2 +X1^2 + X2^2+X1^3 + X2^3+X1^4 + X2^4),data)

# ╔═╡ def5f2de-5a50-41df-a441-0194aa2d5f47
function f_select2(modl::StatisticalModel)
	c = coef(modl) #array of polynomial coefficients
	order= div(length(c)-1,2)
	f = (x1,x2)->c[1]
	for i ∈ 1:order
		f=let fprev=f,i=i #need to introduce a new scope to prevent from stack overflow
			(x1,x2)->fprev(x1,x2)+ ^(x1,i)*c[2*i]+ ^(x2,i)*c[2*i+1]
		end
		
	end
	return f
end

# ╔═╡ bf818fae-eda6-4dfe-a4b5-975077c14628
#md"""
# 	Select regression order $(@bind ord Select([first_order=>1, second_order=>2]))
#"""

# ╔═╡ 50a7dbad-029b-4119-8fd0-385f33ff40da
md"""
	``\phi=`` $(@bind phi Slider(0:360,default=30,show_value=true)) 
	``\theta=`` $(@bind theta Slider(0:360,default=30,show_value=true)) 
	"""

# ╔═╡ b6d92087-39f0-4f53-9719-cbe1e00de563
@bind ch1  MultiCheckBox([first_order=>"first", second_order=>"second", fourth_order=>"fourth"])

# ╔═╡ 0aef72ed-0299-4364-9ea9-cf4d97482fd8
begin
	p=scatter3d(data.X1,data.X2,data.Y)
	for ord in ch1
		plot!(range(extrema(data.X1)...,20),range(extrema(data.X2)...,20),f_select2(ord),st=:surface,camera=(-phi,theta),alpha=0.5)
	end
	p
end

# ╔═╡ 6ee3317f-a080-4a6c-8d27-76ae02cc9dc9
md"""
### Second example is from MultivatiateStatistics package
"""

# ╔═╡ cc60dc9e-2eb1-4037-a517-b31ff8746f6a
Npoints = length( data_dict["y"])

# ╔═╡ 30ca39c9-709d-46e1-8edd-2ff3975af278
	a_lin = MultivariateStats.llsq(data_dict["X"], data_dict["y"])

# ╔═╡ 3553f1bc-f478-4f7f-9b1a-10165335aa17
coef(first_order)

# ╔═╡ 392bdf83-f6dc-46bf-80dc-4df53e5062c0
	a_square = MultivariateStats.llsq(hcat(data_dict["X"], data_dict["X"].^2), data_dict["y"])

# ╔═╡ 443fab6e-a312-47a0-9ff3-d718774b944f
coef(second_order)

# ╔═╡ 9007a73f-92c7-438c-86ff-df13fa88f32a
im_data = load(joinpath(pwd(),"figs","test1.jpg"))

# ╔═╡ 86adaebf-3313-48da-9634-91f36ab2b577
gray_image = Gray.(im_data)

# ╔═╡ fca50485-9db6-4389-a84b-4f5bbbb2155c
md" vertical= $(@bind a_dim Slider(1:800,default=100, show_value=true))"
	

# ╔═╡ d97cce38-8c67-40db-a5a2-053d1f320f15
md" horizontal= $(@bind b_dim Slider(1:800,default=100,show_value=true))" 

# ╔═╡ 8bca55a4-bf1b-47db-8593-338862a9a4f5
begin 
	M = size(gray_image,1)
	N = size(gray_image,2)
	t_dims = [a_dim,b_dim];
	# test_image_dimentions 
	Mlast = M-t_dims[1]-1 # число строк в обучающйе выборке
	Nlast = N-t_dims[2]-1# число столбцов предикторов в обучающей выборке
	XTrain =gray_image[1:Mlast,1:Nlast] # формируем матрицу предикторов
	YTrain =gray_image[1:Mlast,(Nlast+1):end] # формируем матрицу зависимой переменной
	XTest = gray_image[(Mlast+1):end,1:Nlast]
	YTest = gray_image[(Mlast+1):end,(Nlast+1):end]
end;

# ╔═╡ 8a9cb875-53c8-42cc-a6e6-bea059e19852


# ╔═╡ Cell order:
# ╠═6bc0e2d0-8c81-4af8-8d5a-441aea48f9d4
# ╠═7ea0c852-e79e-11ef-276b-13fcf53182ec
# ╠═323036df-adb6-4a5a-823f-feb5f55efb33
# ╟─5668c805-8415-4c08-9193-3348e91b80d1
# ╟─c68546ef-2fb0-4a2a-b301-70894db9f36a
# ╠═863d1b1c-a93a-4a26-98dc-ffda6b4cd9d6
# ╠═5df5be1e-ee18-4132-b3f0-d03a12b5cc5c
# ╠═461727d7-9464-48e2-a5fc-6c6f6e69b6ad
# ╠═def5f2de-5a50-41df-a441-0194aa2d5f47
# ╠═bf818fae-eda6-4dfe-a4b5-975077c14628
# ╠═50a7dbad-029b-4119-8fd0-385f33ff40da
# ╠═b6d92087-39f0-4f53-9719-cbe1e00de563
# ╠═0aef72ed-0299-4364-9ea9-cf4d97482fd8
# ╠═6ee3317f-a080-4a6c-8d27-76ae02cc9dc9
# ╠═cc60dc9e-2eb1-4037-a517-b31ff8746f6a
# ╠═30ca39c9-709d-46e1-8edd-2ff3975af278
# ╠═3553f1bc-f478-4f7f-9b1a-10165335aa17
# ╠═392bdf83-f6dc-46bf-80dc-4df53e5062c0
# ╠═443fab6e-a312-47a0-9ff3-d718774b944f
# ╠═9007a73f-92c7-438c-86ff-df13fa88f32a
# ╠═86adaebf-3313-48da-9634-91f36ab2b577
# ╟─fca50485-9db6-4389-a84b-4f5bbbb2155c
# ╟─d97cce38-8c67-40db-a5a2-053d1f320f15
# ╠═8bca55a4-bf1b-47db-8593-338862a9a4f5
# ╠═8a9cb875-53c8-42cc-a6e6-bea059e19852
