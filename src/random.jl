export random_seq

function random_seq(dbn::AbstractString)
    # TODO: take this from a header in a future version of dss-opt
    NA_BASES = ('A', 'C', 'G', 'U')

    n = length(dbn)
    pairs = Ptr{Cuint}(Libc.malloc(n * sizeof(Cuint)))
    useq = Ptr{Cuint}(Libc.malloc(n * sizeof(Cuint)))
    LibDssOpt.xvienna_to_pairs(n, dbn, pairs)
    # TODO: next version of dss-opt this function is called random_useq
    LibDssOpt.random_seq(n, pairs, useq)
    # In the future use useq_to_str?
    aseq = Vector{Char}(undef, n)
    for i = 1:n
        b = unsafe_load(useq, i)
        b += 1 # translate from C 0:3 to Julia 1:4
        if b > length(NA_BASES)
            error("illegal base $b in useq at position $i")
        end
        aseq[i] = NA_BASES[b]
    end
    seq = join(aseq)
    Libc.free(pairs)
    Libc.free(useq)
    return seq
end
