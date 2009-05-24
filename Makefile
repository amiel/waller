
TEXFILE = waller

LYB = /Applications/LilyPond.app/Contents/Resources/bin/lilypond-book

.PHONY: all clean lily-book

all: ${TEXFILE}

${TEXFILE}: lily-book
	@echo $<
	@echo $@
	pdflatex ${TEXFILE}
	@if ( egrep "No file.*\.bbl|Citation.*undefined"	\
			${TEXFILE}.log > /dev/null ); then		\
				bibtex ${TEXFILE}; \
	fi; true
	@while ( grep "Rerun to get cross-references" 	\
			${TEXFILE}.log > /dev/null ); do		\
		echo '** Re-running LaTeX **';		\
		pdflatex ${TEXFILE};				\
	done


lily-book: clean-junk
	if [ -f ${TEXFILE}.lilytex ]; then \
		${LYB} ${TEXFILE}.lilytex -f latex --pdf; \
	fi

clean-junk:
	rm -rf [a-zA-Z0-9][a-zA-Z0-9]
	rm -f *.log
	rm -f *.aux
	rm -f *.url
	rm -f ${TEXFILE}.dep
	rm -f snippet-{map,names}-*.ly
	rm -f tmp*-blx.bib

clean: clean-junk
	rm -f *.bbl
	rm -f *-blx.bib
	rm -f ${TEXFILE}.pdf

