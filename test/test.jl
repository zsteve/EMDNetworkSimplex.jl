using Random
using Distances
using ExactOptimalTransport
using PythonOT 
using LinearAlgebra

M, N = 250, 100
a = normalize(rand(M), 1)
a_spt = randn(M, 3)
b = normalize(rand(N), 1)
b_spt = randn(N, 3)

C = convert(Array{Float64}, pairwise(SqEuclidean(), a_spt', b_spt'))

result_code_msg = ["INFEASIBLE", "OPTIMAL", "UNBOUNDED", "MAX_ITER_REACHED"] 

function emd_c(a::Vector{Float64}, b::Vector{Float64}, C::Matrix{Float64}, maxiter::Int = 100_000)
    T=eltype(C)
    coupling = similar(C)
    fill!(coupling, zero(T))
    # dual potentials 
    u = similar(a)
    fill!(u, zero(T))
    v = similar(b)
    fill!(v, zero(T))
    # problem sizes 
    na, nb = length(a), length(b)
    cost = zeros(T, 1)
    # swap (a,b) since C code assumes row-major 
    result_code=ccall((:EMD_wrap,"libemd"), Int64,
                                  (Int64, Int64, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, UInt64), 
                                  nb, na, b, a, C, coupling, v, u, cost, maxiter)
    return u, v, coupling, cost, result_code+1
end

u, v, coupling, cost, result_code = emd_c(a, b, C)
@info result_code_msg[result_code] 
coupling_pot = PythonOT.emd(a, b, C)
norm(coupling_pot - coupling, 1)

using Tulip
coupling_tulip = emd(a, b, C, Tulip.Optimizer())

sum(coupling_tulip.*C)

