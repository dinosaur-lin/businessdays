.PHONY: all clean test doc

all:
	dune build @install

clean:
	dune clean

test:
	dune runtest -j1 --no-buffer

install:
	dune install

uninstall:
	dune uninstall

doc:
	dune build @doc

cleanall:
	dune uninstall && dune clean
	rm -rf `find . -name .merlin`