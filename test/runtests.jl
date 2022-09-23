using Test
using DssOpt

@testset "opt_md" begin
    @test opt_md("(((...)))") isa String
end
