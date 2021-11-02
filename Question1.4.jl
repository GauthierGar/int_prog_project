using JuMP
using GLPK

bo = false

m=Model(with_optimizer(GLPK.Optimizer))
@variable(m, x1 >=0, integer=bo)
@variable(m, x2 >=0, integer=bo)
@variable(m, x3 >=0, integer=bo)
@variable(m, x4 >=0, integer=bo)
@variable(m, x5 >=0, integer=bo)
@variable(m, x6 >=0, integer=bo)
@variable(m, x7 >=0, integer=bo)


@objective(m,Min,x7)
@constraint(m, x2-x1>=8)
@constraint(m, x2-x4>=4)
@constraint(m, x5-x4>=4)
@constraint(m, x3-x2>=6)
@constraint(m, x6-x2>=6)
@constraint(m, x6-x5>=8)
@constraint(m, x7-x6>=4)
@constraint(m, x7-x3>=6)
optimize!(m)

if termination_status(m) == MOI.OPTIMAL
    println("Objective value: ",JuMP.objective_value(m))
    println("xA = ", JuMP.value(x1))
    println("xB = ", JuMP.value(x2))
    println("xC = ", JuMP.value(x3))
    println("xD = ", JuMP.value(x4))
    println("xE = ", JuMP.value(x5))
    println("xF = ", JuMP.value(x6))
    println("xend = ", JuMP.value(x7))
else
    println("Optimize was not succesfull. Return code: ", termination_status(m))
end
