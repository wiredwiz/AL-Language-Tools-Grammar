parser grammar AL_Parser;

options { tokenVocab=AL_Lexer; }

compileUnit
	: EOF
   | statement EOF
	;

variableList
	: IDENTIFIER (COMMA IDENTIFIER)*?;

variableDeclaration
   : variableList COLON builtinType SEMICOLON;

variableDeclarations
   : variableDeclaration (variableDeclaration)*?;

varBlock
   : VAR variableDeclaration;

protectedVarBlock
   : PROTECTED VAR variableDeclaration;

builtinType
   : ACTION | ARRAY | AUTOMATION | BIGINTEGER | BIGTEXT | BLOB | BOOLEAN | BYTE | CHAR | CLIENTTYPE | CODE 
   | CODEUNIT | COMPLETIONTRIGGERERRORLEVEL | CONNECTIONTYPE | DATABASE | DATACLASSIFICATION | DATASCOPE 
   | DATE | DATEFORMULA | DATETIME | DECIMAL | DEFAULTLAYOUT | DIALOG | DICTIONARY | DOTNET | DOTNETASSEMBLY 
   | DOTNETTYPEDECLARATION | DURATION | ENUM | ERRORINFO | ERRORTYPE | EXECUTIONCONTEXT | EXECUTIONMODE 
   | FIELDCLASS | FIELDREF | FIELDTYPE | FILE | FILTERPAGEBUILDER | GUID | INSTREAM | INTEGER | JOKER 
   | KEYREF | LIST | MODULEDEPENDENCYINFO | MODULEINFO | NONE | NOTIFICATION | NOTIFICATIONSCOPE | OBJECTTYPE 
   | OPTION | OUTSTREAM | PAGE | PAGERESULT | QUERY | RECORD | RECORDID | RECORDREF | REPORT | REPORTFORMAT 
   | SECURITYFILTER | SECURITYFILTERING | TABLE | TABLECONNECTIONTYPE | TABLEFILTER | TESTACTION | TESTFIELD 
   | TESTFILTERFIELD | TESTPAGE | TESTPERMISSIONS | TESTREQUESTPAGE | TEXT | TEXTBUILDER | TEXTCONST 
   | TEXTENCODING | TIME | TRANSACTIONMODEL | TRANSACTIONTYPE | VARIANT | VERBOSITY | VERSION | XMLPORT 
   | HTTPCONTENT | HTTPHEADERS | HTTPCLIENT | HTTPREQUESTMESSAGE | HTTPRESPONSEMESSAGE | JSONTOKEN 
   | JSONVALUE | JSONARRAY | JSONOBJECT | VIEW | VIEWS | XMLATTRIBUTE | XMLATTRIBUTECOLLECTION | XMLCOMMENT 
   | XMLCDATA | XMLDECLARATION | XMLDOCUMENT | XMLDOCUMENTTYPE | XMLELEMENT | XMLNAMESPACEMANAGER 
   | XMLNAMETABLE | XMLNODE | XMLNODELIST | XMLPROCESSINGINSTRUCTION | XMLREADOPTIONS | XMLTEXT 
   | XMLWRITEOPTIONS | WEBSERVICEACTIONCONTEXT | WEBSERVICEACTIONRESULTCODE | SESSIONSETTINGS;

applicationObjectType
   : CODEUNIT | PAGE | PAGEEXTENSION | PAGECUSTOMIZATION | DOTNET | ENUM | ENUMEXTENSION | VALUE | QUERY 
   | REPORT | TABLE | TABLEEXTENSION | XMLPORT | PROFILE | CONTROLADDIN | REPORTEXTENSION | INTERFACE 
   | PERMISSIONSET | PERMISSIONSETEXTENSION | ENTITLEMENT;

/*
 * Field related rules
 */

fieldValue
   : IDENTIFIER 
   | INTEGER_LITERAL 
   | FLOAT_LITERAL 
   | DATE_LITERAL 
   | TIME_LITERAL 
   | DATETIME_LITERAL 
   | STRING_LITERAL
   ;

comparisonFilter
   : ('<>' | '=' | '<' | '>' | '<=' | '>=' ) fieldValue
   ;

filterRule
   : (fieldValue | comparisonFilter)
   ;

compoundFilterRule
   : filterRule (('|' | '&') filterRule)*?
   ;

tableReference
   : IDENTIFIER
   ;

fieldReference
   : IDENTIFIER
   ;

qualifiedFieldReference
   : tableReference '.' fieldReference
   ;

/*
 * Table relations
 */

tableRelationFilter
   : IDENTIFIER '=' (FIELD LEFTPAREN IDENTIFIER RIGHTPAREN | CONST LEFTPAREN (IDENTIFIER | DIGIT+) RIGHTPAREN)
   ;

tableRelationFilters
   : tableRelationFilter (COMMA tableRelationFilter)*?
   ;

tableRelationWhereClause
   : WHERE LEFTPAREN tableRelationFilters RIGHTPAREN
   ;

fieldRelationClause
   : (tableReference | qualifiedFieldReference) tableRelationWhereClause?
   ;

tableRelationIfCondition
   : IF LEFTPAREN tableRelationFilters RIGHTPAREN fieldRelationClause tableRelationElseCondition?
   ;

tableRelationElseCondition
   : ELSE tableRelationIfCondition
   ;

tableRelation
   : fieldRelationClause?
   | tableRelationIfCondition
   ;

/*
 * Flow fields
 */

calcFormulaTableFilterValue
   : CONST LEFTPAREN fieldValue RIGHTPAREN
   | FILTER LEFTPAREN compoundFilterRule RIGHTPAREN
   | FIELD LEFTPAREN IDENTIFIER RIGHTPAREN
   | FIELD LEFTPAREN UPPERLIMIT LEFTPAREN IDENTIFIER RIGHTPAREN RIGHTPAREN
   | FIELD LEFTPAREN FILTER LEFTPAREN IDENTIFIER RIGHTPAREN RIGHTPAREN
   | FIELD LEFTPAREN UPPERLIMIT LEFTPAREN FILTER LEFTPAREN IDENTIFIER RIGHTPAREN RIGHTPAREN RIGHTPAREN
   ;

calcFormulaTableFilter
   : fieldReference '=' calcFormulaTableFilterValue
   ;

calcFormulaTableFilters
   : calcFormulaTableFilter (COMMA calcFormulaTableFilter)*?
   ;

calcFormulaWhereClause
   : WHERE LEFTPAREN calcFormulaTableFilters RIGHTPAREN
   ;

calcFormulaExist
   : '-' EXIST LEFTPAREN tableReference calcFormulaWhereClause? RIGHTPAREN
   ;

calcFormulaCount
   : COUNT LEFTPAREN tableReference calcFormulaWhereClause? RIGHTPAREN
   ;

calcFormulaSum
   : '-' SUM LEFTPAREN qualifiedFieldReference calcFormulaWhereClause? RIGHTPAREN
   ;

calcFormulaAverage
   : '-' AVERAGE LEFTPAREN qualifiedFieldReference calcFormulaWhereClause? RIGHTPAREN
   ;
   
calcFormulaMin
   : MIN LEFTPAREN qualifiedFieldReference calcFormulaWhereClause? RIGHTPAREN
   ;

calcFormulaMax
   : MAX LEFTPAREN qualifiedFieldReference calcFormulaWhereClause? RIGHTPAREN
   ;

calcFormulaLookup
   : LOOKUP LEFTPAREN qualifiedFieldReference calcFormulaWhereClause? RIGHTPAREN
   ;

calcForumla
   : calcFormulaExist
   | calcFormulaCount
   | calcFormulaSum
   | calcFormulaAverage
   | calcFormulaMin
   | calcFormulaMax
   | calcFormulaLookup
   ;

/*
 * Tables
 */



/*
 * Method attributes
 */

attributeArgument
   : IDENTIFIER COLON builtinType;

attributeArgumentList
   : (attributeArgument (COMMA attributeArgument)*?)?;

methodAttribute
   : LEFTBRACKET IDENTIFIER (LEFTPAREN attributeArgumentList RIGHTPAREN)? RIGHTBRACKET;

/*
 * AL IF statement logic
 */

ifConditionStatement
   : IF expression THEN;

elseStatement
   : ELSE statement;

ifStatement
   : ifConditionStatement statement (elseStatement)?;

/*
 * AL WHILE statement logic
 */

whileConditionalStatement
   : WHILE expression DO;

whileStatement
   : whileConditionalStatement statement;

/*
 * AL FOR statement logic
 */

forValue
   : DATE_LITERAL
   | TIME_LITERAL
   | booleanLiteral
   | numberLiteral
   ;

forControlStatement
   : FOR IDENTIFIER ':=' forValue (TO | DOWNTO) forValue DO;

forStatement
   : forControlStatement statement;

/*
 * AL CASE statement logic
 */

caseValue
   : numberLiteral
   | booleanLiteral
   | DATE_LITERAL
   | TIME_LITERAL
   | DATETIME_LITERAL
   | optionLiteral
   | STRING_LITERAL
   ;

caseSet
   : caseValue (COMMA caseValue)*?;

caseRange
   : caseValue RANGE caseValue;

caseValueStatement
   : (caseSet | caseRange) COLON statement;

caseElseStatement
   : ELSE statement;

caseBody
   : (caseValueStatement (SEMICOLON caseValueStatement)*?)? caseElseStatement?;

caseControlStatement
   : CASE expression OF;

caseStatement
   : caseControlStatement caseBody END;

/*
 * AL REPEAT UNTIL statement logic
 */

untilCondition
   : UNTIL expression;

repeatUntilStatement
   : REPEAT statement untilCondition;

/*
 * AL WITH statement logic
 * (DEPRECATED in Dynamics 365 Business Central 2020, release wave 2)
 */

withControlStatement
   : WITH IDENTIFIER DO;

withStatement
   : withControlStatement statement;

/*
 * AL generic statement statement logic
 */

statementLine
   : ifStatement
   | forStatement
   | caseStatement
   | withStatement
   | whileStatement
   | repeatUntilStatement
   | expression;
   
statementBlock
   : BEGIN statementList END;

statement
   : (statementLine | statementBlock) SEMICOLON?
   ;

statementList
   : (statementLine (SEMICOLON statementLine)*?)? SEMICOLON?;

/*
 * AL expression logic
 */

indexAccessorValue
   : INTEGER_LITERAL
   | IDENTIFIER
   ;

indexAccessorSet
   : indexAccessorValue (COMMA indexAccessorValue)*?;

expression
   : '(' expression ')' #ParenthesisExpression
   | expression ('*' | '/' | MOD) expression #DivMultExpression
   | expression ('+' | '-') expression #AddSubtractExpression
   | expression ('<' | '>' | '<=' | '>=' | '<>' | '=') expression #ComparisonExpression
   | expression (AND | OR) expression #LogicalComparisonExpression
   | expression (':=' | '/=' | '*=' | '+=' | '-=') expression #AssignmentExpression
   | expression LEFTBRACKET indexAccessorSet RIGHTBRACKET #IndexExpression
   | booleanLiteral #BooleanLiteralExpression
   | DATE_LITERAL #DateLiteralExpression
   | TIME_LITERAL #TimeLiteralExpression
   | DATETIME_LITERAL #DatetimeLiteralExpression
   | IDENTIFIER #IdentifierExpression
   | STRING_LITERAL #StringLiteralExpression
   | numberLiteral #NumberLiteralExpression
   | optionLiteral #OptionLiteralExpression;

optionLiteral
   : IDENTIFIER OPTION_MEMBER IDENTIFIER;

booleanLiteral
   : TRUE
   | FALSE
   ;

numberLiteral
   : FLOAT_LITERAL
   | INTEGER_LITERAL
   ;