ADA=gprbuild

all: debug
remake: clean debug

debug:
	$(ADA) -P ash.gpr -Xmode=debug -p

release:
	$(ADA) -P ash.gpr -Xmode=release -p

test:
	$(ADA) -P test.gpr -p
	@./bin/test/test_ash
.PHONY: test

clean:
	rm -rf obj/*
