%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1

#define TIP_INT 1
#define TIP_REAL 2
#define TIP_CAR 3

double stiva[20];
int sp;

void push(double x)
{ stiva[sp++]=x; }

double pop()
{ return stiva[--sp]; }

%}

%union {
  int l_val;
  char *p_val;
}

%token BEGINN
%token CONST
%token DO
%token ELSE
%token END
%token IF
%token PRINT
%token PROGRAM
%token READ
%token THEN
%token VAR
%token WHILE

%token ID
%token <p_val> CONST_INT
%token <p_val> CONST_REAL
%token <p_val> CONST_CAR
%token CONST_SIR

%token CHAR
%token INTEGER
%token REAL

%token ATRIB
%token NE
%token LE
%token GE

%left '+' '-'
%left DIV MOD '*' '/'
%left OR
%left AND
%left NOT


%%
prog_sursa:    "var" decllist ";" cmpdstmt "."
            ;
decllist:     declaration
            | declaration ";" decllist
            ;
declaration:  ID type ";"
            ;
type1:        "char"
            | "integer"
            | "real"
            | "bool"
            ;
arraydecl:    "sir" "[" nr "]" "tip" type1
            ;
type:         type1
            | arraydecl
            ;
cmpdstmt:     "BEGIN" stmtlist "END"
            ;
stmtlist:     stmt
            | stmt ";" stmtlist
            ;
stmt:         simplstmt
            | structstmt
            ;
simplstmt:    assignstmt
            | iostmt
            ;
assignstmt:   ID "=" expression
            ;
expression:   expression "+" term
            | term
            ;
term:         term "*" factor
            | factor
            ;
factor:       "(" expression ")"
            | ID
            ;
iostmt:       "read"
            | "write" '(' ID ')'
            ;
structstmt:   cmpdstmt
            | ifstmt
            | whilestmt
            | forstmt
            ;
ifstmt:       "if" '(' condition ')' "then" stmt '[' "else" stmt']'
            ;
whilestmt:    "while" "(" condition ")" "do" stmt
            ;
forstmt:      "for" "(" ID "=" nr ";" ID operator ID ";" ID "=" ID operator nr ")" structlist ";"
            ;
condition:    expression relation expression
            ;
relation:     "<"
            | "<="
            | "=="
            | "<>"
            | ">="
            | ">"
            | "!="
            ;
structlist:   statement
            | statement ";" structlist
            ;
statement:    simplstmt
            | structstmt
            ;
operator:     "+"
            | "-"
            | "*"
            | "/"
            ;
nr:        CONST_INT
            | CONST_REAL
            ;
%%
