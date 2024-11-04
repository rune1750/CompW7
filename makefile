# Compiler and flags
OCAMLC=ocamlfind ocamlc -package printbox,printbox-text -linkpkg
OCAMLLEX=ocamllex
MENHIR=menhir

# Files
SOURCES=Location.ml Ast.ml lexer.ml pretty.ml driver.ml
EXECUTABLE=parser.exe

all: $(EXECUTABLE)
	
# Compile the Location module
Location.cmo Location.cmi: Location.ml
	$(OCAMLC) -c Location.ml

# Compile the Ast module, which depends on Location
Ast.cmo Ast.cmi: Location.cmo Ast.ml
	$(OCAMLC) -c Ast.ml

# Generate lexer from .mll
lexer.ml: lexer.mll
	$(OCAMLLEX) lexer.mll

# Generate parser from .mly
parser.ml parser.mli: parser.mly Ast.cmi
	$(MENHIR) parser.mly

# Compile parser after it's generated
parser.cmi: parser.mli
	$(OCAMLC) -c parser.mli

parser.cmo: parser.ml parser.cmi
	$(OCAMLC) -c parser.ml

# Compile all sources into executable
$(EXECUTABLE): Location.cmo Ast.cmo parser.cmo lexer.ml pretty.ml
	$(OCAMLC) -o $(EXECUTABLE) Location.cmo Ast.cmo parser.cmo lexer.ml pretty.ml

# Test the executable
test: $(EXECUTABLE)
	./$(EXECUTABLE) test1.txt

# Clean up generated files
clean:
	rm -f *.cmo *.cmi *.exe lexer.ml parser.ml parser.mli *.o
