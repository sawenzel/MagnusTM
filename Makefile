# Makefile für die Maturaarbeit von Magnus
# Hauptdokument: main.tex (pdflatex + bibtex)

MAIN    := main
TEX     := pdflatex
BIB     := bibtex
TEXFLAGS:= -interaction=nonstopmode -halt-on-error -file-line-error

PDF     := $(MAIN).pdf
SOURCES := $(MAIN).tex
BIBFILE := Sandberg_COD_2025.bib

.PHONY: all clean cleanall view

# Standardziel: PDF bauen
all: $(PDF)

# Vollständiger Lauf: pdflatex -> bibtex -> pdflatex -> pdflatex
# (zweifacher Schlusslauf für Referenzen, Bibliographie und TikZ/pgfplots)
$(PDF): $(SOURCES) $(BIBFILE)
	$(TEX) $(TEXFLAGS) $(MAIN)
	$(BIB) $(MAIN)
	$(TEX) $(TEXFLAGS) $(MAIN)
	$(TEX) $(TEXFLAGS) $(MAIN)

# Schneller Lauf ohne Bibliographie (nur ein Durchgang)
quick:
	$(TEX) $(TEXFLAGS) $(MAIN)

# PDF anzeigen
view: $(PDF)
	xdg-open $(PDF) >/dev/null 2>&1 &

# Hilfsdateien löschen, PDF behalten
clean:
	rm -f $(MAIN).aux $(MAIN).log $(MAIN).out $(MAIN).toc \
	      $(MAIN).bbl $(MAIN).blg $(MAIN).lof $(MAIN).lot \
	      $(MAIN).fls $(MAIN).fdb_latexmk $(MAIN).synctex.gz \
	      $(MAIN).auxlock *.aux

# Alles löschen, auch das PDF
cleanall: clean
	rm -f $(PDF)
