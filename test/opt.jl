# TODO
# - when using sequence constraints, test that designed sequences
#   fulfill them

@testset "opt_md" begin
    showtestset()
    for target_dbn in ["(((...)))", "(((((...))).(...)))"]
        seq = opt_md(target_dbn)
        test_seq(seq, target_dbn)
        # seed
        seq = opt_md(target_dbn; seed=rand(UInt))
        test_seq(seq, target_dbn)
        # illegal dbn
        @test_throws ArgumentError opt_md("((...)")
        @test_throws ArgumentError opt_md("(...))")
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
        # illegal dbn
        @test_throws ArgumentError opt_sd("((...)")
        @test_throws ArgumentError opt_sd("(...))")
    end
end

function test_movie_out(target_dbn::String, final_seq::String,
                        seqs::Vector{String}, pseqs::Array{Float64,3})
    BASES = "ACGU"
    test_seq(final_seq, target_dbn)
    @test all(seq -> length(seq) == length(target_dbn), seqs)
    @test all(seqs) do seq
        all(b -> b ∈ BASES, seq)
    end
    n = length(target_dbn)
    nbases = length(BASES)
    nframes = length(seqs)
    @test pseqs isa Array
    @test axes(pseqs) == (1:nbases, 1:n, 1:nframes)
end

@testset "movie_capture opt_md" begin
    showtestset()

    target_dbn = "(((...)))"
    (; final_seq, seqs, pseqs) = movie_capture(opt_md, target_dbn)
    test_movie_out(target_dbn, final_seq, seqs, pseqs)

    for target_dbn in ["(((...)))", "(((((...))).(...)))"]
        for verbose in (true, false)
            (; final_seq, seqs, pseqs) = movie_capture(opt_md, target_dbn; verbose)
            test_movie_out(target_dbn, final_seq, seqs, pseqs)
        end
    end

    # seq_constraints_hard
    target_dbn = "(((...)))"
    (; final_seq, seqs, pseqs) = movie_capture(opt_md, target_dbn; seq_constraints_hard="CNNAUANNG")
    test_movie_out(target_dbn, final_seq, seqs, pseqs)

    for (target_dbn, seq_constraints_hard) in [
        ("(((...)))",
         "UACUNGNNN"),
        ("(((((...))).(...)))",
         "GNNNNUNNANNNCNCNNNN")
        ]
        for verbose in (true, false)
            (; final_seq, seqs, pseqs) = movie_capture(opt_md, target_dbn; verbose, seq_constraints_hard)
            test_movie_out(target_dbn, final_seq, seqs, pseqs)
        end
    end
end

@testset "movie_capture opt_sd" begin
    showtestset()
    target_dbn = "(((...)))"
    (; final_seq, seqs, pseqs) = movie_capture(opt_sd, target_dbn)
    test_movie_out(target_dbn, final_seq, seqs, pseqs)
    for target_dbn in ["(((...)))", "(((((...))).(...)))"]
        for verbose in (true, false)
            (; final_seq, seqs, pseqs) = movie_capture(opt_sd, target_dbn; verbose)
            test_movie_out(target_dbn, final_seq, seqs, pseqs)
        end
    end
end
