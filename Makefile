.PHONY: test doc release

SRC     := logger.bashrc
VERSION := $(shell grep LOGGER_VERSION $(SRC) | cut -f 2 -d'=' )

README.md: $(SRC)
	pod2markdown $(SRC) > README.md

test:
	shove -r t/ -v -s bash

doc: README.md

release: README.md
	git commit -m $(VERSION)
	git tag -a v$(VERSION) -m $(VERSION)
	git push origin v$(VERSION)
	git push origin master
