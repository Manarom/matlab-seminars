
using Statistics, GLM,DataFrames,MAT, Plots,MultivariateStats

"""
## Several examples of general linear models in julia
* `GLM.jl` - generalized linear regression package with DataFrame support
* `Statistics.jl`  - package with basic descriptive statistics
* `DataFrames.jl` - package to work with data in column oriented format
* `MultivariateStats.jl` - alternative to GLM
"""
file = matopen(joinpath(".","basics","sem7_10","DataSurfFit.mat"))
data_dict=read(file)
close(file)
data = DataFrame(Y=data_dict["y"][:,1], X1=data_dict["X"][:,1],X2=data_dict["X"][:,2])

first_order= lm(@formula(Y ~ X1 + X2),data) # first order linear regression

second_order = lm(@formula(Y ~ X1 + X2 +X1^2 + X2^2),data) # second order linear regression

f_select(modl::StatisticalModel)= begin
	c = coef(modl)
	N=length(c)
	if N==3 
		return (x1,x2)->c[1] + c[2]*x1 + c[3]*x2
	else
		return (x1,x2)->c[1] + c[2]*x1 + c[3]*x2 + c[4]*x1^2 + c[5]*x2^2
	end
end
p=scatter3d(data.X1,data.X2,data.Y)
for ord in (first_order,second_order)
    f=f_select(ord)
    plot!(range(extrema(data.X1)...,100),range(extrema(data.X2)...,100),f,st=:surface,camera=(-30,30),alpha=0.5)
end

a_lin = MultivariateStats.llsq(data_dict["X"], data_dict["y"])
coef(first_order)
a_square = MultivariateStats.llsq(hcat(data_dict["X"], data_dict["X"].^2), data_dict["y"])
coef(second_order)
display(p)