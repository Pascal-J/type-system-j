MYDIR =: getpath_j_  '\/' rplc~ > (4!:4<'thisfile'){(4!:3)  thisfile=:'' NB. boilerplate to set the working directory
require MYDIR , 'typesys.ijs'


coclass 'temperature'
NB. example to modify type system with user types and functions.  Assumes raw data is in Celcius
coinsert 'typesys'

NB. add to TYPES by copying this line in any other module
TYPES =: TYPES_typesys_ , (9{a.) cut &> cutLF 0 : 0
inCelcius		toCelcius		1 4 8 e.~ 3!:0	Must be convertable to Celcius
inFaren		toFaren		0:		Must be convertable to Farenheit
inFaren2		toFaren2		0:		Must be Celcius Number (use inCelcius first)
)
NB. converts strings to Celcius depending on F or K 

toCelcius =: ( 3 : 0 ) (^: (2 =  3!:0))
 NB. if. (2 = 3!:0) y do. num =. 0 ". '1234567890.' (] -. -.~) y  else. y return. end.
num =. 0 ". '_1234567890.' (] -. -.~) y select. linearize 'fk' I.@:e. tolower y case. 0 do. x: inv 5r9 * num - 32 case. 1 do. num - 273.15 case. do. num end.
)
NB. bug with hook and multiline explicit expressions (bug with ending ')')
toCelcius =: ( 3 : 'num =. 0 ". ''_1234567890.'' (] -. -.~) y select. linearize ''fk'' I.@:e. tolower y case. 0 do. x: inv 5r9 * num - 32 case. 1 do. num - 273.15 case. do. num end.' ) (^: (2 =  3!:0))"1

NB. must convert text and numbers to Farenheit.  Raw number assumed to be C.  So this always coerces, and fails validation
toFaren =: 3 : 'if. (2 = 3!:0) y do. num =. 0 ". ''_1234567890.'' (] -. -.~) y  else. x: inv  32 + 9r5 * y return. end. select. linearize ''fk'' I.@:e. tolower y case. 0 do. num  case. 1 do. x: inv  32 + 9r5 * num - 273.15 case. do. x: inv  32 + 9r5 * num  end.'"1
toFaren2 =: ([: x: inv  32 + 9r5 * ])"0  NB. simpler if data already coerced to celcius

cocurrent 'base'
coinsert 'typesys'

NB. extra sample
PolyAppend =: ([ , (('num';'str') {::~ 2 = 3!:0) cV Fxhy ]) NB. coerces left argument to match type of right arg so that , works as in ruby/python.
NB. 'as ' PolyAppend 3
NB. 2 PolyAppend '3'

SCRAPEDATA =: ({. , [: < [: ;: inv }.  )@:;: &> cutLF 0 : 0
Montreal 4 Celcius
Paris 12 
NYC 44F
Miami 77 Far
ISS 6 K
Moon 111 moonK
)
NB. function with type anotation: takes 2 item items, with one string, and one Farenheit temperature. Makes sure to fail if not 2 items per item
testf =: [: 3 : 0 ( 'str';'inCelcius inFaren2') cV_temperature_  each '2&count' v_temperature_ "1 ]
pD ] y
'average temp: ' , ": (+/%#) 1 Y"1 y
)

test =: 'no test crashed' [ [: pD@:".@:(pD@:('  ', ":) sfX) each 0 : 0 cutLF@:[ ]
+: 'num' v  'num 2&count' t  '123 44 55'
3 +'int 3&gthan 8&lthan' t '4 5 18 2'
2 +'int 3&gthan' ([ tV ivV) 4 5.3 8 2
2 + 'intR 3&gthan' ci  'int' c '4 5.6 8 11'
+: 'num' v '2&count' t 'num' c each '123';123 44 55
+: 'num' v  'num 2&count' cp each '123';123 44 55
('num';'2&count')  cV each  '123';'abc'    NB. independent validations for independent parameters
'num' cV"1 0 '12344'
 +: 'num' t"0  '12344'
] 'num 2&gthan 't every 3;'4'
strict_typesys_ 1 		NB. strict 1 (no localization) would change type strictness in just this (base) locale
] 'num 2&gthan 't each 3;'4'
strict_typesys_ 0		NB.
2 ('num'vV PolyAppend)/ '345 234 3'
] 'int 2&gthan' vb  '6' ; 3 ;1 ;2 ;4 ;5.3	NB. vb applies each automatically returns open boolean list
#~ 'num 2&gthan' vb  '6' ; 3 6;1 2 ;4 5.3	NB. all types must match for vb to return 1
+: 'int 2&gthan' vbs  'int' c 3 1 2 4 5.6	NB. int is flakey in that if there is one float in unboxed list, they are all floats.  vbs is vbwith selection applied to another verb. identical pattern with other type processors.
+: 'int 2&gthan' off  'int' off 3 1 2 4 5.6	NB. all type processors are compatible and can be turned (replaced by) off
)

testC =: 'no test crashed' [ [: pD@:".@:(pD@:('  ', ":) sfX) each 0 : 0 cutLF@:[ ]
 +/ ] 'inCelcius' t_temperature_ &> 44 ;'99F';'7K'; ' _20 Faren.'; '300 Kel.'
 +/ 'str&unboxed inCelcius' t_temperature_  44 ;'99F';'7 K'; ' _20 Faren.'; '300 Kel.'   NB. efficiency due to fewer coerce passes.
 +/  (< 'inCelcius') cV_temperature_ &> 44 ;'99F';'7K'; ' _20 Faren.'; '300 Kel.'
 2 +/ ('inCelcius') t_temperature_ &> 44 ;'99F';'7K'; ' _20 Faren.'; '300 Kel.'
 +/  (< 'inCelcius') ci_temperature_ &> 44 ;'99F'
 ] ('inCelcius inFaren') t_temperature_ &> 44 ;'99F';'7 K'; ' _20 Faren.'; '300 Kel.'  NB. convert to C then to F
 +/ :: ('was not all numeric'"_)@:pD 'num&unboxed 't_temperature_ '44','44C','99F','7 K',' _20 Faren.',:'300 Kel.'
 ] ('inFaren') c_temperature_ &> 44 ;'99F';'7 K'; ' _20 Faren.'; '300 Kel.'
 +/ 'num&unboxed inFaren2' t_temperature_ '1';4;'sdf'
 +/ ('inCelcius inFaren') t_temperature_  '44', '44C' ,'99F','7 K', ' _20 Faren.',: '300 Kel.'  NB. if not boxed, then direct verb possible. (otherwise each affects passed verb)
 testf SCRAPEDATA
)

mkerr_z_=: (((1 1$0)&boxeach)@:) ( :: ((13!:11 ; 13!:12)@:(''"_)))
mkerr_z_=:  :: ((ERROR ; 13!:11 ; 13!:12)@:(''"_))
chkerrA_z_ =: (hook ;)(hook }.)(^:((1 1$0) -: >@{.@:]))
chkerrA_z_ =: `](@.((< ERROR) -: {.@:]))

vmtest =: 'no test crashed' [ [: pD@:".@:(pD@:('  ', ":) sfX) each 0 : 0 cutLF@:[ ]
   ( 2 + mkerr 4)         NB. mkerr creates a maybe value (,. 0) if no error
   ( a: + mkerr 4)        NB. left value not ,. 0 is an error, with right value error text
  +: chkerrA ( a: + mkerr 4)  NB. chkerrA (adverb) either returns the previous error 
  +: chkerrA ( 2 + mkerr 4)   NB. or u parameter computes the value.
  4 + M +: chkerrA ( a: + mkerr 4)  NB. M is like chkerrA, but also accepts raw data (in addition to Maybe structures)
  4 + M +: chkerrA ( 2 + mkerr 4)
  +:    'int 0&gthan' vm i: 3  NB. vm returns "maybes" or results
  +:    'int 0&gthan' vm i. 3
  '5' ('num'&cpV   +M Fxhy  'int 0&gthan _1 3&inrange'&vmV) each i: 4    NB. call with each to get boxes of results and errors
  +: M each (5   +M  'int 0&gthan _1 3&inrange'&vmV) each i: 4    NB. M allows chaining to other functions.
  (5   +M 'int 0&gthan'&vmV) each (;/ _5.1 5.1) , ;/ i: 3     NB. failure of int
  +: M each  (5 + mkerr 'int 0&gthan _1 3&inrange'&cpV) each i: 4   NB. cp can't deal with range coercion (not implemented).  so mkerr can be used to safely pass results that may include domain errors.
)
