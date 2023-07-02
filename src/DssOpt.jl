module DssOpt

import DssOpt_jll

# generated C bidings for libdssopt from DssOpt_jll
# see gen/generator.jl
include("../lib/LibDssOpt.jl")
import .LibDssOpt

include("opt.jl")
include("exe.jl")

end # module
