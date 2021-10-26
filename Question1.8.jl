using JuMP
using GLPK

m=Model(with_optimizer(GLPK.Optimizer))
@variable(m, x1 >=0 )
@variable(m, x2 >=0 )
@variable(m, x3 >=0 )
@variable(m, x4 >=0 )
@variable(m, x5 >=0 )
@variable(m, x6 >=0 )
@variable(m, y1 >=0 )
@variable(m, y2 >=0 )
@variable(m, y3 >=0 )
@variable(m, y5 >=0 )
@variable(m, y6 >=0 )


@objective(m,Min,y1*15000+y2*12500+y3*6500+y5*20000+y6*7500)
@constraint(m, x2-x1>=8-y1)
@constraint(m, x2-x4>=4)
@constraint(m, x5-x4>=4)
@constraint(m, x3-x2>=6-y2)
@constraint(m, x6-x2>=6-y2)
@constraint(m, x6-x5>=8-y2)
@constraint(m, 17-x3>=6-y3)
@constraint(m, 17-x6>=4-y6)
@constraint(m, y1<=3)
@constraint(m, y2<=1)
@constraint(m, y3<=2)
@constraint(m, y5<=2)
@constraint(m, y6<=1)

optimize!(m)

if termination_status(m) == MOI.OPTIMAL
    println("Objective value: ",JuMP.objective_value(m))
    println("xA = ", JuMP.value(x1))
    println("xB = ", JuMP.value(x2))
    println("xC = ", JuMP.value(x3))
    println("xD = ", JuMP.value(x4))
    println("xE = ", JuMP.value(x5))
    println("xF = ", JuMP.value(x6))
    println("Objective value: ",JuMP.objective_value(m))
    println("yA = ", JuMP.value(y1))
    println("yB = ", JuMP.value(y2))
    println("yC = ", JuMP.value(y3))
    println("yE = ", JuMP.value(y5))
    println("yF = ", JuMP.value(y6))
else
    println("Optimize was not succesfull. Return code: ", termination_status(m))
end
