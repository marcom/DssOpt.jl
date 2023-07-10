@testset "opt_md" begin
    showtestset()
    for target_dbn in ["(((...)))", "(((((...))).(...)))"]
        seq = opt_md(target_dbn)
        test_seq(seq, target_dbn)
        # seed
        seq = opt_md(target_dbn; seed=rand(UInt))
        test_seq(seq, target_dbn)
    end
end

@testset "opt_md seq_constraints_hard" begin
    showtestset()
    for (target_dbn, seq_constraints_hard) in [
        ("(((...)))",
         "UACUNGNNN"),
        ("(((((...))).(...)))",
         "GNNNNUNNANNNCNCNNNN")
        ]
        seq = opt_md(target_dbn; seq_constraints_hard)
        test_seq(seq, target_dbn)
    end
    # wrong length
    @test_throws ArgumentError opt_md("(((...)))"; seq_constraints_hard="")
    @test_throws ArgumentError opt_md("(((...)))"; seq_constraints_hard="NNN")
    # illegal bases
    @test_throws ArgumentError opt_md("(((...)))"; seq_constraints_hard="NNNAAAHHH")
    # illegal basepair
    @test_throws ArgumentError opt_md("(((...)))"; seq_constraints_hard="GNNNNNNNG")
end

@testset "opt_sd" begin
    showtestset()
    for target_dbn in ["(((...)))", "(((((...))).(...)))"]
        seq = opt_sd(target_dbn)
        test_seq(seq, target_dbn)
        # seed
        seq = opt_sd(target_dbn; seed=rand(UInt))
        test_seq(seq, target_dbn)
    end
end
