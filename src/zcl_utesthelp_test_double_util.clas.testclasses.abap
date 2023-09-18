CLASS ltc_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS happy_path FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltc_test IMPLEMENTATION.
  METHOD happy_path.
    " Given
    DATA lo_double TYPE REF TO if_serializable_object.

    " When
    lo_double ?= zcl_utesthelp_test_double_util=>create_test_double( lo_double ).

    " Then
    cl_abap_unit_assert=>assert_bound( lo_double ).
  ENDMETHOD.
ENDCLASS.
