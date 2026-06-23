"! @testing ZCL_UTESTHELP_DOMCONSTANT_TEST
CLASS ltc_test DEFINITION
  INHERITING FROM zcl_utesthelp_domconstant_test
  CREATE PUBLIC
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PROTECTED SECTION.
    METHODS get_class_name REDEFINITION.
ENDCLASS.


CLASS ltc_test IMPLEMENTATION.
  METHOD get_class_name.
    DATA lo_constant_class TYPE REF TO zcl_utesthelp_itest_domconst.
    rv_result = determine_class_name_from_type( lo_constant_class ).
  ENDMETHOD.
ENDCLASS.
