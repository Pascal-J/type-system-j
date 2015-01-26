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
 require jpath '~/zutils.ijs'
NB. like Fork.  Adverb creates a conjunction. whose result is (f@:[ g h@:]) g is adverb parameter. f and h are u and v of conjunction result.
Fxhy_z_ =: 1 : ' 2 : (''u@:[ '' , ''('', u lrA , '')'' , '' v@:]'')'


coclass 'typesys'
  noP =: 1 : ']'
  sfX =: 1 : '][u' 
   Y =: 1 : '(m&{::@:])'
   X =: 1 : '(m&{::@:[)'
numerify =: 0&".^:(2 = 3!:0)
maybenum =: 0&".^:(] -: ":@:numerify)
intify =: <.@numerify
roundify =: 0.5 <.@+ numerify
inrange =: (1 X >: ]) *.&(*./) 0 X <: ]
raiseErr =: 4 : '0 assert~ ''forced error: '', x'
NB. sTYPES =: a: (2 insertitem)"1 (9{a.) cut &> cutLF 0 : 0  NB. tab delimited 4 items.  TypeName CoercionFunction ValidationTest ErrorText
sTYPES =: (9{a.) cut &> cutLF 0 : 0  NB. adds empty column for parameterized type/validations
num	0&".				1 4 8 16 64 128 e.~ 3!:0	Must be numeric
int	intify				1 4 64  e.~ 3!:0		Must be integer
intR	roundify				1 4 64  e.~ 3!:0		Must be roundable to interger
str	":				2 = 3!:0			Must be string
byteVals	a.&i.			0 255&(inrange :: 0:) *. 1 4 e.~ 3!:0	Must be convertable to byte list
ascii	'unconvertible'&raiseErr`({&a.)@.(0 255&inrange) 	2 = 3!:0		Must be convertable to ascii
no1dim	, $~ 1 -.~ $			[: -.@:notfalse 1 e.~ $	Must not include any shapes of 1
)
NB. separate dyadic list for clarity.
TYPES =: sTYPES , (9{a.) cut &> cutLF 0 : 0
count	maybenum {.Fxhy ]		maybenum =Fxhy #			count must be equal to x
gthan	maybenum@[ >. ]		maybenum@:[ *./@:<: ]		Must be greater or equal than x	
lthan	maybenum@[ <. ]		maybenum@:[ *./@:>: ]		Must be lesser or equal than x
inrange	'unconvertable' raiseErr ]	maybenum@:[ inrange  ]		Must be within range
)
wd2=: 3 : 'wd y'
typeparser =: boxopen L:1@:(> L:1)@:([: (4 : 0)/ '&'&cut)
  (}: , (}. y),~ [:< ({. y) ,~&< {:) ;: >x
)
typeparser =: (<<,'&') -.~ each (</.~ +/\@(-.@+. _1&|.)@:=&(<,'&'))@:;:
typeparser =: (<<,'&') -.~ each (</.~ +/\@(+: _1&|.)@:=&(<,'&'))@:;:
c =: 1 : 0
a =. typeparser m
o =. ]
for_i.  a do. d =.  linearize >^:(1 < L.)^:_ i  NB.'&' cut > i
b=. ({~ ({: d) i.~ {."1) TYPES
if. 1 < # d do. o =. ((0 Y d) (1 Y b) eval  ^: (-.@:((2 Y b) eval)) ]) @:o f.
  else. o =. (1 Y b) eval  ^: (-.@:((2 Y b) eval)) @:o f. end. end.
1 : ('u hook (', o f. lrA , ' ) ')
)


v =: 1 : 0
a =. typeparser m
o =. ]
for_i. boxopen a do. d =.  linearize >^:(1 < L.)^:_ i NB. '&' cut > i
b=. ({~ ({: d) i.~ {."1) TYPES
if. 1 < # d do. o =.  ((3 Y b) assert sfX (0 Y d) (2 Y b) eval ]) sfX @:o f.
  else. o =.  ((3 Y b) assert sfX  (2 Y b) eval) sfX @:o f. end. end.
1 : ('u [ (', o f. lrA , ')')
)

ceach =: 4 : '] x c y' each
veach =: 4 : '] x v y' each


iv =: 1 : 0  NB. gives input box to correct validation err if fail.
a =. typeparser m
o =. ]
for_i. boxopen a do. d =. linearize >^:(1 < L.)^:_ i NB. '&' cut > i
b=. ({~ ({: d) i.~ {."1) TYPES
if. 1 < # d do. 
 o =.  (] ( [: wd2'mb input text "' , (0 Y b) , '" "' , (3 Y b) ,'" *' , ":@:[)`[@.]  (0 Y d) (2 Y b) eval ]) @:o f.
  else. o =.  (] ([:  wd2 'mb input text "' , (0 Y b) , '" "' , (3 Y b) ,'" *' , ":@:[)`[@.]  (2 Y b) eval)  @:o f. end. end.
  NB. else. o =.  (] ([: wd2 'mb info " ' , (0 Y b) , '" "' , (3 Y b) ,' " '"_ )@:[^:-.@]  (2 Y b) eval)  @:o f. end. end.
NB. pD o lrA
 1 : ('u hook (', o f. lrA , ')')
NB. o
)

cV =: 4 : '] x c y' 
vV =: 4 : '] x v y' 
ivV =: 4 : '] x cv y' 
ci =: [ cV ivV  NB. verb that will first give input box check for failed validations, then coerce values.

PolyAppend =: ([ , (('num';'str') {::~ 2 = 3!:0) cV Fxhy ]) NB. coerces left argument to match type of right arg so that , works as in ruby/python.

NB. 'as ' PolyAppend 3
NB. 2 PolyAppend '3'