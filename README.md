# UTESTHELP - Unit test helpers

This repository contains helpful classes for your unit tests.

## Test class for domain constant classes 

Class `ZCL_UTESTHELP_DOMCONSTANT_TEST` as a parent class for your domain constant class unit tests.

It has test methods to verify the integrity of your constant class:

* Verify all constants are found in the domain fix values
* Verify each domain fix value has a constant
* Verify the constant values do not repeat
* Verify the class is abstract
* Verify all constants have the same type

### What's a domain constant class?

A domain constant class contains constants for each value of a domain. 

Please refer to the approriate section in the [Clean ABAP styleguide](https://github.com/SAP/styleguides/blob/93499d0/clean-abap/sub-sections/Enumerations.md) for more details on the subject.

A constant class for the domain `DDISGN` might look like this:

````abap
CLASS zcl_ddsign_constant_class DEFINITION
  PUBLIC
  FINAL
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS included TYPE ddsign VALUE 'I'.
    CONSTANTS excluded TYPE ddsign VALUE 'E'.
ENDCLASS.
````

### How to use 

Simply inherit your test class from this class and implement method `GET_CLASS_NAME`.

You can use method `DETERMINE_CLASS_NAME_FROM_TYPE` to do this dynamically without hard-coding the name of the class:

````abap
CLASS ltc_example_inheritor DEFINITION CREATE PUBLIC
 FOR TESTING
 RISK LEVEL HARMLESS
 DURATION SHORT
 INHERITING FROM zcl_utesthelp_domconstant_test.

  PROTECTED SECTION.
    METHODS get_class_name REDEFINITION.
ENDCLASS.


CLASS ltc_example_inheritor IMPLEMENTATION.
  METHOD get_class_name.
    DATA lo_constant_class TYPE REF TO lcl_example_constant_class.
    rv_result = determine_class_name_from_type( lo_constant_class ).
  ENDMETHOD.
ENDCLASS.
````

### Credit

`ZCL_UTESTHELP_DOMCONSTANT_TEST` was inspired by an example from the [Clean ABAP styleguide](https://github.com/SAP/styleguides/blob/93499d0/clean-abap/sub-sections/Enumerations.md#prefer-classes-to-interfaces).

## Test double utility class

Class `ZCL_UTESTHELP_TEST_DOUBLE_UTIL` offers reusable functionality for the standard test double framework (`CL_ABAP_TESTDOUBLE`).

Method `CREATE_TEST_DOUBLE` can be used to create a test double without explicitly passing in the name of the required interface or class.
This allows you to rename your objects without having to manually adjust the object names in the tests.

Example:

````abap
DATA lo_double TYPE REF TO zif_example. 
lo_double ?= zcl_utesthelp_test_double_util=>create_test_double( lo_double ).
````

Instead of this:

````abap
DATA lo_double TYPE REF TO zif_example.
lo_double ?= cl_abap_testdouble=>create( 'zif_example' ).
````

## Contributing

If you want to contribute to this repository, please use [my recommended ABAP Cleaner Profile](https://github.com/ConjuringCoffee/abap-cleaner-recommendation).
Pull requests are welcome.

## Sponsor

Work on this repository was sponsored by [Endress+Hauser InfoServe GmbH+Co. KG](https://www.endress.com/).