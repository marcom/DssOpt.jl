# run executable programs: opt-md, opt-sd, opt-sd-gsl

export exe_opt_md, exe_opt_sd, exe_opt_sd_gsl

_splitlines(str) = readlines(IOBuffer(str))

function exe_opt_md(target::AbstractString;
                    verbose::Bool=false,
                    seq_constraints_hard::Union{Nothing,AbstractString}=nothing,
                    timestep::Union{Nothing,Real}=nothing,
                    start_temperature::Union{Nothing,Real}=nothing,
                    time_total::Union{Nothing,Real}=nothing,
                    time_cool::Union{Nothing,Real}=nothing,
                    kpi::Union{Nothing,Real}=nothing,
                    kpa::Union{Nothing,Real}=nothing,
                    kneg::Union{Nothing,Real}=nothing,
                    khet::Union{Nothing,Real}=nothing,
                    het_window::Union{Nothing,Integer}=nothing,
                    cooling_type::Union{Nothing,Symbol}=nothing,
                    time_pur::Union{Nothing,Real}=nothing,
                    kpur_end::Union{Nothing,Real}=nothing,
                    seed::Union{Nothing,Integer}=nothing)
    # unsupported command-line arguments:
    # --time-print
    # --movie
    isempty(target) && return ""
    cmd = `$(DssOpt_jll.opt_md())`
    !isnothing(seq_constraints_hard) && (cmd = `$cmd --seq-constraints-hard $seq_constraints_hard`)
    !isnothing(timestep) && (cmd = `$cmd --timestep $(float(timestep))`)
    !isnothing(start_temperature) && (cmd = `$cmd --T-start $(float(start_temperature))`)
    !isnothing(time_total) && (cmd = `$cmd --time-total $(float(time_total))`)
    !isnothing(time_cool) && (cmd = `$cmd --time-cool $(float(time_cool))`)
    !isnothing(kpi) && (cmd = `$cmd --kpi $(float(kpi))`)
    !isnothing(kpa) && (cmd = `$cmd --kpa $(float(kpa))`)
    !isnothing(kneg) && (cmd = `$cmd --kneg $(float(kneg))`)
    !isnothing(khet) && (cmd = `$cmd --khet $(float(khet))`)
    !isnothing(het_window) && (cmd = `$cmd --het-window $(Int(het_window))`)
    if !isnothing(cooling_type)
        if cooling_type ∈ (:linear, :exponential)
            cmd = `$cmd --cooling-type $cooling_type`
        else
            throw(ArgumentError("cooling_type has to be one of: (:linear, :exponential)"))
        end
    end
    !isnothing(time_pur) && (cmd = `$cmd --time-pur $(float(time_pur))`)
    !isnothing(kpur_end) && (cmd = `$cmd --kpur-end $(float(kpur_end))`)
    !isnothing(seed) && (cmd = `$cmd --seed $(Int(seed))`)
    cmd = `$cmd $target`

    outbuf = IOBuffer()
    errbuf = IOBuffer()
    r = run(pipeline(ignorestatus(cmd); stdin=devnull, stdout=outbuf, stderr=errbuf))
    out = String(take!(outbuf))
    err = String(take!(errbuf))
    if r.exitcode != 0
        error("while running opt-md command\n" * out * err)
    end
    if verbose
        println(out)
        println(err)
    end
    lastline = _splitlines(out)[end]
    seq = split(lastline, "=")[end] |> strip |> String
    return seq
end

exe_opt_sd(target; kwargs...) = _exe_opt_sd(DssOpt_jll.opt_sd(), target; kwargs...)

exe_opt_sd_gsl(target; kwargs...) = _exe_opt_sd(DssOpt_jll.opt_sd_gsl(), target; kwargs...)

function _exe_opt_sd(program,
                     target::AbstractString;
                     verbose::Bool=false,
                     maxsteps::Union{Nothing,Integer}=nothing,
                     kpi::Union{Nothing,Real}=nothing,
                     kpa::Union{Nothing,Real}=nothing,
                     kneg::Union{Nothing,Real}=nothing,
                     kpur::Union{Nothing,Real}=nothing,
                     khet::Union{Nothing,Real}=nothing,
                     het_window::Union{Nothing,Integer}=nothing,
                     wiggle::Union{Nothing,Real}=nothing,
                     seed::Union{Nothing,Integer}=nothing)
    # unsupported command-line arguments:
    # --nprint
    # --movie
    isempty(target) && return ""
    cmd = `$program`
    !isnothing(maxsteps) && (cmd = `$cmd --maxsteps $(Int(maxsteps))`)
    !isnothing(kpi) && (cmd = `$cmd --kpi $(float(kpi))`)
    !isnothing(kpa) && (cmd = `$cmd --kpa $(float(kpa))`)
    !isnothing(kneg) && (cmd = `$cmd --kneg $(float(kneg))`)
    !isnothing(kpur) && (cmd = `$cmd --kpur $(float(kpur))`)
    !isnothing(khet) && (cmd = `$cmd --khet $(float(khet))`)
    !isnothing(het_window) && (cmd = `$cmd --het-window $(Int(het_window))`)
    !isnothing(wiggle) && (cmd = `$cmd --wiggle $(float(wiggle))`)
    !isnothing(seed) && (cmd = `$cmd --seed $(Int(seed))`)
    cmd = `$cmd $target`

    outbuf = IOBuffer()
    errbuf = IOBuffer()
    r = run(pipeline(ignorestatus(cmd); stdin=devnull, stdout=outbuf, stderr=errbuf))
    out = String(take!(outbuf))
    err = String(take!(errbuf))
    if r.exitcode != 0
        error("while running command\n" * out * err)
    end
    if verbose
        println(out)
        println(err)
    end
    lastline = _splitlines(out)[end]
    seq = split(lastline, "=")[end] |> strip |> String
    return seq
end
