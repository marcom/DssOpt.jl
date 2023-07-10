export random_seq

function random_seq(dbn::AbstractString; verbose_errors::Bool=true)
    n = length(dbn)
    pairs = Ptr{Cuint}(Libc.malloc(n * sizeof(Cuint)))
    useq = Ptr{Cuint}(Libc.malloc(n * sizeof(Cuint)))
    str = Ptr{Cchar}(Libc.malloc((n + 1) * sizeof(Cchar)))
    function mem_cleanup()
        Libc.free(pairs)
        Libc.free(useq)
        Libc.free(str)
    end
    # convert dbn to pair list
    retcode = LibDssOpt.vienna_to_pairs(n, dbn, verbose_errors, pairs)
    if retcode != C_EXIT_SUCCESS
        mem_cleanup()
        throw(ArgumentError("Illegal dbn: $dbn"))
    end
    # generate random seq compatible to dbn
    LibDssOpt.random_useq(n, pairs, useq)
    LibDssOpt.xuseq_to_str(n, useq, str)
    seq = unsafe_string(str)
    mem_cleanup()
    return seq
end
