# call the optimisation functions `run_md`, `run_sd`

export opt_md

# TODO
# - seq_constraints_hard
# - set force constants
#    kpi = kpa = kneg = kpur_end = khet = Cdouble(0.0)
#    het_window = Cuint(0)
#    set_dss_force_constants_defaults(kpi, kpa, kneg, kpur_end, khet, het_window)
function opt_md(target_dbn::AbstractString;
                seq_constraints_hard::Union{AbstractString,Nothing} = nothing,
                # nsteps = 100,
                # nprint = 10,
                # ncool = 50,
                # npur = 100,
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

    kpi        = Ref(Cdouble(0.0))
    kpa        = Ref(Cdouble(0.0))
    kneg       = Ref(Cdouble(0.0))
    kpur_end   = Ref(Cdouble(0.0))
    khet       = Ref(Cdouble(0.0))
    het_window = Ref(Cuint(0))
    LibDssOpt.set_dss_force_constants_defaults(kpi, kpa, kneg, kpur_end, khet, het_window)

    vienna = target_dbn
    c_designed_seq = Ptr{Ptr{UInt8}}(Libc.malloc(length(vienna) + 1))
    ret = Int(GC.@preserve seq_constraints_hard LibDssOpt.run_md(
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

