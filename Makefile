## Markdown extension (e.g. md, markdown, mdown).
MEXT = Rmd

## All markdown files in the working directory
SRC = $(wildcard *.$(MEXT))
## SRC = article.md
TEX=$(SRC:.Rmd=.tex)
PDFS=$(SRC:.Rmd=.pdf)
DOCX=$(SRC:.Rmd=.docx)


all:	$(PDFS) $(DOCX)

pdf:	$(PDFS)
docx:	$(DOCX)
tex:	$(TEX)

%.pdf:	%.Rmd
	Rscript -e "library(knitr);latexOutput<-TRUE;knit('$<')"
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block -s -S --filter pandoc-citeproc --latex-engine=xelatex --template=latex.template -o $@ $(subst Rmd,md,$<)

%.docx:	%.Rmd
	Rscript -e "library(knitr);latexOutput<-FALSE;knit('$<')"
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block -s -S --filter pandoc-citeproc --template=latex.template -o $@ $(subst Rmd,md,$<)

%.tex:	%.Rmd
	Rscript -e "library(knitr);latexOutput<-TRUE;knit('$<')"
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block -s -S --filter pandoc-citeproc --template=latex.template -o $@ $(subst Rmd,md,$<)

### Check linting
### %.lint: 
