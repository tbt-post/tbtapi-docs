BUILD_DIR = build
DOC_DIR = adoc

all: acompile
        @:

acompile: clean
	@echo "-- Building docs at" ${BUILD_DIR}
	@mkdir -p ${BUILD_DIR}
	@for doc in $(shell cd ${DOC_DIR} && ls -1 *.adoc); do \
        	echo "Copiling doc:" $$doc; \
		asciidoc -b html5 -a data-uri -a icons -a toc2 -a theme=flask -o ${BUILD_DIR}/$$doc.html ${DOC_DIR}/$$doc; \
	done

clean:
	@echo "-- Doing clean-up for the following:"

	@find . -type f \( \
	-name \*~ -o \
	-name \*.xml -o \
	-name \*.log -o \
	-name \*.o -o \
	-name \*.lo -o \
	-name \*.tmp -o \
	-name DEADJOE \) \
	-print -delete

	$(RM) -r ${BUILD_DIR}