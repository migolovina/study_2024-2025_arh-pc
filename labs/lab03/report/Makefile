FILES = $(patsubst %.md, %.docx, $(wildcard *.md)) 
FILES += $(patsubst %.md, %.pdf, $(wildcard *.md))

LATEX_FORMAT =

FILTER = --filter pandoc-crossref

%.docx: %.md
	-pandoc "$<" $(FILTER) -o "report.docx"

%.pdf: %.md
	-pandoc "$<" $(LATEX_FORMAT) $(FILTER) -o "report.pdf"

all: $(FILES)
	@echo $(FILES)

clean:
	-rm $(FILES) report.docx
	-rm $(FILES) report.pdf
	
