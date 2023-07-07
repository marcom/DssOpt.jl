using Test
using DssOpt
using FoldRNA: Pairtable, isunpaired, isbpopening, isbpclosing
const LEGALPAIRS = ("AU", "UA", "GC", "CG", "GU", "UG")

# show which testset is currently running
showtestset() = println(" "^(2 * Test.get_testset_depth()), "testing ",
                        Test.get_testset().description)

# test if a sequence is compatible to a dbn structure
function test_seq(seq::AbstractString, dbn::AbstractString)
    @test seq isa String
    @test length(seq) == length(dbn)
    @test all(b -> b ∈ "ACGU", seq)
    # test that all basepairs are legal
    pt = Pairtable(dbn)
    @test all(1:length(dbn)) do i
        if isunpaired(pt, i) || isbpclosing(pt, i)
            return true
        elseif isbpopening(pt, i)
            return seq[i] * seq[pt.pairs[i]] ∈ LEGALPAIRS
        else
            error("shouldn't be possible")
        end
    end
end

@testset verbose=true "DssOpt" begin
    showtestset()
    include("aqua.jl")
    include("opt.jl")
    include("random.jl")
    include("exe.jl")
end
