import Aqua
using DssOpt

@testset "Aqua.test_all" begin
    showtestset()
    Aqua.test_all(DssOpt)
end
