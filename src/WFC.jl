module WFC

struct Input{T,R,A<:AbstractArray} <: AbstractArray{T,R}
    x::A
    n::NTuple{R,Int}
end

axislength(η::Input, a::Integer) = max(1, size(η.x, a) - η.n[a] + 1)

Base.size(η::Input) = ntuple(n -> axislength(η, n), ndims(η))

indexrange(η::Input, a::Integer, i::Integer) = i:(i + η.n[a] - 1)

# TODO have to get rid of splatting at least in low rank cases
function Base.getindex(η::Input, I::Vararg{Int, N}) where {N}
    getindex(η.x, (indexrange(η, a, i) for (a, i) ∈ enumerate(I))...)
end


end
