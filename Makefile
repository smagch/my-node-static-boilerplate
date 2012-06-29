JADE_BIN = ./node_modules/jade/bin/jade
JADE = $(filter-out ./views/base/index.jade, $(wildcard \
         ./views/index.jade \
         ./views/**/index.jade) \
       )
HTML = $(JADE:.jade=.html)
HTML_DEST = $(patsubst ./views/%,./public/%, $(HTML))

STYLUS = $(shell find ./stylesheets/*.styl)
CSS = $(STYLUS:.styl=.css)
CSS_DEST = $(subst stylesheets/,public/stylesheets/, $(CSS))
STYLUS_LIB = ./node_modules/nib/lib/nib.js
STYLUS_BIN = ./node_modules/stylus/bin/stylus

all: $(HTML) $(CSS)

%.html: %.jade
	$(JADE_BIN) $<
	@mkdir -p $(dir $(HTML_DEST))
	@cp $@ $(patsubst views/%,public/%, $@)

%.css: %.styl
	$(STYLUS_BIN) $< --use $(STYLUS_LIB) --compress
	@mkdir -p $(dir $(CSS_DEST))
	@cp $@ $(subst stylesheets/,public/stylesheets/, $@)

clean:
	@rm -f $(HTML) $(HTML_DEST) $(CSS) $(CSS_DEST)

.PHONY: clean
