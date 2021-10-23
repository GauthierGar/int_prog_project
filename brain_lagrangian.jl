
using JuMP, GLPK

p = [110,150,70,80,30,5]
w = [400,600,300,400,200,50]
n = 6
m = 2
b = [650,850]
u = [30,30,10,0,0,0]

one = [1,1,1,1,1,1]

model = Model(GLPK.Optimizer)

@variable(model, x[1:n,1:m], binary=false)

@objective(model, Max, sum(x'*p) + ((one-sum(x,dims = 2))' * u)[1])

for j=1:m
    @constraint(model, w'*x[:,j] <= b[j])
end

for i=1:n
    @constraint(model, sum(x[i,:]) <= 1)
end

for i=1:n
    for j=1:m
        @constraint(model, x[i,j] >= 0)
        @constraint(model, x[i,j] <= 1)
    end
end

JuMP.optimize!(model)

println("Objective is: ", JuMP.objective_value(model))
println("Solution is:")
println(JuMP.value.(x))

println("")
println("")
println("")

