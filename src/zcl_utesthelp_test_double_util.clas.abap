"! <p class="shorttext synchronized">Custom utility class for standard test double framwork</p>
"! <p>
"! This class is part of an open-source repository managed via abapGit.
"! </p>
"! <p>
"! SPDX-License-Identifier: MIT
"! </p>
CLASS zcl_utesthelp_test_double_util DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  FOR TESTING.

  PUBLIC SECTION.
    "! <p class="shorttext synchronized">Create a test double dynamically</p>
    "! <p>
    "! SAP standard requires you to name the class or interface you want to use.
    "! This method dynamically reads the name from the variable you pass into I_TYPED_VARIABLE.
    "! This works even if I_TYPED_VARIABLE is not bound.
    "! </p>
    "! <p>
    "! Please see the documentation of method CREATE in CL_ABAP_TESTDOUBLE for more general details.
    "! </p>
    "! @parameter i_typed_variable | <p class="shorttext synchronized"></p>
    "! @parameter ro_result | <p class="shorttext synchronized">
    CLASS-METHODS create_test_double
      IMPORTING
        i_typed_variable TYPE data
      RETURNING
        VALUE(ro_result) TYPE REF TO object.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_utesthelp_test_double_util IMPLEMENTATION.
  METHOD create_test_double.
    DATA(lo_type_description) = CAST cl_abap_refdescr( cl_abap_typedescr=>describe_by_data( i_typed_variable ) ).
    DATA(lv_relative_name) = lo_type_description->get_referenced_type( )->get_relative_name( ).

    ro_result = cl_abap_testdouble=>create( CONV #( lv_relative_name ) ).
  ENDMETHOD.
ENDCLASS.
