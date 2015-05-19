{%

function extension(coffeescript) {
  if (coffeescript) return 'coffee';
  else return 'js';
}

function compilers(coffeescript) {
  if (coffeescript) return' --compilers coffee:coffee-script/register ';
  else return ' ';
}

%}TESTS = test/*.{%= extension(coffeescript) %}


test:
	@# if any of the files contain 'debugger' statements, start with --debug-brk
	@if find -name 'node_modules' -prune -o -type f -name '*.{%= extension(coffeescript) %}' -print | xargs grep -q '^\s*debugger'; then \
		./node_modules/.bin/mocha{%= compilers(coffeescript) %}--debug-brk $(TESTS); \
		else \
		./node_modules/.bin/mocha{%= compilers(coffeescript) %}$(TESTS); \
		fi


watch:
	@./node_modules/.bin/nodemon -e {%= extension(coffeescript) %} --exec 'make test'


.PHONY: test watch
