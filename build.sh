# Compile the markdown to a pdf

STYLE=tango
DOT_FONT=Helvetica
# In the case where we include code, we have nice syntax highlighting.

build_image () {
	dot -Tpng $1.dot -Gfontname=$DOT_FONT -Nfontname=$DOT_FONT -Efontname=$DOT_FONT -o $1.png
	convert $1.png -fuzz 1% -transparent white $1.png
}

build_image newplan
build_image database
build_image organisation
build_image compilation

pandoc \
	--bibliography=biblio.bib\
	--number-sections\
	--from=markdown+grid_tables+pipe_tables\
	--template=./template.tex\
	--toc\
	--variable urlcolor=blue\
	--metadata link-citations=true\
	--highlight-style=$STYLE\
        report.md\
        -s -o report.tex

pdflatex report.tex -o report.pdf
makeglossaries report
pdflatex report.tex -o report.pdf
