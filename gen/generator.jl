#!/usr/bin/env julia

import Pkg

cd(@__DIR__)
Pkg.activate(".")

# Stack environment from parent dir on top of env from this dir.  This
# is so we always use the same versions for common dependencies
pushfirst!(LOAD_PATH, joinpath(@__DIR__, ".."))
println("LOAD_PATH =")
display(LOAD_PATH)
println()

using Clang.Generators
using DssOpt_jll

cd(@__DIR__)

include_dir = normpath(DssOpt_jll.artifact_dir, "include")
dssopt_dir = include_dir

options = load_options(joinpath(@__DIR__, "generator.toml"))

args = get_default_args()
append!(args, [
    "-I$include_dir",
    "-std=c99",
])

accept_headers = [
    "ctools/dary.h",
    "ctools/libctools.h",
    "ctools/num_utils.h",
    "ctools/random.h",
    "opt.h",
    "dss.h",
    "helpers-for-main.h",
    "helpers-for-main-opt.h",
    "na.h",
    "nj_param.h",
    "nn_param.h",
    "md/md.h",
]
headers = [joinpath(dssopt_dir, header) for header in accept_headers]
# there is also an experimental `detect_headers` function for auto-detecting top-level headers in the directory
# headers = detect_headers(clang_dir, args)

# create context
ctx = create_context(headers, args, options)

# run generator
build!(ctx)
