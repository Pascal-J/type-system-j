

pD_z_ =:  1!:2&2
of_z_ =: 4 : 'x ,''_'', '' ''((i.~ }. ]),~''_'', ~ i.~ {. ]) > y'("1 0)
in_z_=: 2 : 'm ,&(,&''_'') n'  NB. build a name
fr_z_=: 2 : '(m in n)~'          NB. evoke a name
loc2=: (,&'_'@>@[ ,&'_'@, ":@>@])
loc_z_=: (,&'_'@[ ,&'_'@, ":@>@])"1 0
adjust4loc_z_ =: 4 : 'y , '' '', x'L:0
from2_z_=: ".@loc
fromA_z_ =: 1 : 0 NB. in caller's locale, but set words by index m to y locales and exec 1 sentence per y locale.
:
o=. (< y) loc~ each amend u ;: x
if. 1<# y do. o=.;: inv  |: <"1 &> (#y)(# ,:)each amend (u deleteitems i.# ;: x) o
else. o =. ;: inv"1 o end. ". o
)
from_z_=: ".@:of
assign_z_ =: 4 : '(x) =: y'
lassign_z_ =: 4 : '(x) =. y'
space_z_ =: ([ , ' ' , ])
spaceR1_z_ =: ([ ,. ' ' ,. ])
inl_z_ =: (cocurrent@] ".@] [)"1 0
finallyC_z_ =: 2 : 'u :: ((v)][:13!:12(''''[]))'
flag1_z_ =: (] controlA_z_ =: 1 : ('flag1_z_ =: 1';'o=. u y';'flag1_z_ =: 0';'o';':';'flag1_z_ =: 1';'o=. x u y';'flag1_z_ =: 0';'o') ( finallyC_z_ ('flag1_z_' assign 0:))) 0
ABSflag_z_ =: (] ABS_z_ =: 1 : ('ABSflag_z_ =: 1';'o=. u y';'ABSflag_z_ =: 0';'o';':';'ABSflag_z_ =: 1';'o=. x u y';'ABSflag_z_ =: 0';'o') ( finallyC_z_ ('ABSflag_z_' assign 0:))) 0
ifC_z_=: (`])(@.([: -. [: ". 'flag1_z_'"_))
ifABS_z_=: (`])(@.([: -. [: ". 'ABSflag_z_'"_))  
pDi_z_ =: pD_z_ ifC_z_
ORdef_z_ =: ".@[^:(_1< 4!:0@<@[)
empty2x_z_ =: [^:(0=#@:])
NULL_z_ =: i.0
tonull_z_ =: (0 $ 0:)^:((0 -: {.@:$) *. [: -. NULL -: $)

eval_z_ =: 1 : ' a: 1 :  m'
rifN_z_ =:  (1 : 'if. 0 = 4!:0 < ''u'' do. m&[ else. u end.')
amend_z_ =: 2 : 0  NB. v is n or n{"num
s=. v"_ y
(u (s{y)) (s}) y 
:
s=. v"_ y
(x u (s{y)) (s}) y 
)
amendT =: 2 : ' u hook (n { ]) n} ]'
amendL0_z_ =: 2 : 0  NB. v is n or n{"num
s=. v"_ y
NB. pD s
NB.pD ($ each ; [)(u (s{ L:0 y))
(u (s{ L:0 y)) (s}) L:0 y 
:
if. 0 = 4!:0 <'v' do. s =. v else. s =. v y end.
(x u (s{ L:0 y)) (s}) L:0 y 
)
amendeach_z_ =: 2 : 0
s=. v"_ y
(u (s{ each y)) (s}) each y
:
if. 0 = 4!:0 <'v' do. s=. v else. s=. v y end.
(x u (s{ each y)) (s}) each y
)
pF_z_ =: 1 : 0
:
a =. x sprintf"1 0 y
a u y
)

BoxedColumnExamples =: 0 : 0
'+: >  ]2{' Amend__int3  2 44 55 77 NB.  for int 3 containing 3+ columns, double the value of column 2
'3  (0 4})L:0 ] 1{ 5 {. (L:0) D' from S__int3
 (3; 2) (0 2)}"1  <"0  i. 5 3 NB. for item boxed, update indexes for columns 0 and 2, with value 3 for 0, and 2 for 2.
 (3;7;8;<<'Fid') [`(2"_)`]}&.> (<"1 &. |:  i. 5 3), < <"0 'ABCDE'
 (0;1;2;'f')"1   amendL0 (i.3) (<"1 &. |:  i. 5 3), <'ABCDE'
 ((<'f') ,~ |.@:}:)"1 amendL0 2 3 (<"1 &. |:  i. 5 3), <'ABCDE'
 (5;2)"_  amend (0;1)  amendL0 (1) (<"1 &. |:  i. 5 3), <'ABCDE'
 (*:@>@{: ; +:@>@{.)  amend (0;1)  amendL0 (1) (<"1 &. |:  i. 5 3), <'ABCDE'
)

cocurrent 'z'

coinsert=: 3 : 0
n=. ;: :: ] y
 p=. ; (, 18!:2) @ boxopen each n
 p=. ~. ( 18!:2 coname''), p
(p /: p = <,'z') 18!:2 coname''
)

coinsertz =: 3 : 0
noz=. -.&(<,'z')
n=. ;: :: ] y
pD p=. ; (, 18!:2) @ boxopen each n
pD p=. ~. ( noz 18!:2 coname''), noz p
( p , <,'z') 18!:2 coname''
)

v2c =: 1 : ' 2 : (''u '' , u lrA , '' v'')'
a2d =: 1 : 0 NB. turns adverb into dyad (so that rank or other modifiers can be applied to it).  adv must take noun arg.
4 : ('x ', u ,' y')
)
a2d =: 1 : '4 : (''x ('', u ,'') y'')'
a2v =: 1 : 0 NB. for dyad adverb, where adverb takes noun arg.  ie (3 1,: 6 2) '}' a2v reduce i.5
4 : ('''a b'' =. x label_. a (b(', u  , ')) y')
)

Fork =: 1 : ' 2 : (''u"_ '' , ''('', u lrA , '')'' , '' v"_'')'
Fork =: 1 : ' 2 : (''u '' , ''('', u lrA , '')'' , '' v"_'')'
Between =: 2 : ' 1 : (''[: ('' , u lrA , '') [: '', '' u ('' , (v lrA) ,'')"_'')'
B =: 2 : '(@: u)(v @:)'
Bwy =: 2 : ' 1 : (''] ('' , v lrA , '') [: '', '' u ('' , (u lrA) ,'')"_'')'
NB. Bwy =: 2 : '(] v u)' 
BetweenE =: 2 : ' 1 : (''([: ('' , u lrA , '') [: '', '' u ('' , (v lrA) ,'')"_) :: (''  , u lrA , '')'' )'
Betweensfx =: 2 : ' 1 : (''(('' , u lrA , '') ] [: '', '' u ('' , (v lrA) ,'')"_) :: (''  , u lrA , '')'' )'
NB. key value boxed data.  All verbs use y as the kv store, and x as the query/new val
NB.kvgi =: #@:]  _:`]@.> ([ i.~  (0&{"1@:]))"0 _
xfilltoy =:  ,.@:[ {.@:, [: {. ] , ,.@:[
iorinf =: (#@[ _:^:= i.)
NB.getorinf =: ^:@:iorinf~
kvgix =: #@:{.@:]  _:`]@.> ([ i.~  (0&{@:]))"0 _
kvgi =: #@:{.@:]  _:`]@.> (boxopen@[ i.~  (0&{@:]))"1 _
kvgi =: #@:{.@:]  _:`]@.> (<@:[ i.~  (0&{@:]))"1 _
kvadd =: 4 : 0 NB.  add appends value if some exist for key
NB.x=. , leaf amend  0 x
if. 0=# y do. kvlabel&>/ x return. end.
i=. ({.x) kvgix y =. (,.`]@.(2=#@$)) y
NB.if. _=i do.  y ,."_ 1 x else. ,&(>}. x) L:0 amend (<1,i)  y end.
if. _=i do.  y ,."_ 1 x else. ,&(> scalarize }. x) each amend (<1,i)  y end.
NB.if. _=i do.  y ,"_ 1 x else. ,&(>}. x) L:0 amend (<1,~i)  y end.
)
kvaddA =: 1 : 0 NB. kvadd without duplicates. u verb"_ or noun to add if not in list. u should likely ignore y. match does not deal with fills.
:
 y"_`((x , <@:(u"_))kvadd y"_)@.((u"_) -.@>@(e. L:1) ]) (x) kvgv y
)
kvaddA =: 1 : 0 NB. kvadd without duplicates. u verb"_ or noun to add if not in list. u should likely ignore y. match does not deal with fills.
:
 y"_`((x ,&<(u"_))kvadd y"_)@.((u"_) -.@>@(e. L:1) ]) (x) kvgv y
)
kvset =: 4 : 0 NB. set replaces value. empty start ok.
NB.x=. , leaf amend  0 x
if. 0=# y do. kvlabel&>/ x return. end.
NB.i=. ({.x) kvgix y =. (,.`]@.(2:=#@$)) y [ d=. (> scalarize }.x)
i=. (> {.x) kvgi y =. (,.`]@.(2:=#@$)) y [ d=. (> scalarize }.x)
NB.if. _=i do.  if. 0<# d do.y ,."_ 1 x end. else. if. 0<# d do. d"_ L:0 amend (<1,i) y 
if. _=i do.  if. 0<# d do.y ,."_ 1 x end. else. if. 0<# d do. d"_ each amend (<1,i) y 
else. (i{."1 y) ,"1 (>:i)}."1  y end. end.
)
NB.kvgv =: ((1&{@:]) {~  boxopen@[ i.~  (0&{@:]))"0 _ :: empty
kvgv2 =: ((1&{@:]) {~  <@:<@:[ i.~  (0&{@:]))"1 _ :: empty
kvgv =: ((1&{@:]) {~  boxopen@:[ i.~  (0&{@:]))"1 _ :: empty
kvgv =: >@:((1&{@:]) {~  <@:[ i.~  (0&{@:]))"1 _ :: empty
kvgk =: ((0&{@:]) #~  >@: (+./L:0) @:([ e.~ L:0  (1&{@:])))"0 _ :: empty NB. keys that include element.  Fails if values contain nexted k,v
kvgk =: >@:((0&{@:]) #~  >@: (+./L:0) @:([ e.~ L:0  (1&{@:])))"0 _ :: empty NB. keys that include element.  Fails if values contain nexted k,v
kvgkb =: (0&{@:] #~ ,@:>@:([ (e.~L:1) 1&{@:]))"0 _ ::empty NB. probably less buggy than kvgk
kvlabel =: boxopen@[ , boxopen@:]
kvlabel =: <@:[ , <@:]
nv_z_ =: 3 :  0
if. L. y do.  '(> ; 5!:5 )"0  nl 0' inl y else. (] , [: < [: ,. [: cutLF 5!:5)"0  nl y  end.
:
if. L. y do.  ('(> ; 5!:5 )"0 ', x ,' nl 0') inl y else. (] , [: < [: ,. [: cutLF 5!:5)"0 x nl y  end.
)
NB. simple version without verbs
quoteortostring =:  ":`quote@. (2=3!:0)

NB. kv struct that always returns answer. with default item 0
NB. Boxed noun keys are searched first.  If result is unboxed string, it is assumed to be a function and doSafe'd to see answer.
NB. result of functions must be indexes (or integers.  If fail to produce valid index, next function evald).  If value is boxed it is returned.  unboxed string is evald as before.

NB. Needs to have static lookup keys boxed, to support multiple (nested) indexing
kvgetsomething =: 4 : 0
pD hx  =. {. boxopen x
pD rx =. {.^:(1=#)@:}. boxopen x
if. 0=# hx do. throw. end.
if. 0< # pD r =. (> hx) kvgv2 y do. pD rx;r NB. if. 0=#rx do. r return. else.
NB.if. 0< # pD r =. ( hx) kvgv y do. pD rx;r NB. if. 0=#rx do. r return. else.
try. (rx&kvgetsomething)^:((0=L.)+. 0<#) >r catcht. pD {.{: > r end. return.  end. 
NB. try. (rx&kvgetsomething)@:>^:((0=L.)+. 0<#) r catcht. pD {.{: >r end. return.  end. end.
pD fi =. I. (2=3!:0) &> {. y NB. string keys
for_f. fi do. try. pD ri =. doSafe pD ( > f{ {. y) , ' ' , quoteortostring > hx catch. ri=. _ end.
if. ri <  pD # pD > f{ {: y do. try. hx&(kvgetsomething pD)^:((0=L.)+. 1<#) pD  >ri{  >f{ {: y    catch. pD {.{: y end. return. end. end.
NB. if. ri < # f{ {: y do.  rx&(kvgetsomething pD)^:((0=L.)+. 1<#)   >ri{ >f{ {: y  [ pD ((0=L.)+. 1<#) >ri{ >f{ {: y [ pD rx return. end. end.
 {.{: y  
)
kvgs =: [: >^:(1 <L.)^:_ kvgetsomething


link=: ,&:boxopen"1
Boxlink =: boxopen each@:,&<
boxitems =: (<"0)`(<"1)@.(1<#@$)
boxAsRows =: <"_1 L:1 ^:(1 >. <:@#@$)
reduce =: 1 : (':'; 'u boxscan (<"_1 x), < y') 
reduce =: 1 :'>@:(u&.>/)@(<"_1@[,<@])'
reduce2=: boxscan(@:(<"_1@:[ , <@:]))

boxscan =: &.>/(>@:) NB. applies u/ to any shape x and any shape y, as long as they are joined <x,<y
assignwith =: 1 : ('y assign u (y~ [ ]) :: ((i.0)"1) 1';':';'y assign x u (y~ [ ]) :: ((i.0)"1) 1')
NB. lassignwith=: 1 : ('y lassign f. u y~';':';'".''y lassign f. x u y~''') 
assignwithC =: 2 : ('y assign u (y~ [ ]) :: (n"_) 1';':';'y assign x u (y~ [ ]) :: (n"_) 1 [pD n;($x);y')
defaults1 =: ([`]@.(0=#@>@[))
defaults =: defaults1"0 0 f.
fixlenx =: 1 : (':';'(scalarize (#y) {. x) u y')
dflt =: defaults fixlenx & boxopen 
rangei =: [ +  >:@] i.@- [

NB. buildvar takes optional numeric right arg, and corrects for numeric
joinB =: (1 : ' ((- # m)&}.@;@(,&m&.>"1))')(@: (] : ;))
nums2name =:  'NUM' joinB@:cut@:(('.';'F') rplc~ ('_';'n') rplc~ ":)^:(1 4 8 16 64 128  e.~ 3!:0)
boxsandnums2name =: [: (('B0X_',:'B0oX') strbracket '_' joinB )^:(32  = 3!:0 ) L:1 ^:_ ^:(1 <L.) nums2name L:0
boxsandnums2name =: ([: (('B0X_',:'B0oX') strbracket '_' joinB )^:(32  = 3!:0 ) L:1 ^:_  nums2name L:0) 
text2name =: ('_' joinB)@:,&boxopen&([: cut (AlphaNum_j_, ' ')&(-.~ -.~ ]))^:(2 = 3!:0)

buildvar =:  ([: '_' joinB  [:  ('_' joinB)@:,&boxopen&boxsandnums2name&.>&text2name text2name L:0 )@:(] :;)
buildvar =:  ([: ('_'joinB)@:('_'&cut)@:('_'joinB)  [:  ('_' joinB)@:,&boxopen&boxsandnums2name&.> text2name L:0 )@:boxopen@:(] :;)
NB. x is low;high boxed an additional layer if they will be compared to boxed data.
takerange =: 4 : ('''a b'' =. x';'(a i.~ y) rangei b i.~ y')
coerce =: 2 : ']`u@.v'
ifitems =:  ^:(0<#)
notfalse =: 0:`((0~: ]) *.(a:~:]))@.(0<#@:])(+./@:) NB. :: 0:
notfalseNoun =:   0:`(notfalse@:(3 : 'y~'))@.isNoun NB. 3 : 'if. isNoun y do. a=. y~ else. a=.0 end. notfalse a'
notfalseNumberorBox_z_ =: (0&~: *. a:&(-.@-:) *. 2 131072 -.@:+./@:= 3!:0"_)`(0:"_)@.(NULL&-:)(*./@:)
notfalseNumber_z_ =: 0:`(0&~: *. 2 131072 32 32768 -.@:+./@:= 3!:0"_)@.(0 < #)(+./@:)
tonumifnum =: 0&".^:(1&". -: 0&".)
booltest=: [: -. [: *./ 0 = ,
scalarize =: {.^: ((,1) -: $) NB. 3 : ' if. (1=$)y do. {.y end.'
linearize =: (, $~ 1 -.~ $) 
stripEmptyTrail =: }:^:(a: = {:)
strbracketF =: 0&{::@:[ , ] , 1&{::@:[
strbracket =: (0&({)@:[ , ] , 1&({)@:[)
strbracketC =: 2 : 0
1 : ( '''' , m , ' ''' , ', (": u lrA) ,' , ''' ', n ,'''')
)
parenA =: '()'&strbracket@:
lr_z_ =: 3 : '5!:5 < ''y'''
lrA_z_ =: 1 : '5!:5 < ''u'''
quotejuststrings =:  quote^:([: *./ '''' = {., {:) each &. ;:
lrq =: quotejuststrings@:lr
hook_z_ =: 2 : '([: u v) : (u v) '
rhook_z_ =: 2 : ' (u~ v)~ '

ar =: 1 : '5!:1 <''u'''
makecompute_z_ =: 1 : ('u ar  Boxlink  y';':';'u ar  ,&<  x ,&< y')
makecompute_z_ =: 1 : ('u ar  (;<) < y';':';'u ar  (;<)  x (;<) y')

NB.addCompute_z_ =: 3 : 'computations =: (''computations'' ORdef i.0) , < y'
addCompute_z_ =:  ] (, 1 2&$ )~ assignwithC EMPTY [
addC_z_ =: 2 : ' v"_ addCompute u makecompute'

compute_z_=:  3 : 0 "1
if. 0=L. y do. if._1= 4!:0 < y do. return. else. o [ erase y [o=. compute y~  return. end. end.
a=. (> {. y) 
if.  1=# > {: y do. if. 2= 3!:0  a do. (>{: y )5!:0 a eval  else.  (a 5!:0)  >>{: y end.
else. (a 5!:0 boxscan) >{: y end.
)
inlC_z_ =: 2 : 0 
 (([: <^:(0=L.) v"_) inl~ m , ' ', lr@:]) :  (([: <^:(0=L.) v"_) inl~ (lr@:[), ' ' ,m , ' ', lr@:] )
)
inlA_z_ =: inlC ([: 18!:5 ''"_)
inlA_z_ =: 1 : 'u inlC  (18!:5 '''')'
mode_z_ =: 2 : '([: ]chkerrA [: v inv  u mkerr  hook v)' 

mkerr_z_=: (((1 1$0)&boxeach)@:) ( :: ((13!:11 ; 13!:12)@:(''"_)))
stringiserr_z_=: mkerr ((999;  1&{::) ^:((0=0&{::) *. 2= [:(3!:0) 1&{::)@: )
chkerr_z_=: ;@:}. ^:((1 1$0) -: >@{.)
sanitize_z_=: [: 'createnotallowed'"_^:('create'-: ]) (0&pick)@:;: ^: (2 = 3!:0)
rexec_z_=: (sanitize@:>@{.@:] loc [) apply mkerr }.@:]
boxeach_z_=: ,&<
chkerrA_z_ =: (hook ;)(hook }.)(^:((1 1$0) -: >@{.@:]))

locs_z_ =: 1 : 'm loc 18!:5 '''''
locV_z_ =: 3 : 'y loc pD 18!:5 '''''
curloc_z_ =: [: 18!:5 ''"_
locSelf_z_ =: locs ~
locSelfC_z_ =: locs(3 :)(@:])
isNoun_z_ =: (0 = 4!:0 ( :: 0:))@:< 
locAeval_z_ =: 2 : '(m locs, '' '',  n locs) eval '
A_z_ =: 1 : 'u'
locsE_z_ =: locAeval 'hook ] A'
loC =: 2 : 'm loc n'
CONJs_z_ =: 2 : 'v eval u'
CONJ_z_ =: 2 : ' u (v eval)'
insertitem =: 1 : '(u"_ {. ]) , [ , u"_ }. ]'
cutdef =: (0 :) 1 : 'cutLF m'
Par =:   1 : 0 
 if. 0=L.y do.  d =. (#@:;: p) $ a: [ p =. y  else.  d=. (#@:;: p) $ }. y [ p =. > {. y  end.
 (((quote p) , '=. y defaults fixlenx ' , lr d) link  m) 
:
  if. 0=L.y do.  d =. (#@:;: p) $ a: [ p =. y  else.  d=. (#@:;: p) $ }. y [ p =. > {. y  end.
  if. 0=L.x do.  dx =. (#@:;: px) $ a: [ px =. x  else.  'px dx'=. x  end.
 (((quote^:(1<# ;: p) p) , '=. y defaults fixlenx ' , lr  scalarize d) link ((quote^:(1<# ;: px) px) , '=. x defaults fixlenx ' , lr  scalarize dx)) ((<,':') >:@:i.~ ]) insertitem^:((<,':') e. ]) ((quote^:(1<# ;: p) p) , '=. y defaults fixlenx ' , lr  scalarize d)  link  m 
)
Argadd =: 1 : 'm ;< y'
ArgaddC =: 2 : ('u n (;<) y';':';'x u n (;<) y')
Decorator_z_ =:  2 : 0
 if. 0=L.n do.  d =. (#@:;: p) $ a: [ p =. n  else.  d=. scalarize (#@:;: p) $  }. n [ p =. > {. n  end.
 a =. ((quote ^:(1<# ;: p) p) , '=. >({.y) defaults fixlenx ' , lr d ) link 'y =. >{: y' link m  
  (((quote ^:(1<# ;: p) p) , '=. >({.y) defaults fixlenx ' , lr d ) link 'y =. >{: y') ((<,':') >:@:i.~ ]) insertitem^:((<,':') e. ])  a
)

itemamend =: 4 : '((2}.$y) $"1 0 x)} y'
filtermod =: 2 : 'v itemamend ] ,: v # inv [: u v # ]' 
NB. (<'aa')"0  filtermod (('sdf')&-: &>) &. ;:'sdf sdfsdf sd fds sdf'
filtermodA =: 1 : 'u itemamend ] ,:  (#inv~ u)'
curry =: 4 : '(boxopen y) (a: = ]) filtermodA x'
curryB=: 2 : 'u hook (n&curry)'
ql=: 2 : '(quote m) , n'
eb =: evalbind =: 4 : ' x eval y'
ebA =: 1 : ('m eval y';':';'x m eval y')
ebN =: 4 : 'x eval rifN y'
ebNR =: 1 : 'm ql '' & ebN'' locs & ebN'
setvE =: 1 : 0 NB. same as setverbV except string is eval'd instead of latebound to 3 : .  Other params are also early bound.
if. -. isNoun 'u' do. u return. end.
if. 0=L. m do. (m , '"_')& eb return. end.
if. 2=#m do. (((> {.m)loc {:m) , '"_') eval return. end.
if. 1=#m do. 3 : (> m) return. end.
m `:6
)
