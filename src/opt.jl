# call the sequence optimisation functions `run_md`, `run_sd`

export opt_md, opt_sd

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
                seq_constraints_hard::Union{AbstractString,Nothing} = nothing,
                seed::Union{Integer,Nothing} = nothing,
                time_total::Real = 50.0,
                time_print::Real = 2.5,
                time_cool::Real = 0.1 * time_total,
                time_pur::Real = 0.8 * time_total,
                timestep::Real = 0.0015,
                T_start::Real = 40.0,
                # kpi = 50.0,
                # kpa = 50.0,
                # kneg = 50.0,
                # khet = 50.0,
                # het_window = 3,
                # kpur_end = 20.0,
                do_exp_cool::Bool = false,
                do_movie_output::Bool = false,
                verbose::Bool = false)

    nsteps = Cuint(round(time_total / timestep))
    nprint = Cuint(round(time_print / timestep))
    ncool  = Cuint(round(time_cool  / timestep))
    npur   = Cuint(round(time_pur   / timestep))

    c_seq_constraints_hard = if seq_constraints_hard === nothing
        Ptr{UInt8}(C_NULL)
    else
        if length(seq_constraints_hard) != length(target_dbn)
            throw(ArgumentError("target_dbn and seq_constraints_hard must have same length"))
        end
        pointer(seq_constraints_hard)::Ptr{UInt8}
    end

    c_seed = if seed === nothing
        LibDssOpt.random_get_seedval_from_current_time()
    else
        c_seed = Cuint(seed % Cuint)
    end
    LibDssOpt.random_seed(c_seed)

    kpi        = Ref(Cdouble(0.0))
    kpa        = Ref(Cdouble(0.0))
    kneg       = Ref(Cdouble(0.0))
    kpur_end   = Ref(Cdouble(0.0))
    khet       = Ref(Cdouble(0.0))
    het_window = Ref(Cuint(0))
    LibDssOpt.set_dss_force_constants_defaults(kpi, kpa, kneg, kpur_end, khet, het_window)

    vienna = target_dbn
    c_designed_seq = Ptr{Ptr{UInt8}}(Libc.malloc(length(vienna) + 1))
    ret = Int(GC.@preserve c_designed_seq seq_constraints_hard LibDssOpt.run_md(
        vienna, c_seq_constraints_hard, nsteps, nprint, ncool, npur,
        timestep, T_start, kpi[], kpa[], kneg[], khet[], het_window[], kpur_end[],
        do_exp_cool, do_movie_output, verbose, c_designed_seq
    ))
    if ret != 0
        error("optimisation unstable, decrease timestep and/or increase force constants")
    end
    designed_seq = unsafe_string(unsafe_load(c_designed_seq))
    Libc.free(c_designed_seq)
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
                maxsteps::Integer = 20000,
                nprint::Integer = 1000,
                wiggle::Real = 0.1,
                # kpi = 50.0,
                # kpa = 50.0,
                # kneg = 50.0,
                # khet = 50.0,
                # het_window = 3,
                # kpur = 20.0,
                do_movie_output::Bool = false,
                verbose::Bool = false)

    kpi        = Ref(Cdouble(0.0))
    kpa        = Ref(Cdouble(0.0))
    kneg       = Ref(Cdouble(0.0))
    kpur       = Ref(Cdouble(0.0))
    khet       = Ref(Cdouble(0.0))
    het_window = Ref(Cuint(0))
    LibDssOpt.set_dss_force_constants_defaults(kpi, kpa, kneg, kpur, khet, het_window)

    c_seed = if seed === nothing
        LibDssOpt.random_get_seedval_from_current_time()
    else
        c_seed = Cuint(seed % Cuint)
    end
    LibDssOpt.random_seed(c_seed)

    vienna = target_dbn
    c_designed_seq = Ptr{Ptr{UInt8}}(Libc.malloc(length(vienna) + 1))
    ret = Int(GC.@preserve c_designed_seq LibDssOpt.run_sd(
        vienna, maxsteps, nprint, wiggle, kpi[], kpa[], kpur[],
        kneg[], khet[], het_window[], do_movie_output, verbose,
        c_designed_seq
    ))
    if ret != 0
        error("optimisation unstable, decrease timestep and/or increase force constants")
    end
    designed_seq = unsafe_string(unsafe_load(c_designed_seq))
    Libc.free(c_designed_seq)
    return designed_seq
end
