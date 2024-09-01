#-----------------------------------------------------
# Some usefull instructions...
#
DIAGRAMS        = images/*.svg  
DEP				= *.adoc 
ADOC			= asciidoctor -r asciidoctor-diagram
#-----------------------------------------------------

images/%.png: images/%.plantuml
	@echo '==> Compiling plantUML files to generate PNG'
	java -jar plantuml.jar $<

images/%.svg: images/%.plantuml
	@echo '==> Compiling plantUML files to generate SVG'
	java -jar plantuml.jar -tsvg $<

%.html: %.adoc
	@echo "========================================"
	@echo "==> Compiling asciidoc files "
	$(ADOC) $< > $@

clean:
	rm *.html

# in case of "error: RPC failed; HTTP 400 curl 22 The requested URL returned error: 400"
debug:
	git config http.postBuffer 524288000
	git pull && pit push

deploy: index.html
	@echo "========================================"
	@echo "==> Deploy updates "
	git commit -am "🤖 DEPLOY: last updates"; git pull; git push