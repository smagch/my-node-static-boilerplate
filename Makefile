JADE_BIN = ./node_modules/jade/bin/jade
JADE = $(filter-out ./views/base/index.jade, $(wildcard \
         ./views/index.jade \
         ./views/**/index.jade) \
       )
HTML = $(JADE:.jade=.html)
HTML_DEST = $(patsubst ./views/%,./public/%, $(HTML))

STYLUS = $(shell find ./public/stylesheets/*.styl)
CSS = $(STYLUS:.styl=.css)
STYLUS_LIB = ./node_modules/nib/lib/nib.js
STYLUS_BIN = ./node_modules/stylus/bin/stylus

all: $(HTML) $(CSS)

%.html: %.jade
	$(JADE_BIN) $<
	@mkdir -p $(dir $(HTML_DEST))
	@cp $@ $(patsubst views/%,public/%, $@)

%.css: %.styl
	$(STYLUS_BIN) $< --use $(STYLUS_LIB) --compress

clean:
	rm -f $(HTML) $(HTML_DEST) $(CSS)

.PHONY: clean
