
using JuMP, GLPK

n = [0,8,6,6,4,8,4,0]
t = [0,5,5,4,4,6,3,0]
c = [0,15000,12500,6500,0,20000,7500,0]
d = [0,8,6,6,4,8,4,0]
T = 15


model = Model(GLPK.Optimizer)

@variable(model, x[1:8], integer=false)
@variable(model, y[1:8], integer=false)

#@objective(model, Min, x[8])
@objective(model, Min, c'*y)

@constraint(model, x[1] == 0)

for i=1:8
    @constraint(model, d[i] == n[i] - y[i])
    @constraint(model, t[i] <= d[i])
    @constraint(model, d[i] <= n[i])
end

@constraint(model, x[2] >= x[1] + d[1])

@constraint(model, x[3] >= x[2] + d[2])
@constraint(model, x[3] >= x[5] + d[5])

@constraint(model, x[4] >= x[3] + d[3])

@constraint(model, x[5] >= x[1] + d[1])
@constraint(model, x[6] >= x[5] + d[5])

@constraint(model, x[7] >= x[6] + d[6])
@constraint(model, x[7] >= x[3] + d[3])

@constraint(model, x[8] >= x[7] + d[7])
@constraint(model, x[8] >= x[4] + d[4])

for i=1:8
    @constraint(model, x[i] >= 0)
    @constraint(model, y[i] >= 0)
end

@constraint(model, x[8] == T)

JuMP.optimize!(model)

println("Objective is: ", JuMP.objective_value(model))
println("Solution is:")
for i=1:8
    println(JuMP.value(x[i]))
end
println("y solution:")
for i=1:8
    println(JuMP.value(y[i]))
end

println("")
println("")
println("")

