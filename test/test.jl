using Random
using Distances
import ExactOptimalTransport
import PythonOT 
using LinearAlgebra
using EMD 
using Tulip

M, N = 250, 100
a = normalize(rand(M), 1)
a_spt = randn(M, 3)
b = normalize(rand(N), 1)
b_spt = randn(N, 3)
C = pairwise(SqEuclidean(), a_spt', b_spt')

u, v, coupling, cost, result_code = emd_c(a, b, C)
@info EMD.result_code_msg[result_code] 

# do the same calculation using the PythonOT wrapper (this ends up calling the same C++ code...)
coupling_pot = PythonOT.emd(a, b, C)
isapprox(norm(coupling_pot - coupling, Inf), 0; atol = 1e-9)

# now try again using ExactOptimalTransport + Tulip (interior point solver)
coupling_tulip = ExactOptimalTransport.emd(a, b, C, Tulip.Optimizer())
isapprox(norm(coupling_tulip - coupling, Inf), 0; atol = 1e-6)

# emd and emd2
isapprox(sum(C.*emd(a, b, C)), emd2(a, b, C); atol = 1e-6)
