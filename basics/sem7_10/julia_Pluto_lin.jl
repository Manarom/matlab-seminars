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
using Statistics, GLM,DataFrames,MAT, Plots,MultivariateStats,PlutoUI,LaTeXStrings,Images,ImageIO,TestImages,LinearAlgebra

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

# ╔═╡ c940e665-e055-4d75-8e3d-09525437e71f


# ╔═╡ 81ec5301-7bde-4f02-a191-5d6cb3136ff0
@bind type_im Select(["default", "test_image", "webcam"])

# ╔═╡ 19e79d80-2282-43bb-9fd4-a8e0dc057c1e
@bind test_image_name Select(TestImages.remotefiles)

# ╔═╡ a1d79755-d99f-464e-8c86-3b5d0c42a9c4
@bind im_data_cal WebcamInput(help=false)

# ╔═╡ 9007a73f-92c7-438c-86ff-df13fa88f32a
begin 
	if type_im=="default"
		im_data_load = load(joinpath(pwd(),"figs","test1.jpg"))
	elseif type_im=="test_image"
		im_data_load = testimage(test_image_name)
	else
		im_data_load = copy(im_data_cal)
	end
end;

# ╔═╡ 06293b21-39a4-49a8-999b-d1a283273f84
md"left vertical $(@bind left_remain_col Slider(1:size(im_data_load,2),default=1)), right vertical  $(@bind right_remain_col Slider(1:size(im_data_load,2),default=size(im_data_load,2)))"

# ╔═╡ b0c6d40a-5723-4f77-af8a-fb50b04ffab9
md"upper horizontal $(@bind up_remain_row Slider(1:size(im_data_load,1),default=1)), lower horizontal  $(@bind dwn_remain_row Slider(1:size(im_data_load,1),default=size(im_data_load,1)))"

# ╔═╡ 40a1c667-11a8-48da-94d3-61263e0f52f3
im_data = im_data_load[up_remain_row:dwn_remain_row,left_remain_col:right_remain_col]

# ╔═╡ 495cf577-4a43-4a8b-8180-da03563ea104
gray_image = Gray.(im_data);

# ╔═╡ 59a6eee5-4727-42e6-9946-eb8ca6ffcd65
@bind show_part Select(["original", "linreg", "pca linreg"])

# ╔═╡ d97cce38-8c67-40db-a5a2-053d1f320f15
md""" 
horizontal= $(@bind a_dim Slider(5:size(im_data,1),default=floor(2*size(im_data,1)/3), show_value=true))
vertical= $(@bind b_dim Slider(5:size(im_data,2),default=floor(2*size(im_data,2)/3),show_value=true))
	""" 

# ╔═╡ 8bca55a4-bf1b-47db-8593-338862a9a4f5
begin 
	M = size(gray_image,1)
	N = size(gray_image,2)
	t_dims = [a_dim,b_dim];
	num_image = convert(Array{Float64},gray_image)
	# test_image_dimentions 
	Mlast  = t_dims[1]
	Nlast = t_dims[2]
	XTrain =num_image[1:Mlast,1:Nlast] # формируем матрицу предикторов
	YTrain =num_image[1:Mlast,(Nlast+1):end] # формируем матрицу зависимой переменной
	XTest = num_image[(Mlast+1):end,1:Nlast]
	YTest = num_image[(Mlast+1):end,(Nlast+1):end]
	Itest = ones(Float64,(size(XTest,1),))
end;

# ╔═╡ 8a9cb875-53c8-42cc-a6e6-bea059e19852
begin
	B = MultivariateStats.llsq(XTrain,
		YTrain)
	Ypredict = hcat(Itest,XTest)*B
	
	pca_obj = fit(PCA, XTrain,maxoutdim=15);
	projection(pca_obj);

	#Bpca = MultivariateStats.llsq(reconstruct,
	#	YTrain)
	
end;

# ╔═╡ 9ef26e86-8bf9-4584-9257-4083efea0ecb
trim_bounds(lb,rb,val)= val<lb ? lb : val>rb ? rb : val

# ╔═╡ 4c39f833-4905-4c08-977e-8e9d5687e546
function trim_to_grey!(image_data)
	for (i,a) in enumerate(image_data)
		image_data[i]=trim_bounds(0,1,a)
	end
	return image_data
end

# ╔═╡ 474149e5-0cf9-41d5-a2a8-66ceabc3441c
function get_inds(vert,hor,step=2)
	return (vert-step:vert+step,hor-step:hor+step)
end

# ╔═╡ 6f29896b-b01d-4df6-b506-ed0bfa22aa3c
function add_cross!(vert,hor,imag;color=0)
	ranges = get_inds(vert,hor)
	imag[ranges[1],:].=color
	imag[:,ranges[2]].=color
	return imag
end

# ╔═╡ 86adaebf-3313-48da-9634-91f36ab2b577
begin 
	gray_image_to_show = copy(gray_image)
	if show_part != "original"
		 if show_part == "linreg"
			 gray_image_to_show[a_dim+1:end,b_dim+1:end] .= Gray.(trim_to_grey!(Ypredict))
		 else
		 end
	end
	add_cross!(a_dim,b_dim,gray_image_to_show)
	
end

# ╔═╡ ada0dc4c-3414-4388-b62d-b5667aa0249e
function add_cross(vert,hor,imag;color=0)
	gray_image_copy = copy(imag)
	return add_cross!(vert,hor,gray_image_copy,color=color)
end

# ╔═╡ Cell order:
# ╠═6bc0e2d0-8c81-4af8-8d5a-441aea48f9d4
# ╠═7ea0c852-e79e-11ef-276b-13fcf53182ec
# ╟─5668c805-8415-4c08-9193-3348e91b80d1
# ╟─c68546ef-2fb0-4a2a-b301-70894db9f36a
# ╠═863d1b1c-a93a-4a26-98dc-ffda6b4cd9d6
# ╠═5df5be1e-ee18-4132-b3f0-d03a12b5cc5c
# ╠═461727d7-9464-48e2-a5fc-6c6f6e69b6ad
# ╠═def5f2de-5a50-41df-a441-0194aa2d5f47
# ╠═50a7dbad-029b-4119-8fd0-385f33ff40da
# ╠═b6d92087-39f0-4f53-9719-cbe1e00de563
# ╟─0aef72ed-0299-4364-9ea9-cf4d97482fd8
# ╠═6ee3317f-a080-4a6c-8d27-76ae02cc9dc9
# ╠═cc60dc9e-2eb1-4037-a517-b31ff8746f6a
# ╠═30ca39c9-709d-46e1-8edd-2ff3975af278
# ╠═3553f1bc-f478-4f7f-9b1a-10165335aa17
# ╠═392bdf83-f6dc-46bf-80dc-4df53e5062c0
# ╠═443fab6e-a312-47a0-9ff3-d718774b944f
# ╠═c940e665-e055-4d75-8e3d-09525437e71f
# ╠═81ec5301-7bde-4f02-a191-5d6cb3136ff0
# ╠═19e79d80-2282-43bb-9fd4-a8e0dc057c1e
# ╠═a1d79755-d99f-464e-8c86-3b5d0c42a9c4
# ╠═9007a73f-92c7-438c-86ff-df13fa88f32a
# ╟─40a1c667-11a8-48da-94d3-61263e0f52f3
# ╟─06293b21-39a4-49a8-999b-d1a283273f84
# ╟─b0c6d40a-5723-4f77-af8a-fb50b04ffab9
# ╠═495cf577-4a43-4a8b-8180-da03563ea104
# ╟─86adaebf-3313-48da-9634-91f36ab2b577
# ╟─59a6eee5-4727-42e6-9946-eb8ca6ffcd65
# ╟─d97cce38-8c67-40db-a5a2-053d1f320f15
# ╠═8bca55a4-bf1b-47db-8593-338862a9a4f5
# ╠═8a9cb875-53c8-42cc-a6e6-bea059e19852
# ╟─4c39f833-4905-4c08-977e-8e9d5687e546
# ╟─9ef26e86-8bf9-4584-9257-4083efea0ecb
# ╟─474149e5-0cf9-41d5-a2a8-66ceabc3441c
# ╟─ada0dc4c-3414-4388-b62d-b5667aa0249e
# ╟─6f29896b-b01d-4df6-b506-ed0bfa22aa3c
