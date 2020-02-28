module WFC

struct Input{T,R,A<:AbstractArray} <: AbstractArray{T,R}
    x::A
    n::NTuple{R,Int}
end

axislength(ζ::Input, a::Integer) = max(1, size(ζ.x, a) - ζ.n[a] + 1)

Base.size(ζ::Input) = ntuple(n -> axislength(ζ, n), ndims(ζ))

indexrange(ζ::Input, a::Integer, i::Integer) = i:(i + ζ.n[a] - 1)

# TODO have to get rid of splatting at least in low rank cases
function Base.getindex(ζ::Input, I::Vararg{Int, N}) where {N}
    getindex(ζ.x, (indexrange(ζ, a, i) for (a, i) ∈ enumerate(I))...)
end


struct Output{T,Ro,A<:AbstractArray,I<:Input} <: AbstractArray{T,Ro}
    ζ::I
    y::A  # first index will be new index
end

function Output(n::Tuple, ζ::Input, ::Type{T}=Bool) where {T}
    dims = tuple(size(ζ)..., n...)
    y = ones(T, dims)
    Output{T,length(n),typeof(y),typeof(ζ)}(ζ, y)
end

Base.size(η::Output) = ntuple(i -> size(η.y, i+ndims(η.ζ)), ndims(η))

# TODO again, probably ridiculously inefficient, but for now...
function Base.getindex(η::Output, I::Vararg{Int,N}) where {N}
    getindex(η.y, ntuple(i -> Colon(), ndims(η.ζ))..., I...)
end
Base.IndexStyle(::Output) = IndexCartesian()


end
