lexer grammar AL_Lexer;

channels { COMMENTS_CHANNEL }

SINGLE_LINE_COMMENT
	: '//' INPUT_CHARACTER* -> channel(COMMENTS_CHANNEL);

DELIMITED_COMMENT
	: '/*' .*? '*/' -> channel(COMMENTS_CHANNEL);

WS
	:	[ \t\r\n] -> channel(HIDDEN)
	;

OPTION_MEMBER
   : '::';

RANGE
   : '..';

SEMICOLON
   : ';';

COLON
   : ':';

COMMA
   : ',';

PERIOD
   : '.';

GREATERTHANEQUAL
   : '>=';

LESSTHANEQUAL
   : '<=';

NOTEQUAL
   : '<>';

ASSGN
   : ':=';

MULTIPLY_ASSGN
   : '*=';

DIV_ASSGN
   : '/=';

ADD_ASSGN
   : '+=';

MINUS_ASSGN
   : '-=';

EQUALS
   : '=';

ASTERISK
   : '*';

BACKSLASH
   : '/';

PLUS
   : '+';

MINUS
   : '-';

LESSTHAN
   : '<';

GREATERTHAN
   : '>';

LEFTPAREN
   : '(';

RIGHTPAREN
   : ')';

LEFTBRACKET
   : '[';

RIGHTBRACKET
   : ']';

LEFTCBRACE
   : '{';

RIGHTCBRACE
   : '}';

PIPE
   : '|';

AMPERSAND
   : '&';

/*
 * Control Keywords
 */

ARRAY
   : A R R A Y
   ;

ASSERTERROR
   : A S S E R T E R R O R
   ;

BEGIN
   : B E G I N
   ;

BREAK
   : B R E A K
   ;

CASE
   : C A S E
   ;

DO
   : D O
   ;

DOWNTO
   : D O W N T O
   ;

ELSE
   : E L S E
   ;

END
   : E N D
   ;

EVENT
   : E V E N T
   ;

EXIT
   : E X I T
   ;

FOR
   : F O R
   ;

FOREACH
   : F O R E A C H
   ;

FUNCTION
   : F U N C T I O N
   ;

IF
   : I F
   ;

IMPLEMENTS
   : I M P L E M E N T S
   ;

IN
   : I N
   ;

INDATASET
   : I N D A T A S E T
   ;

INTERNAL
   : I N T E R N A L
   ;

LOCAL
   : L O C A L
   ;

OF
   : O F
   ;

PROCEDURE
   : P R O C E D U R E
   ;

PROGRAM
   : P R O G R A M
   ;

PROTECTED
   : P R O T E C T E D
   ;

REPEAT
   : R E P E A T
   ;

RUNONCLIENT
   : R U N O N C L I E N T
   ;

SUPPRESSDISPOSE
   : S U P P R E S S D I S P O S E
   ;

TEMPORARY
   : T E M P O R A R Y
   ;

THEN
   : T H E N
   ;

TO
   : T O
   ;

TRIGGER
   : T R I G G E R
   ;

UNTIL
   : U N T I L
   ;

VAR
   : V A R
   ;

WHILE
   : W H I L E
   ;

WITH
   : W I T H
   ;

WITHEVENTS
   : W I T H E V E N T S
   ;

/* 
 * operator keywords 
 */

AND
   : A N D
   ;

DIV
   : D I V
   ;

MOD
   : M O D
   ;

NOT
   : N O T
   ;

OR
   : O R
   ;

XOR
   : X O R
   ;

/* 
 * properties 
 */

AVERAGE
   : A V E R A G E
   ;

CONST
   : C O N S T
   ;

COUNT
   : C O U N T
   ;

EXIST
   : E X I S T
   ;

FIELD
   : F I E L D
   ;

FILTER
   : F I L T E R
   ;

LOOKUP
   : L O O K U P
   ;

MAX
   : M A X
   ;

MIN
   : M I N
   ;

ORDER
   : O R D E R
   ;

SORTING
   : S O R T I N G
   ;

SUM
   : S U M
   ;

TABLEDATA
   : T A B L E D A T A
   ;

UPPERLIMIT
   : U P P E R L I M I T
   ;

WHERE
   : W H E R E
   ;

ASCENDING
   : A S C E N D I N G
   ;

DESCENDING
   : D E S C E N D I N G
   ;

/* 
 * application object types
 */

CODEUNIT
   : C O D E U N I T
   ;

PAGE
   : P A G E
   ;

PAGEEXTENSION
   : P A G E E X T E N S I O N
   ;

PAGECUSTOMIZATION
   : P A G E C U S T O M I Z A T I O N
   ;

ENUM
   : E N U M
   ;

ENUMEXTENSION
   : E N U M E X T E N S I O N
   ;

VALUE
   : V A L U E
   ;

QUERY
   : Q U E R Y
   ;

REPORT
   : R E P O R T
   ;

TABLE
   : T A B L E
   ;

TABLEEXTENSION
   : T A B L E E X T E N S I O N
   ;

XMLPORT
   : X M L P O R T
   ;

PROFILE
   : P R O F I L E
   ;

CONTROLADDIN
   : C O N T R O L A D D I N
   ;

REPORTEXTENSION
   : R E P O R T E X T E N S I O N
   ;

INTERFACE
   : I N T E R F A C E
   ;

PERMISSIONSET
   : P E R M I S S I O N S E T
   ;

PERMISSIONSETEXTENSION
   : P E R M I S S I O N S E T E X T E N S I O N
   ;

ENTITLEMENT
   : E N T I T L E M E N T
   ;

/* 
 * builtin types 
 */

ACTION
   : A C T I O N
   ;

AUTOMATION
   : A U T O M A T I O N
   ;

BIGINTEGER
   : B I G I N T E G E R
   ;

BIGTEXT
   : B I G T E X T
   ;

BLOB
   : B L O B
   ;

BOOLEAN
   : B O O L E A N
   ;

BYTE
   : B Y T E
   ;

CHAR
   : C H A R
   ;

CLIENTTYPE
   : C L I E N T T Y P E
   ;

CODE
   : C O D E
   ;

COMPLETIONTRIGGERERRORLEVEL
   : C O M P L E T I O N T R I G G E R E R R O R L E V E L
   ;

CONNECTIONTYPE
   : C O N N E C T I O N T Y P E
   ;

DATABASE
   : D A T A B A S E
   ;

DATACLASSIFICATION
   : D A T A C L A S S I F I C A T I O N
   ;

DATASCOPE
   : D A T A S C O P E
   ;

DATE
   : D A T E
   ;

DATEFORMULA
   : D A T E F O R M U L A
   ;

DATETIME
   : D A T E T I M E
   ;

DECIMAL
   : D E C I M A L
   ;

DEFAULTLAYOUT
   : D E F A U L T L A Y O U T
   ;

DIALOG
   : D I A L O G
   ;

DICTIONARY
   : D I C T I O N A R Y
   ;

DOTNET
   : D O T N E T
   ;

DOTNETASSEMBLY
   : D O T N E T A S S E M B L Y
   ;

DOTNETTYPEDECLARATION
   : D O T N E T T Y P E D E C L A R A T I O N
   ;

DURATION
   : D U R A T I O N
   ;

ERRORINFO
   : E R R O R I N F O
   ;

ERRORTYPE
   : E R R O R T Y P E
   ;

EXECUTIONCONTEXT
   : E X E C U T I O N C O N T E X T
   ;

EXECUTIONMODE
   : E X E C U T I O N M O D E
   ;

FIELDCLASS
   : F I E L D C L A S S
   ;

FIELDREF
   : F I E L D R E F
   ;

FIELDTYPE
   : F I E L D T Y P E
   ;

FILE
   : F I L E
   ;

FILTERPAGEBUILDER
   : F I L T E R P A G E B U I L D E R
   ;

GUID
   : G U I D
   ;

INSTREAM
   : I N S T R E A M
   ;

INTEGER
   : I N T E G E R
   ;

JOKER
   : J O K E R
   ;

KEYREF
   : K E Y R E F
   ;

LIST
   : L I S T
   ;

MODULEDEPENDENCYINFO
   : M O D U L E D E P E N D E N C Y I N F O
   ;

MODULEINFO
   : M O D U L E I N F O
   ;

NONE
   : N O N E
   ;

NOTIFICATION
   : N O T I F I C A T I O N
   ;

NOTIFICATIONSCOPE
   : N O T I F I C A T I O N S C O P E
   ;

OBJECTTYPE
   : O B J E C T T Y P E
   ;

OPTION
   : O P T I O N
   ;

OUTSTREAM
   : O U T S T R E A M
   ;

PAGERESULT
   : P A G E R E S U L T
   ;


RECORD
   : R E C O R D
   ;

RECORDID
   : R E C O R D I D
   ;

RECORDREF
   : R E C O R D R E F
   ;

REPORTFORMAT
   : R E P O R T F O R M A T
   ;

SECURITYFILTER
   : S E C U R I T Y F I L T E R
   ;

SECURITYFILTERING
   : S E C U R I T Y F I L T E R I N G
   ;

TABLECONNECTIONTYPE
   : T A B L E C O N N E C T I O N T Y P E
   ;

TABLEFILTER
   : T A B L E F I L T E R
   ;

TESTACTION
   : T E S T A C T I O N
   ;

TESTFIELD
   : T E S T F I E L D
   ;

TESTFILTERFIELD
   : T E S T F I L T E R F I E L D
   ;

TESTPAGE
   : T E S T P A G E
   ;

TESTPERMISSIONS
   : T E S T P E R M I S S I O N S
   ;

TESTREQUESTPAGE
   : T E S T R E Q U E S T P A G E
   ;

TEXT
   : T E X T
   ;

TEXTBUILDER
   : T E X T B U I L D E R
   ;

TEXTCONST
   : T E X T C O N S T
   ;

TEXTENCODING
   : T E X T E N C O D I N G
   ;

TIME
   : T I M E
   ;

TRANSACTIONMODEL
   : T R A N S A C T I O N M O D E L
   ;

TRANSACTIONTYPE
   : T R A N S A C T I O N T Y P E
   ;

VARIANT
   : V A R I A N T
   ;

VERBOSITY
   : V E R B O S I T Y
   ;

VERSION
   : V E R S I O N
   ;

HTTPCONTENT
   : H T T P C O N T E N T
   ;

HTTPHEADERS
   : H T T P H E A D E R S
   ;

HTTPCLIENT
   : H T T P C L I E N T
   ;

HTTPREQUESTMESSAGE
   : H T T P R E Q U E S T M E S S A G E
   ;

HTTPRESPONSEMESSAGE
   : H T T P R E S P O N S E M E S S A G E
   ;

JSONTOKEN
   : J S O N T O K E N
   ;

JSONVALUE
   : J S O N V A L U E
   ;

JSONARRAY
   : J S O N A R R A Y
   ;

JSONOBJECT
   : J S O N O B J E C T
   ;

VIEW
   : V I E W
   ;

VIEWS
   : V I E W S
   ;

XMLATTRIBUTE
   : X M L A T T R I B U T E
   ;

XMLATTRIBUTECOLLECTION
   : X M L A T T R I B U T E C O L L E C T I O N
   ;

XMLCOMMENT
   : X M L C O M M E N T
   ;

XMLCDATA
   : X M L C D A T A
   ;

XMLDECLARATION
   : X M L D E C L A R A T I O N
   ;

XMLDOCUMENT
   : X M L D O C U M E N T
   ;

XMLDOCUMENTTYPE
   : X M L D O C U M E N T T Y P E
   ;

XMLELEMENT
   : X M L E L E M E N T
   ;

XMLNAMESPACEMANAGER
   : X M L N A M E S P A C E M A N A G E R
   ;

XMLNAMETABLE
   : X M L N A M E T A B L E
   ;

XMLNODE
   : X M L N O D E
   ;

XMLNODELIST
   : X M L N O D E L I S T
   ;

XMLPROCESSINGINSTRUCTION
   : X M L P R O C E S S I N G I N S T R U C T I O N
   ;

XMLREADOPTIONS
   : X M L R E A D O P T I O N S
   ;

XMLTEXT
   : X M L T E X T
   ;

XMLWRITEOPTIONS
   : X M L W R I T E O P T I O N S
   ;

WEBSERVICEACTIONCONTEXT
   : W E B S E R V I C E A C T I O N C O N T E X T
   ;

WEBSERVICEACTIONRESULTCODE
   : W E B S E R V I C E A C T I O N R E S U L T C O D E
   ;

SESSIONSETTINGS
   : S E S S I O N S E T T I N G S
   ;

/* 
 * metadata
 */

ADD
   : A D D
   ;

ADDFIRST
   : A D D F I R S T
   ;

ADDLAST
   : A D D L A S T
   ;

ADDAFTER
   : A D D A F T E R
   ;

ADDBEFORE
   : A D D B E F O R E
   ;

ACTIONS
   : A C T I O N S
   ;

AREA
   : A R E A
   ;

ASSEMBLY
   : A S S E M B L Y
   ;

CHARTPART
   : C H A R T P A R T
   ;

CUEGROUP
   : C U E G R O U P
   ;

CUSTOMIZES
   : C U S T O M I Z E S
   ;

COLUMN
   : C O L U M N
   ;

DATAITEM
   : D A T A I T E M
   ;

DATASET
   : D A T A S E T
   ;

ELEMENTS
   : E L E M E N T S
   ;

EXTENDS
   : E X T E N D S
   ;

FIELDGROUP
   : F I E L D G R O U P
   ;

FIELDATTRIBUTE
   : F I E L D A T T R I B U T E
   ;

FIELDELEMENT
   : F I E L D E L E M E N T
   ;

FIELDGROUPS
   : F I E L D G R O U P S
   ;

FIELDS
   : F I E L D S
   ;

FIXED
   : F I X E D
   ;

GRID
   : G R I D
   ;

GROUP
   : G R O U P
   ;

KEY
   : K E Y
   ;

KEYS
   : K E Y S
   ;

LABEL
   : L A B E L
   ;

LABELS
   : L A B E L S
   ;

LAYOUT
   : L A Y O U T
   ;

MODIFY
   : M O D I F Y
   ;

MOVEFIRST
   : M O V E F I R S T
   ;

MOVELAST
   : M O V E L A S T
   ;

MOVEBEFORE
   : M O V E B E F O R E
   ;

MOVEAFTER
   : M O V E A F T E R
   ;

PART
   : P A R T
   ;

REPEATER
   : R E P E A T E R
   ;

USERCONTROL
   : U S E R C O N T R O L
   ;

REQUESTPAGE
   : R E Q U E S T P A G E
   ;

SCHEMA
   : S C H E M A
   ;

SEPARATOR
   : S E P A R A T O R
   ;

SYSTEMPART
   : S Y S T E M P A R T
   ;

TABLEELEMENT
   : T A B L E E L E M E N T
   ;

TEXTATTRIBUTE
   : T E X T A T T R I B U T E
   ;

TEXTELEMENT
   : T E X T E L E M E N T
   ;

/*TYPE
   : T Y P E
   ;*/


/* 
 * boolean 
 */

TRUE
   : T R U E;

FALSE
   : F A L S E;

/* 
 * date 
 */

DATE_LITERAL
   : DIGIT+ D;

/* 
 * time 
 */

TIME_LITERAL
   : DIGIT+ ([.] DIGIT+)? T;

/* 
 * datetime 
 */

DATETIME_LITERAL
   : DIGIT+ D T;

/* 
 * numbers 
 */

INTEGER_LITERAL
   : DIGIT+
   | ('0' X HEXDIGIT*? | DIGIT+) (EXPONENT_NOTATION EXPONENT_SIGN DIGIT+)? (INTEGER_SUFFIX | FLOAT_SUFFIX)?
   ;

FLOAT_LITERAL
	: (DIGIT+ [.] (DIGIT*)? {_input.La(1) != '.'}? (EXPONENT_NOTATION EXPONENT_SIGN DIGIT+)? 
	| [.] DIGIT+ (EXPONENT_NOTATION EXPONENT_SIGN DIGIT+)? 
	| DIGIT+ EXPONENT_NOTATION EXPONENT_SIGN DIGIT+) (INTEGER_SUFFIX | FLOAT_SUFFIX)?
	;

/* 
 * strings 
 */

STRING_LITERAL
	: '\'' ( ESC | ~['\r\n])* '\'';

/* 
 * identifiers 
 */

IDENTIFIER
	: (LETTER | DIGIT | UNDERSCORE)+
   | '"' ~["]+ '"'
	;

UNDERSCORE
	: '_';

LETTER
	: LOWERCASE 
	| UPPERCASE
	;

/*
 * preprocessor directives
 */

PREPROCESSOR_DIRECTIVE
   : '#' ~[\r\n]* '\r'? '\n';

/* 
 * fragments 
 */

fragment LOWERCASE
	: [a-z] ;

fragment UPPERCASE
	: [A-Z] ;

fragment EXPONENT_NOTATION
	: ('E' | 'e');

fragment EXPONENT_SIGN
	: ('-' | '+');

fragment DIGIT
	: [0-9] ;

fragment HEXDIGIT : [0-9] | [A-F] | [a-f];

fragment INTEGER_SUFFIX
   : [uU] [lL]? [lL]? | [lL] [lL]?;

fragment FLOAT_SUFFIX
   : [fF];

fragment ESC 
	: '\'\'' ;

fragment INPUT_CHARACTER
	: ~[\r\n\u0085\u2028\u2029];

fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];