all: debug
remake: clean debug

debug:
	gnatmake -P ash.gpr -Xmode=debug -p

release:
	gnatmake -P ash.gpr -Xmode=release -p

clean:
	rm -rf obj/*
