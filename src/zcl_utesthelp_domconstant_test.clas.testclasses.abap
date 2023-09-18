CLASS lcl_example_constant_class DEFINITION
  FINAL
  ABSTRACT
  CREATE PUBLIC
  FOR TESTING.

  PUBLIC SECTION.
    CONSTANTS included TYPE ddsign VALUE 'I'.
    CONSTANTS excluded TYPE ddsign VALUE 'E'.
ENDCLASS.


CLASS lcl_example_constant_class IMPLEMENTATION.
ENDCLASS.


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
