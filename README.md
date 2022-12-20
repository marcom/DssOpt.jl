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

```julia
opt_sd("(((...)))")
opt_sd_gsl("(((...)))")
```
