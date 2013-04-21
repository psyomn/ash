TEXER=pdflatex
BIBC=bibtex
TARGET=axios.pdf
SUBMIT_DIR=to_submit
SRCp1=/home/psyomn/Programming/java/NetBeansProjects/ass1-part1
THISDIR=$(pwd)

all:
	$(TEXER) core.tex && mv core.pdf $(TARGET)
	$(BIBC) core
	$(TEXER) core.tex && mv core.pdf $(TARGET)

double: 
	$(TEXER) core.tex && mv core.pdf $(TARGET)
	$(BIBC) core
	$(TEXER) core.tex && mv core.pdf $(TARGET)
	$(BIBC) core

clean:
	rm -f *.log *.aux *.pdf *.toc *.blg *.lof
