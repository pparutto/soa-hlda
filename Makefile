all:
	latexmk --pdf hlda.tex

clean:
	latexmk -c hlda.tex
