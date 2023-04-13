parser grammar AL_Parser;

options { tokenVocab=AL_Lexer; }

compileUnit
	: EOF
   | statement EOF
	;

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
 * Type declarations
 */

sizeDeclaration : '[' INTEGER_LITERAL ']';

/*
 * Tables
 */

tableFieldId : INTEGER_LITERAL;

tableFieldName : IDENTIFIER;

tableFieldType
   : INTEGER
   | BIGINTEGER
   | DECIMAL
   | BOOLEAN
   | BINARY
   | BLOB
   | CODE sizeDeclaration
   | TEXT sizeDeclaration
   | DATE
   | TIME
   | DATETIME
   | DATEFORMULA
   | DURATION
   | RECORDID
   | TABLEFILTER
   | OPTION
   | GUID
   ;



tableField
   : FIELD LEFTPAREN tableFieldId ';' tableFieldName ';' tableFieldType RIGHTPAREN '{'  '}';

/*
 * Method attributes
 */

attributeArgument
   : IDENTIFIER COLON builtinType;

attributeArgumentList
   : attributeArgument (COMMA attributeArgument)*?;

methodAttribute
   : LEFTBRACKET IDENTIFIER (LEFTPAREN attributeArgumentList? RIGHTPAREN)? RIGHTBRACKET;

/*
 * Variables
 */

key
   : IDENTIFIER
   ;

dataType
   : IDENTIFIER
   ;

labelText
   : STRING_LITERAL
   ;

labelMaxLength
   : MAXLENGTH '=' INTEGER_LITERAL
   ;

labelComment
   : COMMENT '=' STRING_LITERAL
   ;

labelLocked
   : LOCKED '=' (TRUE | FALSE)
   ;

labelArgument
   : labelMaxLength
   | labelComment
   | labelLocked
   ;

labelArgs
   : labelArgument (COMMA labelArgument)*?
   ;

optionValue
   : IDENTIFIER
   ;

optionValueList
   : optionValue (COMMA optionValue)*?
   ;

variableTypeDeclaration
   : ANY
   | BIGINTEGER
   | BIGTEXT
   | BLOB
   | BOOLEAN
   | BYTE
   | CHAR
   | CODE sizeDeclaration
   | CODEUNIT IDENTIFIER
   | COMPANYPROPERTY
   | DATABASE
   | DATATRANSFER
   | DATE
   | DATEFORMULA
   | DATETIME
   | DEBUGGER
   | DECIMAL
   | DIALOG
   | DICTIONARY OF '[' key COMMA dataType ']'
   | DOTNOT IDENTIFIER
   | DURATION
   | ENUM IDENTIFIER
   | ERRORINFO
   | FIELDREF
   | FILE
   | FILTERPAGEBUILDER
   | GUID
   | HTTPCLIENT
   | HTTPCONTENT
   | HTTPHEADERS
   | HTTPREQUESTMESSAGE
   | HTTPRESPONSEMESSAGE
   | INSTREAM
   | INTEGER
   | ISOLATEDSTORAGE
   | JSONARRAY
   | JSONOBJECT
   | JSONTOKEN
   | JSONVALUE
   | KEYREF
   | LABEL labelText (COMMA labelArgs)?
   | LIST OF '[' dataType ']'
   | MEDIA
   | MEDIASET
   | MODULEDEPENDENCYINFO
   | MODULEINFO
   | NAVAPP
   | NONE
   | NOTIFICATION
   | NUMBERSEQUENCE
   | OPTION optionValueList
   | OUTSTREAM
   | PAGE IDENTIFIER
   | PRODUCTNAME
   | QUERY IDENTIFIER
   | RECORD IDENTIFIER TEMPORARY?
   | RECORDID
   | RECORDREF
   | REPORT IDENTIFIER
   | REQUESTPAGE IDENTIFIER
   | SESSION
   | SESSIONINFORMATION
   | SESSIONSETTINGS
   | SYSTEM
   | TASKSCHEDULER
   | TESTACTION
   | TESTFIELD
   | TESTFILTER
   | TESTFILTERFIELD
   | TESTPAGE
   | TESTPART
   | TESTREQUESTPAGE
   | TEXT sizeDeclaration
   | TEXTBUILDER
   | TEXTCONST IDENTIFIER '=' STRING_LITERAL
   | TIME
   | VARIANT
   | VERSION
   | WEBSERVICEACTIONCONTEXT
   | XMLATTRIBUTE
   | XMLATTRIBUTECOLLECTION
   | XMLCDATA
   | XMLCOMMENT
   | XMLDECLARATION
   | XMLDOCUMENT
   | XMLDOCUMENTTYPE
   | XMLELEMENT
   | XMLNAMESPACEMANAGER
   | XMLNAMETABLE
   | XMLNODE
   | XMLNODELIST
   | XMLPORT
   | XMLPROCESSINGINSTRUCTION
   | XMLREADOPTIONS
   | XMLTEXT
   | XMLWRITEOPTIONS
   | ACTION
   | AUDITCATEGORY
   | CLIENTTYPE
   | COMMITBEHAVIOR
   | DATACLASSIFICATION
   | DATASCOPE
   | DEFAULTLAYOUT
   | ERRORBEHAVIOR
   | ERRORTYPE
   | EXECUTIONCONTEXT
   | EXECUTIONMODE
   | FIELDCLASS
   | FIELDTYPE
   | INHERENTPERMISSIONSSCOPE
   | ISOLATIONLEVEL
   | NOTIFICATIONSCOPE
   | OBJECTTYPE
   | PAGEBACKGROUNDTASKERRORLEVEL
   | PERMISSIONOBJECTTYPE
   | REPORTFORMAT
   | REPORTLAYOUTTYPE
   | SECURITYFILTER
   | SECURITYOPERATIONRESULT
   | TABLECONNECTIONTYPE
   | TELEMETRYSCOPE
   | TESTPERMISSIONS
   | TEXTENCODING
   | TRANSACTIONMODEL
   | TRANSACTIONTYPE
   | VERBOSITY
   | WEBSERVICEACTIONRESULTCODE
   ;

parameterDeclaration
   : VAR? IDENTIFIER COLON variableTypeDeclaration
   ;

parameterList
   : parameterDeclaration (SEMICOLON parameterDeclaration)*?
   ;
   
variableNameList
	: IDENTIFIER (COMMA IDENTIFIER)*?
   ;

variableDeclaration
   : variableNameList COLON variableTypeDeclaration SEMICOLON
   ;

variableDeclarations
   : variableDeclaration (variableDeclaration)*?
   ;

varBlock
   : VAR variableDeclarations
   ;

protectedVarBlock
   : PROTECTED VAR variableDeclaration
   ;

returnValue
   : COLON IDENTIFIER
   ;

/*
 * Trigger declarations
 */

triggerName : IDENTIFIER;

triggerDeclaration
   : TRIGGER triggerName LEFTPAREN parameterList? RIGHTPAREN returnValue? varBlock? statementBlock SEMICOLON;

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