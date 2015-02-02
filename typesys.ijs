Note 'towards a J type system'
  Core elements of a type system are coercers/convertors and validators.  
  Consider a function f that accepts a numeric temperature expected to be in Celsius.
  f '33' f '98F' f '98 Farenheit' f '98 F' f '300K' and f 33 could all be parseable into the last valid input
  Validators and coercers can use the same function as the test component.  Their difference is that 
	Coercers modify the input if they can.  
	Convertors are more complex coercers
	Validators either raise an error or bring up an input box for manual correction.
  Implementations as a verb or adverb are possible.
	Verbs can be more straightforwardly applied to x and y arguments.
	Adverbs can be chained infinitely
)
NB. require jpath '~/zutils.ijs'
require 'format/printf'
cocurrent 'z'
pD_z_ =:  1!:2&2
eval_z_ =: 1 : ' a: 1 :  m'
hook_z_ =: 2 : '([: u v) : (u v) '
lrA_z_ =: 1 : '5!:5 < ''u'''
lr_z_ =: 3 : '5!:5 < ''y'''
linearize =: (, $~ 1 -.~ $)
a2v =: 1 : 0 NB. for dyad adverb, where adverb takes noun arg.  ie (3 1,: 6 2) '}' a2v reduce i.5
  4 : ('''a b'' =. x label_. a (b(', u  , ')) y')
)
dvA =: 2 : ',. n ( <;.2@,~) u lrA' NB. display long verb cut by a common character such as ) ^ or @ or (.  Adds extra trailing char that must be removed if trying to reparse.
notfalse =: 0:`((0~: ]) *.(a:~:]))@.(0<#@:])(+./@:) NB. :: 0:

NB. like Fork.  Adverb creates a conjunction. whose result is (f@:[ g h@:]) g is adverb parameter. f and h are u and v of conjunction result.
Fxhy_z_ =: 1 : ' 2 : (''u@:[ '' , ''('', u lrA , '')'' , '' v@:]'')'
daS =: 2 : (' a =. (u lrA , '' u '' , n) label_. 1 : (''u  1 :'' , quote a)')  NB. allows swapping order of double adverb arguments.  ex: 'num' +: daS 'c'

coclass 'typesys'
  noP =: 1 : ']'
  sfX =: 1 : '][u' 
   Y =: 1 : '(m&{::@:])'
   X =: 1 : '(m&{::@:[)'
dvAp =: dvA ')'  NB. examples: (+: + +:)^:(5 < ]) dvAp	 ] 'num ' cp dvAp		] 'num 2&count' cp dvAp		] 'num 2&count' cp dvA '('
numerify =: 0&".^:(2 = 3!:0)
maybenum =: 0&".^:(] -: ":@:numerify)
intify =: <.@numerify
roundify =: 0.5 <.@+ numerify
inrange =: (1 X >: ]) *.&(*./) 0 X <: ]
raiseErr =: 4 : '0 assert~ ''forced error: '', x'
NB.  TypeName CoercionFunction ValidationTest ErrorText
sDYNTYPES =: (9{a.) cut &> cutLF 0 : 0  NB. adds empty column for parameterized type/validations
num	0&".					1 4 8 16 64 128 e.~ 3!:0	Must be numeric
int	intify					1 4 64  e.~ 3!:0		Must be integer
intR	roundify					1 4 64  e.~ 3!:0		Must be roundable to interger
str	":					2 = 3!:0			Must be string
byteVals	a.&i.			(2=3!:0)+. 0 255&(inrange :: 0:) *. 1 4 e.~ 3!:0	Must be convertable to byte list
ascii	'unconvertible'&raiseErr`({&a.)@.(0 255&inrange) 	2 = 3!:0			Must be convertable to ascii
no1dim	, $~ 1 -.~ $				[: -.@:notfalse 1 e.~ $	Must not include any shapes of 1
any	]					1:			Test will always pass. Any param.	
)
NB. separate dyadic (parametrized) typelist for clarity.  Parameters always passed as string. maybenum converts if number is correct, otherwise likely an error.
DYNTYPES =: sDYNTYPES , (9{a.) cut &> cutLF 0 : 0
count	maybenum {.Fxhy ]		maybenum =Fxhy #			count must be equal to %s
gthan	maybenum@[ >. ]		maybenum@:[ *./@:<: ]		Must be greater or equal than %s	
lthan	maybenum@[ <. ]		maybenum@:[ *./@:>: ]		Must be lesser or equal than %s
inrange	'unconvertable' raiseErr ]	maybenum@:[ inrange  ]		Must be within range of %s
unboxed	<@:[ cV every ]		0 = L.@:]				Must be coerceable to parameter %s (type) then unboxed
each	<@:[ cV each ]		<@:[ vV each ]			Must be coerceable to parameter %s (type) then unboxed (this type stil flakey)
every	<@:[ cV every ]		<@:[ vV every ]			Must be coerceable to parameter %s (type) then unboxed (this type stil flakey)
)
NB. version meant to duplicate above "more permissive" Dynamic Types.  Dynamic types are usually optimized for coercion efficiency.  Strict for validation correctness. 
STRICTTYPES =: (9{a.) cut &> cutLF 0 : 0
num	maybenum			([: *./ (": -: [: ": (0&".)^:(2=3!:0)) every)	Must be numeric
gthan	maybenum@[ >. ]		maybenum@:[ *./@:<: 'num' vV ] 		Must be greater or equal than %s
)

TYPES =: DYNTYPES NB. default is dynamic, as not all types may be shaddowed by STRICT


wd2=: 3 : 'wd y' NB. bug workaround
typeparser =: boxopen L:1@:(> L:1)@:([: (4 : 0)/ '&'&cut)
  (}: , (}. y),~ [:< ({. y) ,~&< {:) ;: >x
)
typeparser =: (<<,'&') -.~ each (</.~ +/\@(-.@+. _1&|.)@:=&(<,'&'))@:;:
typeparser =: (<<,'&') -.~ each (</.~ +/\@(+: _1&|.)@:=&(<,'&'))@:;:

c =: 1 : 0
a =. typeparser m
o =. ]
for_i.  a do. d =.  linearize >^:(1 < L.)^:_ i  NB.'&' cut > i
b=. ({~ ({: d) i.~ {."1) TYPES  NB. index error means type not defined (misspelled?) in this locale.
if. 1 < # d do. o =. ((0 Y d) (1 Y b) eval  ^: (-.@:((2 Y b) eval)) ]) :: ((3 Y b)"_) @:o f.
  else. o =. (1 Y b) eval  ^: (-.@:((2 Y b) eval)) :: ((3 Y b)"_) @:o f. end. end.
1 : ('u hook (', o f. lrA , ' ) ')
)

NB. conjunction version uses v to either make side effect (pD or log) or preprocess y.  v is monadic
cC =: 2 : 0
a =. typeparser m
o =. ]
for_i.  a do. d =.  linearize >^:(1 < L.)^:_ i  
b=. ({~ ({: d) i.~ {."1) TYPES  NB. index error means type not defined (misspelled?) in this locale.
if. 1 < # d do. o =. ( (0 Y d) ((1 Y b) eval  v) ^: (-.@:((2 Y b) eval)) ]) :: ((3 Y b)"_) @:o f.
  else. o =.  (1 Y b) eval hook v ^: (-.@:((2 Y b) eval)) :: ((3 Y b)"_) @:o f. end. end.
1 : ('u hook (', o f. lrA , ' ) ')
)

NB. posts to screen when coercion is applied.
NB. first alternate shows simple presented data
NB. second alternative shows lr (type and shape) of data.  NB. comment 2nd to use first
cp =: cC (('COERCE: ' pD@:, ":) sfX)    
cp =: cC (('COERCE: ' pD@:, lr) sfX)    

v =: 1 : 0
a =. typeparser m
o =. ]
for_i. boxopen a do. d =.  linearize >^:(1 < L.)^:_ i 
b=. ({~ ({: d) i.~ {."1) TYPES    NB. index error means type not defined (misspelled?) in this locale.
if. 1 < # d do. e =. (3 Y b) sprintf {. d
 o =.  (e assert sfX (0 Y d) (2 Y b) eval :: 0: ])   sfX @:o f.
  else. o =.  ((3 Y b) assert sfX  (2 Y b) eval :: 0:) sfX @:o f. end. end.
1 : ('u [ (', o f. lrA , ')')
)

NB. more simply returns boolean value based on whether or not type test passed
vb =: 1 : 0
a =. typeparser m
o =. 1:
for_i. boxopen a do. d =.  linearize >^:(1 < L.)^:_ i NB. '&' cut > i
b=. ({~ ({: d) i.~ {."1) TYPES   NB. index error means type not defined (misspelled?) in this locale.
if. 1 < # d do. o =.  ( (0 Y d) (2 Y b) eval ]) :: 0: , o f.
  else. o =.  ( (2 Y b) eval) :: 0: @:]  , o f. end. end.
1 : ('u [:  *./ every (', o f. each lrA , ' )' )
)

ceach =: 4 : '] x c y' each
veach =: 4 : '] x v y' each

M =:  1 : 'u`(]`(u hook (;@:linearize@:}.@:]))@.((,.0) -: 0 Y))@.(1 = L.@:])'  NB. handles maybe error chains.
mkerr2 =: 2 : '(n ;~ ,.@_9:)`1:@.u :: ((13!:11 ; 13!:12)@:(''''"_))' 

vm =: 1 : 0
a =. typeparser m
o =. 1:
for_i. boxopen a do. d =. linearize >^:(1 < L.)^:_ i 
b=. ({~ ({: d) i.~ {."1) TYPES    NB. index error means type not defined (misspelled?) in this locale.
if. 1 < # d do. e =. (3 Y b) sprintf {. d
  o =.  (  (0 Y d) (2 Y b) eval  mkerr2 e ])@:]  ; o f. 
  else. o =.  ( (2 Y b) eval mkerr2 (3 Y b))@:]  ; o f.  end. end.
NB.1 : ('u  ]`[@.(1-:])chkerrA (', o f. lrA , ')')
1 : ('( [: > (<1) -.~ (', o f. lrA , '))`u@.( 1 -: [: *./  1 -: every (', o f. lrA , '))')
)

iv =: 1 : 0  NB. gives input box to correct validation err if fail.
a =. typeparser m
o =. ]
for_i. boxopen a do. d =. linearize >^:(1 < L.)^:_ i 
b=. ({~ ({: d) i.~ {."1) TYPES   NB. index error means type not defined (misspelled?) in this locale.
if. 1 < # d do. e =. (3 Y b) sprintf {. d
 o =.  (] ( [: wd2'mb input text "' , (0 Y b) , '" "' , e ,'" *' , ":@:[)`[@.]  (0 Y d) (2 Y b) eval :: 0: ]) @:o f.
  else. o =.  (] ([:  wd2 'mb input text "' , (0 Y b) , '" "' , (3 Y b) ,'" *' , ":@:[)`[@.]  (2 Y b) eval :: 0:)  @:o f. end. end.
  NB. else. o =.  (] ([: wd2 'mb info " ' , (0 Y b) , '" "' , (3 Y b) ,' " '"_ )@:[^:-.@]  (2 Y b) eval)  @:o f. end. end.
NB. pD o lrA
 1 : ('u hook (', o f. lrA , ')')
NB. o
)

strict =: 3 : 0 '0 1&inrange' v 
NB. y is 0 or 1. sets dynamic 0 vs strict 1 types by updating table from DYNAMIC or STRICT
NB. STRICTTYPES must include matching DYNTYPES (but not vis versa)
if. y do. TYPES =: STRICTTYPES (] '}'a2v~ [ ; i.~&([: linearize {."1)) TYPES else.
	TYPES =: DYNTYPES (] '}'a2v~ [ ; i.~&([: linearize {."1)) TYPES end.
)

t =: cp  NB. shaddow mode to easily switch among type constraining/enabling behaviours.  Either globally or within class that coinserts typesys
cV =: 4 : '] x c y' 
vV =: 4 : '] x v y' 
ivV =: 4 : '] x iv y' 
tV =: 4 : '] x t y' 
ci =: [ cV ivV  NB. verb that will first give input box check for failed validations, then coerce values.
cpV =: 4 : '] x cp y' 
vbV =: 4 : '] x vb y'
vbs =: 1 : 'u 1 : ''#~ m vb'''  NB. double adverb is compatible with t. instead of coercing, filters valid items to function.
off =: 1 : 'u  1 : '' hook ]'''  NB. can be used to turn off type system.  redefine any of c, cp, v, iv, vbs to off, and all code will/should work without type checks/actions
vmV =: 4 : '] x vm y'