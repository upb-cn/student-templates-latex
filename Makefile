LATEXMK = latexmk -pdf -interaction=nonstopmode -halt-on-error

.PHONY: all seminar report review thesis thesis-proposal clean

all: seminar thesis thesis-proposal

seminar: report review

report:
	cd seminar && $(LATEXMK) report.tex

review:
	cd seminar && $(LATEXMK) review.tex

thesis:
	cd thesis && $(LATEXMK) thesis.tex

thesis-proposal:
	cd thesis-proposal && $(LATEXMK) thesis-proposal.tex

clean:
	cd seminar && latexmk -C -bibtex report.tex review.tex
	cd thesis && latexmk -C -bibtex thesis.tex
	cd thesis-proposal && latexmk -C -bibtex thesis-proposal.tex
