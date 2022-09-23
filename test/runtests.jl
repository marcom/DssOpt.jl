using Test
using DssOpt

@testset "opt_md" begin
    target = "(((...)))"
    constr = "GNCANNNNC"
    for kwargs in [
        (; ),
        (; seq_constraints_hard = constr),
        (; timestep = 0.0001),
        (; start_temperature = 10.0),
        (; time_total = 5.0),
        (; time_cool = 2.0),
        (; kpi = 10000.1),
        (; kpa = 10000.1),
        (; kneg = 1.1),
        (; khet = 10.1),
        (; het_window = 3),
        (; cooling_type = :linear),
        (; cooling_type = :exponential),
        (; time_pur = 2.0),
        (; kpur_end = 1.1),
        (; seed = 42),
        ]
        @test opt_md(target; kwargs...) isa String
    end
end
