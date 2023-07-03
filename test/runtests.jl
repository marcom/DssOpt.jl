using Test
using DssOpt

# show which testset is currently running
showtestset() = println(" "^(2 * Test.get_testset_depth()), "testing ",
                        Test.get_testset().description)

@testset verbose=true "DssOpt" begin
    showtestset()
    include("opt.jl")
    include("exe.jl")
end
