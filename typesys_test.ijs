require jpath '~/typesys.ijs'

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

coclass 'base'
coinsert 'typesys'

SCRAPEDATA =: ({. , [: < [: ;: inv }.  )@:;: &> cutLF 0 : 0
Montreal 4 Celcius
Paris 12 
NYC 44F
Miami 77 Far
ISS 6 K
Moon 111 moonK
)
NB. function with type anotation: takes 2 item items, with one string, and one Farenheit temperature.
testf =: [: 3 : 0 ( 'str';'inCelcius inFaren2') cV_temperature_  each "1 ]
pD ] y
+/ 1 Y"1 y
)

testC =: [: ". each 0 : 0 cutLF@:[ ]
 +/ ] 'inCelcius' c_temperature_ &> 44 ;'99F';'7K'; ' _20 Faren.'; '300 Kel.'
 +/  (< 'inCelcius') cV_temperature_ &> 44 ;'99F';'7K'; ' _20 Faren.'; '300 Kel.'
 2 +/  hook ] ('inCelcius') c_temperature_ &> 44 ;'99F';'7K'; ' _20 Faren.'; '300 Kel.'
 +/  (< 'inCelcius') ci_temperature_ &> 44 ;'99F'
 ] ('inCelcius inFaren') c_temperature_ &> 44 ;'99F';'7 K'; ' _20 Faren.'; '300 Kel.'  NB. convert to C then to F
 ] ('inFaren') c_temperature_ &> 44 ;'99F';'7 K'; ' _20 Faren.'; '300 Kel.'
 +/ ('inCelcius inFaren') c_temperature_  '44', '44C' ,'99F','7 K', ' _20 Faren.',: '300 Kel.'  NB. if not boxed, then direct verb possible. (otherwise each affects passed verb)
)

test =: [: ". each 0 : 0 cutLF@:[ ]
+: 'num' v  'num 2&count' c  '123 44 55'
3 +'int 3&gthan 8&lthan' c '4 5 8 2'
2 +'int 3&gthan' ([ cV ivV) 4 5 8 2
2 + ' int 3&gthan' ci  'int' c '4 5 8 2'
+: 'num' v '2&count' c 'num' c each '123';123 44 55
+: 'num' v  'num 2&count' c each '123';123 44 55
('num';'2&count') ([  cV each {.@:[ cV each ivV each) '123';123 44 55
)

pD testf SCRAPEDATA