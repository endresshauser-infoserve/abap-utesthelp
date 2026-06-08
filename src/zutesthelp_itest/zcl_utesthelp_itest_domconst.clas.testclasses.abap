"! Test using the global constant class
"! @testing ZCL_UTESTHELP_DOMCONSTANT_TEST
CLASS ltc_global_const DEFINITION
  INHERITING FROM zcl_utesthelp_domconstant_test
  CREATE PUBLIC
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PROTECTED SECTION.
    METHODS get_class_name REDEFINITION.
ENDCLASS.


CLASS ltc_global_const IMPLEMENTATION.
  METHOD get_class_name.
    DATA lo_constant_class TYPE REF TO zcl_utesthelp_itest_domconst.
    rv_result = determine_class_name_from_type( lo_constant_class ).
  ENDMETHOD.
ENDCLASS.


CLASS lcl_itest_local_const DEFINITION
  ABSTRACT
  FINAL
  CREATE PUBLIC
  FOR TESTING.

  PUBLIC SECTION.
    CONSTANTS value_a TYPE zutesthelp_itest_dtel1 VALUE 'A'.
    CONSTANTS value_b TYPE zutesthelp_itest_dtel1 VALUE 'B'.
ENDCLASS.


CLASS lcl_itest_local_const IMPLEMENTATION.
ENDCLASS.

"! Test using the local constant class
"! @testing ZCL_UTESTHELP_DOMCONSTANT_TEST
CLASS ltc_local_const DEFINITION
  INHERITING FROM zcl_utesthelp_domconstant_test
  CREATE PUBLIC
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PROTECTED SECTION.
    METHODS get_class_name REDEFINITION.
ENDCLASS.


CLASS ltc_local_const IMPLEMENTATION.
  METHOD get_class_name.
    DATA lo_constant_class TYPE REF TO lcl_itest_local_const.
    rv_result = determine_class_name_from_type( lo_constant_class ).
  ENDMETHOD.
ENDCLASS.
