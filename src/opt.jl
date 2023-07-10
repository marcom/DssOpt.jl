# call the sequence optimisation functions `run_md`, `run_sd`

export opt_md, opt_sd, movie_capture

using DssOpt.LibDssOpt: C_EXIT_SUCCESS
import IOCapture

function isok_seq_constraints_hard(seq_constraints_hard::AbstractString, target_dbn::AbstractString)
    nseq = length(seq_constraints_hard)
    ndbn = length(target_dbn)
    if nseq != ndbn
        throw(ArgumentError("seq_constraints_hard and target_dbn must have same length, $nseq != $ndbn"))
    end
    n = nseq
    # create pairs
    pairs = zeros(Cuint, n)
    verbose_v2p = true
    retcode_v2p = LibDssOpt.vienna_to_pairs(n, target_dbn, verbose_v2p, pairs)
    if retcode_v2p != C_EXIT_SUCCESS
        throw(ArgumentError("not a well formed secondary structure: $target_dbn"))
    end
    # now try to parse seq_constraints_hard
    hard = zeros(Cuint, n)
    n_hard = Ref(Cuint(0))
    constraint_str = seq_constraints_hard
    verbose = true
    retcode = LibDssOpt.parse_seq_constraints_hard(n, hard, n_hard, constraint_str, verbose, pairs)
    if retcode == C_EXIT_SUCCESS
        return true
    end
    return false
end

"""
    opt_md(target_dbn; kwargs...) -> String

Perform RNA sequence optimisation for a target structure `target_dbn`
given in dot-bracket notation.

The sequence optimisation is performed by optimising a base
composition at each position of the sequence with a differentiable
design score function.  The gradients with respect to sequence
composition are used to perform dynamical simulated annealing in
sequence space, i.e. the gradients are used to compute forces in
sequence space, and the resulting equations of (sequence) motion are
numerically integrated.  The sequence velocities are coupled by a
thermostat to a heat bath which is slowly cooled, yielding physically
realisable sequence compositions (one component is 100%, and all
others are at 0%) at the end of the optimisation.

Keyword arguments:

- `seed`: seed value for random number generator, uses current time if unset
- `seq_constraints_hard`: hard sequence constraints for the designed sequence
- `time_total`: the total time
- `time_print`: time between printing in verbose mode
- `time_cool`: time at which the cooling process starts
- `time_pur`: time from when purification terms are turned on
- `T_start`: sequence temperature at the beginning of the optimisation
- `do_exp_cool`: do exponential cooling, otherwise linear cooling is used
- `verbose`: verbose output

Examples
--------
```julia
opt_md("(((...)))")
opt_md("(((...)))"; seq_constraints_hard="GNNUNNNNC")
```
"""
function opt_md(target_dbn::AbstractString;
                seed::Union{Integer,Nothing} = nothing,
                seq_constraints_hard::Union{AbstractString,Nothing} = nothing,
                time_total::Real = 50.0,
                time_print::Real = 2.5,
                time_cool::Real = 0.1 * time_total,
                time_pur::Real = 0.8 * time_total,
                timestep::Real = 0.0015,
                T_start::Real = 40.0,
                kpi::Real = LibDssOpt.DEFAULT_DSSOPT_kpi,
                kpa::Real = LibDssOpt.DEFAULT_DSSOPT_kpa,
                kneg::Real = LibDssOpt.DEFAULT_DSSOPT_kneg,
                khet::Real = LibDssOpt.DEFAULT_DSSOPT_khet,
                het_window::Integer = LibDssOpt.DEFAULT_DSSOPT_het_window,
                kpur_end::Real = LibDssOpt.DEFAULT_DSSOPT_kpur,
                do_exp_cool::Bool = false,
                do_movie_output::Bool = false,
                verbose::Bool = false)

    # TODO: check that any time_* == 0 makes sense
    time_total >= 0 || throw(ArgumentError("time_total must be >= 0"))
    time_print >= 0 || throw(ArgumentError("time_print must be >= 0"))
    time_cool >= 0 || throw(ArgumentError("time_cool must be >= 0"))
    time_pur >= 0 || throw(ArgumentError("time_pur must be >= 0"))
    # TODO: check that het_window == 0 makes sense
    het_window >= 0 || throw(ArgumentError("het_window must be >= 0"))

    nsteps = Cuint(round(time_total / timestep))
    nprint = Cuint(round(time_print / timestep))
    ncool  = Cuint(round(time_cool  / timestep))
    npur   = Cuint(round(time_pur   / timestep))

    c_seq_constraints_hard = if seq_constraints_hard === nothing
        Ptr{UInt8}(C_NULL)
    else
        if !isok_seq_constraints_hard(seq_constraints_hard, target_dbn)
            throw(ArgumentError("Illegal seq_constraints_hard: $seq_constraints_hard"))
        end
        pointer(seq_constraints_hard)::Ptr{UInt8}
    end

    c_seed = if seed === nothing
        LibDssOpt.random_get_seedval_from_current_time()
    else
        c_seed = Cuint(seed % Cuint)
    end
    LibDssOpt.random_seed(c_seed)
    if verbose
        println("seed = ", c_seed)
    end

    vienna = target_dbn
    c_designed_seq = [zeros(UInt8, length(vienna) + 1)]
    ret = Int(GC.@preserve c_designed_seq seq_constraints_hard LibDssOpt.run_md(
        vienna, c_seq_constraints_hard, nsteps, nprint, ncool, npur,
        timestep, T_start, kpi[], kpa[], kneg[], khet[], het_window[], kpur_end[],
        do_exp_cool, do_movie_output, verbose, c_designed_seq
    ))
    if ret != 0
        error("optimisation unstable, decrease timestep and/or increase force constants")
    end
    designed_seq = String(c_designed_seq[1][1:length(vienna)])
    return designed_seq
end


"""
    opt_sd(target_dbn; kwargs...) -> String

Perform RNA sequence optimisation for a target structure `target_dbn`
given in dot-bracket notation.

The sequence optimisation is performed by optimising a base
composition at each position of the sequence with a differentiable
design score function.  The sequence compositions are optimised via
steepest descent on the design score function.

Keyword arguments:

- `seed`: seed value for random number generator, uses current time if unset
- `maxsteps`: maximum number of gradient steps
- `nprint`: interval to print details in verbose mode
- `wiggle`: scaling factor for random perturbation to starting sequence composition (all bases 25%)
- `verbose`: verbose output

Example
-------
```julia
opt_sd("(((...)))")
```
"""
function opt_sd(target_dbn::AbstractString;
                seed::Union{Integer,Nothing} = nothing,
                # TODO: defaults for maxsteps, nprint, wiggle taken
                #       from dss-opt/main-opt-sd.c
                maxsteps::Integer = 20000,
                nprint::Integer = 1000,
                wiggle::Real = 0.1,
                kpi::Real = LibDssOpt.DEFAULT_DSSOPT_kpi,
                kpa::Real = LibDssOpt.DEFAULT_DSSOPT_kpa,
                kneg::Real = LibDssOpt.DEFAULT_DSSOPT_kneg,
                khet::Real = LibDssOpt.DEFAULT_DSSOPT_khet,
                het_window::Integer = LibDssOpt.DEFAULT_DSSOPT_het_window,
                kpur::Real = LibDssOpt.DEFAULT_DSSOPT_kpur,
                do_movie_output::Bool = false,
                verbose::Bool = false)

    maxsteps >= 0 || throw(ArgumentError("maxsteps must be >= 0"))
    nprint >= 0 || throw(ArgumentError("nprint must be >= 0"))
    # TODO: check that het_window == 0 makes sense
    het_window >= 0 || throw(ArgumentError("het_window must be >= 0"))

    c_seed = if seed === nothing
        LibDssOpt.random_get_seedval_from_current_time()
    else
        c_seed = Cuint(seed % Cuint)
    end
    LibDssOpt.random_seed(c_seed)
    if verbose
        println("seed = ", c_seed)
    end

    vienna = target_dbn
    c_designed_seq = [zeros(UInt8, length(vienna) + 1)]
    ret = Int(GC.@preserve c_designed_seq LibDssOpt.run_sd(
        vienna, maxsteps, nprint, wiggle, kpi[], kpa[], kpur[],
        kneg[], khet[], het_window[], do_movie_output, verbose,
        c_designed_seq
    ))
    if ret != 0
        error("optimisation unstable, decrease force constants and/or decrease stepsize")
    end
    designed_seq = String(c_designed_seq[1][1:length(vienna)])
    return designed_seq
end

"""
    movie_capture(opt_fn, target_dbn, args...; verbose, kwargs...) -> (; final_seq, seqs, pseqs)

Capture "movie output" of optimisation function `opt_fn` for target
secondary structure `target_dbn`.

Examples
--------
```julia
movie_capture(opt_md, "(((...)))"; seq_constraints_hard="NNGUUUUNN")
movie_capture(opt_sd, "(((...)))")
```
"""
function movie_capture(opt_fn, target_dbn, args...; verbose::Bool=false, kwargs...)
    function process_out(movie_output::AbstractString)
        lines = readlines(IOBuffer(movie_output))
        if length(lines) < 2
            error("Movie output too short, only $(length(lines)) lines. " *
                  "Movie output:\n$movie_output")
        end
        n = length(target_dbn)
        nbases = length(split(lines[2]))
        nlines = length(lines)
        # each frame has
        # - a line with the sequence (choosing max prob at each site)
        # - `n` lines, on each line the probabilities at this site
        #   (e.g. 4 probabilities for A, C, G, U) separated by spaces
        nlines_per_frame = n + 1
        if nlines % nlines_per_frame != 0
            println(movie_output)
            error("Movie output has wrong length. " *
                "Got $nlines of output, expecting $nlines_per_frame lines per frame")
        end
        nframes = Int(nlines / nlines_per_frame)
        seqs = String[]
        pseqs = zeros(nbases, n, nframes)
        # k: frame number
        # i: line number
        for k_frame = 1:nframes
            i = (k_frame - 1) * nlines_per_frame + 1
            i_end = i + nlines_per_frame - 1
            push!(seqs, lines[i])
            seqpos = 1
            for j = i+1:i_end
                pseqs[:, seqpos, k_frame] .= parse.(Float64, split(lines[j]))
                seqpos += 1
            end
        end
        return seqs, pseqs
    end
    if length(target_dbn) == 0
        throw(ArgumentError("target_dbn is empty"))
    end
    cap = IOCapture.capture() do
        ret = opt_fn(target_dbn, args...; do_movie_output=true, verbose, kwargs...)
        Libc.flush_cstdio()  # otherwise output is lost
        ret
    end
    final_seq = cap.value::String
    out = cap.output::String
    # movie output is between START and END markers in verbose mode,
    # otherwise all output is movie output
    if verbose
        regex = r"START\n(.*)END\n"s
        m = match(regex, out)
        if m != nothing
            out = m.captures[1]
        else
            error("Could not find movie output")
        end
    end
    seqs, pseqs = process_out(out)
    return (; final_seq, seqs, pseqs)
end
