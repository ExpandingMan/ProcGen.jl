using ProcGen: WFC

using ProcGen.WFC: Input

x = rand(0:15, 5, 6)

η = Input{Matrix{Int},2,typeof(x)}(x, (2,3))
