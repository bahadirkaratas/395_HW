%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
%}

%union{
int int_lit;
char* id;
}

%start PEAKASSO
%token MSG
%token CANVAS_INIT_SECTION
%token BRUSH_DECLARATION_SECTION
%token DRAWING_SECTION
%token BRUSH
%token RENEW_BRUSH
%token PAINT_CANVAS
%token EXHIBIT_CANVAS
%token MOVE
%token TO
%token PROGRAM
%token ID
%token INT_LIT
%token COMMA
%token COLON
%token CONST
%token ASSIGN
%token SEMICOLON
%token CANVAS_X
%token CANVAS_Y
%token CURSOR_X
%token CURSOR_Y


%left PLUS MINUS

%%


PEAKASSO: PROGRAM id SEMICOLON canvas_init_section brush_declaration_section drawing_section;
canvas_init_section: CANVAS_INIT_SECTION COLON canvas_size_init cursor_pos_init;
canvas_size_init: CONST CANVAS_X ASSIGN INT_LIT SEMICOLON CONST CANVAS_Y ASSIGN INT_LIT SEMICOLON;
cursor_pos_init: CURSOR_X ASSIGN INT_LIT SEMICOLON CURSOR_Y ASSIGN INT_LIT SEMICOLON;
brush_declaration_section: BRUSH_DECLARATION_SECTION COLON
                           | BRUSH_DECLARATION_SECTION COLON variable_def;
variable_def: BRUSH brush_list SEMICOLON;
brush_list: brush_name
            | brush_name COMMA brush_list;
brush_name: id
            | id ASSIGN INT_LIT INT_LIT;
id: ID;
drawing_section: DRAWING_SECTION COLON statement_list ;


statement_list: statement SEMICOLON
                | statement statement_list;


statement:renew_stmt
          |paint_stmt
          | exhibit_stmt
          | cursor_move_stmt;

renew_stmt:
    RENEW_BRUSH MSG brush_name SEMICOLON
    ;

paint_stmt:
    PAINT_CANVAS brush_name
    ;

exhibit_stmt:
    EXHIBIT_CANVAS SEMICOLON
    ;

cursor_move_stmt:
    MOVE cursor TO expression SEMICOLON
    ;

cursor:
    CURSOR_X | CURSOR_Y
    ;
expression: term
            | term PLUS expression_prime
            | term MINUS expression_prime
    ;
expression_prime:
            factor
            |term PLUS expression_prime
            | term MINUS expression_prime
            | SEMICOLON
    ; 

term: factor;

factor: INT_LIT
        | cursor
        | CANVAS_X
        | CANVAS_Y
        | expression;
%%
int main() {

/*
    yyin = fopen("input.txt", "r"); 
    if (!yyin) {
        printf("Could not open input file\n");
        return 0;
    }
*/
    yyparse();

   // fclose(yyin);
    return 0;
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
