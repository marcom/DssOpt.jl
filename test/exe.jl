@testset "exe_opt_md" begin
    showtestset()
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
        s = exe_opt_md(target; kwargs...)
        @test s isa String
        @test length(s) == length(target)
    end

    # verbose
    redirect_stdio(stdout=devnull, stderr=devnull) do
        s = exe_opt_md(target; verbose=true)
        @test s isa String
        @test length(s) == length(target)
    end
end

@testset "exe_opt_sd" begin
    showtestset()
    target = "(((...)))"
    for kwargs in [
        (; ),
        (; maxsteps = 100),
        (; kpi = 10000.1),
        (; kpa = 10000.1),
        (; kneg = 1.1),
        (; kpur = 1.1),
        (; khet = 10.1),
        (; het_window = 3),
        (; wiggle = 0.01),
        (; seed = 42),
        ]
        s = exe_opt_sd(target; kwargs...)
        @test s isa String
        @test length(s) == length(target)
    end

    # verbose
    redirect_stdio(stdout=devnull, stderr=devnull) do
        s = exe_opt_sd(target; verbose=true)
        @test s isa String
        @test length(s) == length(target)
    end
end

@testset "exe_opt_sd_gsl" begin
    showtestset()
    target = "(((...)))"
    for kwargs in [
        (; ),
        (; maxsteps = 100),
        (; kpi = 10000.1),
        (; kpa = 10000.1),
        (; kneg = 1.1),
        (; kpur = 1.1),
        (; khet = 10.1),
        (; het_window = 3),
        (; wiggle = 0.01),
        (; seed = 42),
        ]
        s = exe_opt_sd_gsl(target; kwargs...)
        @test s isa String
        @test length(s) == length(target)
    end

    # verbose
    redirect_stdio(stdout=devnull, stderr=devnull) do
        s = exe_opt_sd_gsl(target; verbose=true)
        @test s isa String
        @test length(s) == length(target)
    end
end
