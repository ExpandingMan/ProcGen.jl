using ProcGen: WFC
using Random, BenchmarkTools

using ProcGen.WFC: Input, Output

Random.seed!(999)

x = rand(0:15, 5, 6)

ζ = Input{Matrix{Int},2,typeof(x)}(x, (2,3))
η = Output((8,10), ζ)
