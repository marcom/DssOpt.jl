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
    @test_throws ArgumentError redirect_stdout(devnull) do
        try
            opt_md("(((...)))"; seq_constraints_hard="NNNAAAHHH")
        catch
            # flush here, otherwise the leftovers appear later
            Libc.flush_cstdio()
            rethrow()
        end
    end
    # illegal basepair
    @test_throws ArgumentError redirect_stdout(devnull) do
        try
            opt_md("(((...)))"; seq_constraints_hard="GNNNNNNNG")
        catch
            Libc.flush_cstdio()
            rethrow()
        end
    end
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
