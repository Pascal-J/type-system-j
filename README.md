# type-system-j
The J language is ultradynamic in that functions usually have no named parameters much less typed parameters.  These files add an optional type system to the J language.

to use, put all files in your home folder.  If placing them elsewhere, change paths for require lines.  typesys_test file will load the other file.

**definition of a type**: A type is a name given to any function that returns a boolean classification of its input.  And does so within a general context of guarding input to other functions.

The benefits of a type system include

* catch errors in parts of a program due to changes in another part
* document use of functions
* Help compilers optimize code

Nice to have features that this J system provides are:

**Type system should be optional**

regardless of above advantages, optional typing allows quicker to write and shorter programs.

**Type system should be user defined**

regardless of compiler advantages a function can be defined to operate on any number.  Not just a specific narrow type of number.  A function that takes an X,Y point should be able to take any pair of numbers.

**Type system should be able to validate whole arguments (record validation vs field validation)**

A type system exists primarily to validate input, and so some type validations should also operate on the entire parameters.  For example, ensuring/enforcing an argument count, or ensuring parameters are a sorted list.

**Type system should be useable to coerce input rather just raise errors**

Just as types can be too inconvenient to use because they too narrowly confine input, they become vastly more convenient if you can use the same type annotation as a way to automatically convert/coerce "bad" input.  A type system can be used to make dynamic languages more dynamic or more strict, by using the type system the way you prefer.

**Type system should allow parameterization**

A parameterized type is a type that takes a parameter.  '2&count' is a type that validates the function as having 2 parameters.  '0 255&inrange' takes 2 parameters and ensures that a field is within the range of 0 to 255.  Parameterized types allow for much fewer type definitions.

**Type system should allow compounding**
The type 'num 0 255&inrange' is a compound type that if it is in coercion mode, will first coerce the field to numeric, and then coerce it to be in range of 0 to 255.  In the typesys_test.ijs file is a toy sample class to work with temperature data.
The compound type 'inCelcius inFaren2' converts text data into numbers representing Celcius temperatures, and then inFaren2 is a simple function to convert Celcius numbers to Farenheit numbers.  Compound types allow coercion chains where rightmost elements can depend on left coercions for their input format.  In the latter case the function expects to receive Celcius temperatures but will work with farenheit temperatures.

**Type system should allow several interactions with types with change of a single keyword**
coercion and hard validation are the 2 main alternatives.  But then so is validating each item of input, and then so is filtering based on valid input.  An in-between state between coercion and validation is to coerce but leave a trace message of what was coerced, and this further allows selection upon a continuum of dynamic vs. static typing.

# Using the type system

Coercers and validators are the 2 key concepts of this type system.  A validator uses a type to raise an error when input is non conforming.  A coercer uses the same type info to try to convert the data into a valid input form.  The c keyword applies a coercer adverb.  The cp adverb coerces while leaving a trace message.  The v keyword takes the same inputs as c and cp and applies a validation adverb (raises error if fails).  the vb adverb returns a list of booleans signalling pass/fail for each item.  The vbs adverb selects only the items that passed (without any coercion on fails) to provide to the function, and so every type you define can also be used as a filter, and while all J functions have an intrinsic map (from functional programming) capcity, typed J functions can gain instrinsic filter map capacity.

A cute variation on validators is the iv adverb which instead of raising an error, pops up an inputbox where the user can correct the input (title of type, message of errortext, and value of raw input).  Verb versions of all of these adverbs exist.  Another cute verb is ci, which will bring up an input box for any values that it will coerce, and let the user change the value prior to automatic coercion.

** vm mode (functional errors) **

f 'type' vm uses a "maybe/option" type for dealing with errors.  function results are either the result, the type mismatch, or other error raised by the function.  Helper adverbs exist to deal with "maybe types" or even mixed and matched maybe and raw types.  There is a choice to deal with errors at infinite rank (return error if any value fails) or at the item rank (process each item and return either result or error in boxed form).  Multiple failed validations and errors are also supported.  Run vmtest '' for an illustration of this mode.

This is similar to Haskell/Rust error system.  Except it is much cleaner in that all error handling is dealt with in the function definition header.  All of the coercers and validators can be applied to functions that don't need to be concerned with types.

** Defining types **

Types have 4 fields defined in a data driven tab delimited part of code. The fields are:

Type name, coercion function to be applied if validation test fails, validation test, and error text to raise if not coerced.

The full power of J can be used to define the middle 2 functions.  Though there is a bug in using multiline explicit functions in connection with my code.

**using system**

the typesys_test file has a toy class that adds custom types to only its own private class (in addition to core typesys type definitions).  The only setup to use with your own class (including base)

require jpath '~/typesys.ijs'  NB. assumes location to be home directory
coinsert 'typesys'  NB. inside a locale you want to use type system

after loading typesys_test.ijs, run

test ''  
testC ''  
vmtest ''  

The commands will display many examples of the type system in a hopefully easy to follow way.


**2 ways to turn type system on and off**

1. There is a  shaddow name for c and v.  It is t.  You can globally redefine t to any type processing function including a special function called off that bypasses any type checks.  You can also use off to merely have the commenting value of type annotations, or as a placeholder to apply types you have yet to define.

2. by removing/adding a comment to the header.  For instance the type checked test function's header is:
 
        NB. function with type anotation: takes 2 item items, with one string, and one Farenheit temperature. Makes sure to fail if not 2 items per item

        testf =: [: 3 : 0 ( 'str';'inCelcius inFaren2') cV_temperature_  each '2&count' v_temperature_ "1 ]

to turn off the type interactions (perhaps to rule out errors) the following comment edit can be applied:
        
        testf =: [: 3 : 0 ]   NB.           ( 'str';'inCelcius inFaren2') cV_temperature_  each '2&count' v_temperature_ "1 ]
        
that edit (and original) also gives the function protection from domain errors if called dyadically.        

**understanding the code**

the type system uses an advanced J feature of returning an adverb from the c and v adverbs.

'num' c       NB. returns adverb.  Needs verb parameter  
+/ 'num' c    NB. this is now a verb.  Sum with type coercion to numeric.  Means you can assign this to a name as a verb.  
+/ 'num' c  '1 2 3'   NB. will return numeric value 6. verb applied to noun returns noun.  
2 +/ 'num' c  '1 2 3' NB. returns 3 4 5.  Above verb is ambivalent verb.  Though in this version only y argument is coerced.
'2' +/&('num'&cV)  '1 2 3'  NB. returns same as above but coerces both arguments. 

cV and vV are the verb equivalents to the adverb forms.  The adverb form is sometimes cleaner in simple cases, and sometimes the binding to a compound verb phrase is wanted.


**limitations**

parameterized types are limited to either several numeric parameters or a single text parameter. Based on J's ;: parsing of words.  so.

'num 1 2 3&myptype' NB. ok. 1 2 3 is parameter to myptype  
'num str mypar&myptype'  NB. ok as long as mypar was the only parameter to myptype you wanted to pass.  num and str are other types.



