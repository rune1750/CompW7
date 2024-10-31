# Compiler and flags
OCAMLC=ocamlfind ocamlc -package printbox -linkpkg
OCAMLLEX=ocamllex
MENHIR=menhir

# Files
SOURCES=Location.ml Ast.ml parser.ml lexer.ml pretty.ml test.ml
EXECUTABLE=parser.exe

all: $(EXECUTABLE)

# Generate lexer from .mll
lexer.ml: lexer.mll
	$(OCAMLLEX) lexer.mll

# Generate parser from .mly
parser.ml parser.mli: parser.mly Ast.cmi
	$(MENHIR) --infer parser.mly

# Compile the Location module
Location.cmo Location.cmi: Location.ml
	$(OCAMLC) -c Location.ml

# Compile the Ast module, which depends on Location
Ast.cmo Ast.cmi: Location.cmo Ast.ml
	$(OCAMLC) -c Ast.ml

# Compile all sources into executable
$(EXECUTABLE): Location.cmo Ast.cmo parser.mli parser.ml lexer.ml pretty.ml test.ml
	$(OCAMLC) -o $(EXECUTABLE) Location.cmo Ast.cmo $(SOURCES)

test: $(EXECUTABLE)
	./$(EXECUTABLE) test.txt

clean:
	rm -f *.cmo *.cmi *.exe lexer.ml parser.ml parser.mli *.o
