%{
#include "y.tab.h"

%}

%%
"PROGRAM"    { return PROGRAM; }
";"          { return SEMICOLON; }
":"          { return COLON; }
"CANVAS-INIT-SECTION" { return CANVAS_INIT_SECTION; }
"CONST" { return CONST; }
"BRUSH-DECLARATION-SECTION" { return BRUSH_DECLARATION_SECTION; }
"BRUSH"      { return BRUSH; }
"DRAWING-SECTION" { return DRAWING_SECTION; }
"RENEW-BRUSH" { return RENEW_BRUSH; }
"PAINT-CANVAS" { return PAINT_CANVAS; }
"EXHIBIT-CANVAS" { return EXHIBIT_CANVAS; }
"MOVE"       { return MOVE; }
"TO"         { return TO; }
"CursorX"    { return CURSOR_X; }
"CursorY"    { return CURSOR_Y; }
"CanvasX"    { return CANVAS_X; }
"CanvasY"    { return CANVAS_Y; }
"PLUS"       { return PLUS; }
"MINUS"      { return MINUS; }
"="          { return ASSIGN; }
","          { return COMMA; }
"!!".*       { /* Ignore comments */ }
[a-zA-Z][a-zA-Z0-9]* { yylval.id = strdup(yytext); return ID; }
[+-]?[0-9]+  { yylval.int_lit = atoi(yytext); return INT_LIT; }
\n           { /* Ignore newlines */ }
[ \t]        { /* Ignore whitespace */ }
.            {  }
%%

int yywrap(void) {
    return 1;
}

