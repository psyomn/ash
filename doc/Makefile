TEXER=pdflatex
BIBC=bibtex
TARGET=axios.pdf

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
	rm -f *.log *.aux *.pdf *.toc *.blg *.lof *.lol *.lot *.bbl
