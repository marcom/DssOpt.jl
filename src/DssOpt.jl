module DssOpt

import DssOpt_jll

# generated C bidings for libdssopt from DssOpt_jll
# see src/gen/generator.jl
include("../lib/LibDssOpt.jl")
import .LibDssOpt

export opt_md

function opt_md(target::AbstractString)
    cmd = `$(DssOpt_jll.opt_md()) $target`
    out = read(cmd, String)
    seq = split(out, "\n")[end-1] |> s -> split(s, "=")[end] |> lstrip |> String
    return seq
end

end
