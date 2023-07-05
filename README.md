# DssOpt.jl

Julia interface to [dss-opt](https://github.com/marcom/dss-opt) RNA
sequence design programs.

## Installation

```julia
using Pkg
pkg"add https://github.com/marcom/DssOpt_jll.jl"
pkg"add https://github.com/marcom/DssOpt.jl"
```

## Usage

```julia
using DssOpt

# dynamics in sequence space optimisation with dynamical simulated
# annealing

opt_md("(((...)))")
opt_md("(((...)))"; verbose=true)


# steepest descent optimisiation

opt_sd("(((...)))")
opt_sd_gsl("(((...)))")
```

## References

Matthies, Bienert, Torda. Dynamics in sequence space for RNA secondary
structure design, JCTC, 3663 -- 3670, 2012.
https://doi.org/10.1021/ct300267j
