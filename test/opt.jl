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
    @test_throws ArgumentError opt_md("(((...)))"; seq_constraints_hard="")
    @test_throws ArgumentError opt_md("(((...)))"; seq_constraints_hard="XXX")
    # TODO: currently exits the program: ERROR: illegal character 'H' in hard sequence constraints
    # @test_throws ArgumentError opt_md("(((...)))"; seq_constraints_hard="NNNAAAHHH")
    # TODO: currently exits the program: ERROR: illegal base pair (G0, G8) cannot be satisfied.
    # @test_throws ArgumentError opt_md("(((...)))"; seq_constraints_hard="GNNNNNNNG")
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
