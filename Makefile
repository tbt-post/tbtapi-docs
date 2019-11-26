BUILD_DIR = build

all: acompile
        @:

acompile:
	@echo "-- Building docs at" ${BUILD_DIR}
	@mkdir -p ${BUILD_DIR}
	@for doc in $(shell ls -1 adoc/*.adoc); do \
        	echo "Copiling doc:" $$doc; \
        	asciidoc -b html5 -a data-uri -a icons -a toc2 -a theme=flask -o ${BUILD_DIR}/$$doc.html $$doc; \
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