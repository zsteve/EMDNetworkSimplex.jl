ifeq ($(PREFIX),)
	    PREFIX := /usr/local
endif

emd: EMD_wrapper.cpp EMD.h full_bipartitegraph.h network_simplex_simple.h
	mkdir build
	g++ -shared -fPIC -std=c++11 -O3 -fno-signed-zeros -fno-trapping-math -fopenmp -openmp -frename-registers -funroll-loops EMD_wrapper.cpp -o build/libemd.so

install: build/libemd.so
	install -d $(DESTDIR)$(PREFIX)/lib/
	install -m 644 build/libemd.so $(DESTDIR)$(PREFIX)/lib/
	install -d $(DESTDIR)$(PREFIX)/include/
	install -m 644 EMD.h $(DESTDIR)$(PREFIX)/include/

