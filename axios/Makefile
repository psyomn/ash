all: debug
remake: clean debug

debug:
	gnatmake -P axios.gpr -Xmode=debug -p

release:
	gnatmake -P axios.gpr -Xmode=release -p

clean:
	rm -rf obj/*
