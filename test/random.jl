@testset "random_seq" begin
    showtestset()
    for dbn in ["(((...)))", "((((...).).((...))).)"]
        seq = random_seq(dbn)
        test_seq(seq, dbn)
    end
end
