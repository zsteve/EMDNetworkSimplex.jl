emd: EMD_wrapper.cpp EMD.h full_bipartitegraph.h network_simplex_simple.h
	g++ -shared -fPIC -std=c++11 -Ofast -march=native -fno-signed-zeros -fno-trapping-math -fopenmp -openmp -frename-registers -funroll-loops EMD_wrapper.cpp -o libemd.so
#g++ -std=c++11 -Ofast -march=native -fno-signed-zeros -fno-trapping-math -fopenmp -frename-registers -funroll-loops -D_GLIBCXX_PARALLEL EMD_wrapper.cpp
