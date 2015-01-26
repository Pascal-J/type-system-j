# type-system-j
adds an optional type system to J language

to use, put all files in home folder.  If placing them elsewhere, change paths for require lines.  typesys_test file will load all of the other files.


The benefits of type system include

* catch errors in parts of a program due to changes in another part
* document use of functions
* Help compiler optimize code

Nice to have features that this J system provides are:

**Type system should be optional**

regardless of above advantages, optional typing allows quicker to write and shorter programs.

**Type system should be user defined**

regardless of compiler advantages a function can be defined to operate on any number.  Not just a specific narrow type of number.  A function that takes a point should be able to take any pair of numbers.

**Type system should be able to validate whole arguments (record validation vs field validation)**

A type system exists primarily to validate input, and so some type validations should also operate on the entire parameters.  For example, ensuring/enforcing an argument count, or ensuring parameters are a sorted list.

**Type system should be useable to coerce input rather just raise errors**

Just as types can be too inconvenient to use because they too narrowly confine input, they become vastly more convenient if you can use the same type annotation as a way to automatically convert/coerce "bad" input.  A type system can be used to make dynamic languages more dynamic or more strict, by using the type system the way you prefer.

**Type system should allow parameterization**

A parameterized type is a type that takes a parameter.  '2&count' is a type that validates the function as having 2 parameters.  '0 255&inrange' takes 2 parameters and ensures that a field is within the range of 0 to 255.  Parameterized types allow for much fewer type definitions.

**Type system should allow compounding**
The type 'num 0 255&inrange' is a compound type that if it is in coercion mode, will first coerce the field to numeric, and then coerce it to be in range of 0 to 255.  In the typesys_test.ijs file is a toy sample class to work with temperature data.
The compound type 'inCelcius inFaren2' converts text data into numbers representing Celcius temperatures, and then inFaren2 is a simple function to convert Celcius numbers to Farenheit numbers.  Compound types allow coercion chains where rightmost elements can depend on left coercions for their input format.  In the latter case the function expects to receive Celcius temperatures but will work with farenheit temperatures.

# Using the type system

Coercers and validators are the 2 key concepts of this type system.  A validator uses a type to raise an error when input is non conforming.  A coercer uses the same type info to try to convert the data into a valid input form.  The c keyword applies a coercer adverb.  The v keyword takes the same inputs and applies a validation adverb.

Some cute variations on validators are the iv adverb which instead of raising an error, pops up an inputbox where the user can correct the input (title of type, message of errortext, and value of raw input).  Verb versions of all of these adverbs exist.  Another cute verb is ci, which will bring up an input box for any values that it will coerce, and let the user change the value prior to automatic coercion.

** Defining types **

Types have 4 fields defined in a data driven tab delimited part of code. The fields are:

Type name, coercion function to be applied if validation test fails, validation test, and error text to raise if not coerced.

The full power of J can be used to define the middle 2 functions.  Though there is a bug in using multiline explicit functions in connection with my code.

**using system**

the typesys_test file has a toy class that adds custom types to only its own private class (in addition to core typesys type definitions).  The only setup to use with your own class (including base)

require jpath '~/typesys.ijs'  NB. assumes location to be home directory
coinsert 'typesys'  NB. inside a locale you want to use type system

**2 ways to turn type system on and off**

1. You could define 2 shaddow names for c and v.  Say C and V.  You can globally redefine C and V from c and v when you want to turn on C and V type checking/coercion, and to noP (no op) when you want to turn it off.

2. by removing/adding a comment header.  For instance the type checked test function's header is:
        NB. function with type anotation: takes 2 item items, with one string, and one Farenheit temperature. Makes sure to fail if not 2 items per item
        testf =: [: 3 : 0 ( 'str';'inCelcius inFaren2') cV_temperature_  each '2&count' v_temperature_ "1 ]

to turn off the type interactions (perhaps to rule out errors) the following comment edit can be applied:
        
        testf =: [: 3 : 0 ]   NB.           ( 'str';'inCelcius inFaren2') cV_temperature_  each '2&count' v_temperature_ "1 ]
