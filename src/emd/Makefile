emd: EMD_wrapper.cpp EMD.h full_bipartitegraph.h network_simplex_simple.h
	mkdir ../../bin
	g++ -shared -fPIC -std=c++11 -O3 -fno-signed-zeros -fno-trapping-math -fopenmp -openmp -frename-registers -funroll-loops EMD_wrapper.cpp -o ../../bin/libemd.so
