"! <p class="shorttext synchronized">Reusable unit test for constant classes of domains</p>
"! <p>
"! Simply inherit your test class from this class and implement method GET_CLASS_NAME.
"! You can use method DETERMINE_CLASS_NAME_FROM_TYPE to do this dynamically.
"! </p>
"! <p>
"! This class is part of an open-source repository managed via abapGit.
"! </p>
"! <p>
"! SPDX-License-Identifier: MIT
"! </p>
CLASS zcl_utesthelp_domconstant_test DEFINITION
  PUBLIC
  CREATE PUBLIC
  ABSTRACT
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PROTECTED SECTION.
    "! <p class="shorttext synchronized">Each domain fix value must have a constant in the class</p>
    METHODS all_domain_values_as_constants FOR TESTING.

    "! <p class="shorttext synchronized">Each constant must have a fix value in the comain</p>
    METHODS all_constants_found_in_domain FOR TESTING.

    "! <p class="shorttext synchronized">One value is not found in multiple constants.</p>
    "! <p>If it is, then a copy-paste mistake was likely made.</p>
    METHODS constant_values_do_not_repeat FOR TESTING.

    "! <p class="shorttext synchronized">A constant class must be astract</p>
    METHODS class_is_abstract FOR TESTING.

    "! <p class="shorttext synchronized">All constants must use the same type</p>
    METHODS all_constants_have_same_type FOR TESTING.

    METHODS get_class_name ABSTRACT
      RETURNING
        VALUE(rv_result) TYPE string.

    "! <p class="shorttext synchronized">Determine the class name from a variable of the class' type.</p>
    "! <p>
    "! Use this method in your implementation of GET_CLASS_NAME if you don't want to hard-code the name.
    "! </p>
    "! @parameter i_variable   | <p class="shorttext synchronized">Instance variable of the constant class</p>
    "! <p>Does not have to be bound.</p>
    "! @parameter rv_result | <p class="shorttext synchronized"></p>
    METHODS determine_class_name_from_type
      IMPORTING
        i_variable       TYPE data
      RETURNING
        VALUE(rv_result) TYPE string.

  PRIVATE SECTION.
    DATA mo_helper TYPE REF TO lcl_helper.
    DATA mv_class_name TYPE string.
    DATA mt_domain_values TYPE STANDARD TABLE OF dd07v.
    DATA mt_constants TYPE abap_attrdescr_tab.
    DATA mv_domain_name TYPE domname.

    METHODS setup.

    METHODS get_attribute_value
      IMPORTING
        iv_attribute_name TYPE abap_attrname
      RETURNING
        VALUE(rv_result)  TYPE string.
ENDCLASS.


CLASS zcl_utesthelp_domconstant_test IMPLEMENTATION.
  METHOD setup.
    mo_helper = NEW #( ).
    mv_class_name = get_class_name( ).

    mt_constants = mo_helper->determine_constants( mv_class_name ).

    mv_domain_name = mo_helper->determine_domain_name( iv_class_name = mv_class_name
                                                       is_constant   = mt_constants[ 1 ] ).

    mt_domain_values = mo_helper->determine_domain_values( mv_domain_name ).
  ENDMETHOD.

  METHOD all_constants_found_in_domain.
    LOOP AT mt_constants ASSIGNING FIELD-SYMBOL(<ls_constant>).
      DATA(lv_value) = get_attribute_value( <ls_constant>-name ).

      IF NOT line_exists( mt_domain_values[ domvalue_l = lv_value ] ).
        cl_abap_unit_assert=>fail( |Value { <ls_constant>-name } not found in domain fix values| ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD class_is_abstract.
    DATA(lo_class_description) = CAST cl_abap_classdescr( cl_abap_typedescr=>describe_by_name( mv_class_name ) ).

    cl_abap_unit_assert=>assert_equals( exp = cl_abap_classdescr=>classkind_abstract
                                        act = lo_class_description->class_kind ).
  ENDMETHOD.

  METHOD all_domain_values_as_constants.
    LOOP AT mt_domain_values ASSIGNING FIELD-SYMBOL(<ls_domain_value>).
      DATA(lv_value_found) = abap_false.

      LOOP AT mt_constants ASSIGNING FIELD-SYMBOL(<ls_constant>).
        DATA(lv_value) = get_attribute_value( <ls_constant>-name ).

        IF <ls_domain_value>-domvalue_l = lv_value.
          lv_value_found = abap_true.
          EXIT.
        ENDIF.
      ENDLOOP.

      cl_abap_unit_assert=>assert_true(
          act = lv_value_found
          msg = |Domain value { <ls_domain_value>-domvalue_l } not found as constant| ).
    ENDLOOP.
  ENDMETHOD.

  METHOD constant_values_do_not_repeat.
    DATA lt_values TYPE TABLE OF string.

    LOOP AT mt_constants ASSIGNING FIELD-SYMBOL(<ls_constant>).
      DATA(lv_value) = get_attribute_value( <ls_constant>-name ).

      cl_abap_unit_assert=>assert_table_not_contains( line  = lv_value
                                                      table = lt_values
                                                      msg   = |Value { lv_value } was used in multiple constants| ).

      INSERT lv_value INTO TABLE lt_values.
    ENDLOOP.
  ENDMETHOD.

  METHOD all_constants_have_same_type.
    LOOP AT mt_constants ASSIGNING FIELD-SYMBOL(<ls_constant>).
      DATA(lv_domain_value) = mo_helper->determine_domain_name( iv_class_name = mv_class_name
                                                                is_constant   = <ls_constant> ).

      cl_abap_unit_assert=>assert_equals( exp = mv_domain_name
                                          act = lv_domain_value
                                          msg = |Constant { <ls_constant>-name } must have the type { mv_domain_name }| ).
    ENDLOOP.
  ENDMETHOD.

  METHOD get_attribute_value.
    ASSIGN (mv_class_name)=>(iv_attribute_name) TO FIELD-SYMBOL(<l_value>).
    cl_abap_unit_assert=>assert_subrc( ).
    rv_result = <l_value>.
  ENDMETHOD.

  METHOD determine_class_name_from_type.
    DATA(lo_type_description) = CAST cl_abap_refdescr( cl_abap_typedescr=>describe_by_data( i_variable ) ).
    rv_result = lo_type_description->get_referenced_type( )->get_relative_name( ).
  ENDMETHOD.
ENDCLASS.
