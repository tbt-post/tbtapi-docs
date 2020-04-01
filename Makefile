BUILD_DIR = build
DOC_DIR = adoc
SAASS = ams bms wms fms

all: acompile
        @:

acompile: clean
	@echo "-- Building docs at" ${BUILD_DIR}
	@mkdir -p ${BUILD_DIR}

	@echo "=> Compiling common API docs"
	@for doc in $(shell cd ${DOC_DIR} && ls -1 *.adoc); do \
		echo "Copiling doc:" $$doc; \
		asciidoc -b html5 -a data-uri -a icons -a toc2 -a theme=flask \
			-o ${BUILD_DIR}/common_$$doc.html ${DOC_DIR}/$$doc; \
	done

	@echo "=> Compiling SaaS specific API docs"
	@for ss in ${SAASS}; do \
		for doc in $$(cd ${DOC_DIR}/$${ss}_aaS && ls -1 *.adoc); do \
			echo "Copiling doc:" [$$ss] $$doc; \
			asciidoc -b html5 -a data-uri -a icons -a toc2 -a theme=flask \
				-o ${BUILD_DIR}/$${ss}_$$doc.html ${DOC_DIR}/$${ss}_aaS/$$doc; \
		done; \
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
