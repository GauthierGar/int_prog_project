
using JuMP, GLPK

using LinearAlgebra

function k_comp(d,n,K)
    k_ij = Matrix(I,n,n)
    for i=1:10
        for j=i+1:10
            if abs(d[i]-d[j]) <= K
                k_ij[i,j] = 1
                k_ij[j,i] = 1
            end
        end
    end
    
    return k_ij
end


n = 10
d = [250,450,850,950,1150,1350,1450,1800,2000,2150]
v = [100,175,250,100,325,80,210,300,200,110]
K = 300

k_ij = k_comp(d,n,K)

model = Model(GLPK.Optimizer)

@variable(model, x[1:10], binary=false)

for i=1:10
    @constraint(model, x[i] >= 0)
    @constraint(model, x[i] <= 1)
end

for i=1:n-1
    for j=i+1:n
        @constraint(model, x[i] + x[j] <= 2 - k_ij[i,j])
    end
end

@objective(model, Max, x'*v)




JuMP.optimize!(model)

println("Objective is: ", JuMP.objective_value(model))
println("Solution is:")
for i=1:10
println(JuMP.value(x[i]))
end
println("")
println("")
println("")

