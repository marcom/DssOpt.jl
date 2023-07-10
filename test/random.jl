@testset "random_seq" begin
    showtestset()
    for dbn in ["(((...)))", "((((...).).((...))).)"]
        seq = random_seq(dbn)
        test_seq(seq, dbn)
    end
    @test_throws ArgumentError random_seq("((...)"; verbose_errors=false)
    @test_throws ArgumentError random_seq("(...))"; verbose_errors=false)
end
